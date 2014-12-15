/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_StealthBender extends UTStealthVehicle
	native(Vehicle)
	abstract;

/** One material for each team on the 'tail' section of the stealthbender */
var MaterialInterface SecondaryTeamSkins[2];

simulated event PostBeginPlay()
{
	super.PostBeginPlay();
	PlayVehicleAnimation('Inactive');
}

simulated function CreateDamageMaterialInstance()
{
	//Damaged MIC for the 'tail'
	DamageMaterialInstance[1] = Mesh.CreateAndSetMaterialInstanceConstant(1);
	super.CreateDamageMaterialInstance();
}

/**
* This function returns the aim for the weapon
* overloaded here to take into account the stealthbender turret is not near the camera
*/
function rotator GetWeaponAim(UTVehicleWeapon VWeapon)
{
	local vector SocketLocation, CameraLocation, RealAimPoint, DesiredAimPoint, HitLocation, HitRotation, DirA, DirB;
	local rotator CameraRotation, SocketRotation, ControllerAim, AdjustedAim;
	local float DiffAngle, MaxAdjust;
	local Controller C;
	local PlayerController PC;
	local Quat Q;

	if ( VWeapon != none )
	{
		C = Seats[VWeapon.SeatIndex].SeatPawn.Controller;

		PC = PlayerController(C);
		if (PC != None)
		{
			PC.GetPlayerViewPoint(CameraLocation, CameraRotation);
			DesiredAimPoint = CameraLocation + Vector(CameraRotation) * 2.0 * VWeapon.GetTraceRange();
			if (Trace(HitLocation, HitRotation, DesiredAimPoint, CameraLocation) != None)
			{
				DesiredAimPoint = HitLocation;
			}
		}
		else if (C != None)
		{
			DesiredAimPoint = C.FocalPoint;
		}

		if ( Seats[VWeapon.SeatIndex].GunSocket.Length>0 )
		{
			GetBarrelLocationAndRotation(VWeapon.SeatIndex, SocketLocation, SocketRotation);
			if(VWeapon.bIgnoreSocketPitchRotation || ((DesiredAimPoint.Z - Location.Z)<0 && VWeapon.bIgnoreDownwardPitch))
			{
				SocketRotation.Pitch = Rotator(DesiredAimPoint - Location).Pitch;
			}
		}
		else
		{
			SocketLocation = Location;
			SocketRotation = Rotator(DesiredAimPoint - Location);
		}

		RealAimPoint = SocketLocation + Vector(SocketRotation) * VWeapon.GetTraceRange();
		DirA = normal(DesiredAimPoint - SocketLocation);
		DirB = normal(RealAimPoint - SocketLocation);
		DiffAngle = ( DirA dot DirB );
		MaxAdjust = VWeapon.GetMaxFinalAimAdjustment();
		if ( DiffAngle >= MaxAdjust )
		{
			// bit of a hack here to make bot aiming and single player autoaim work
			ControllerAim = (C != None) ? C.Rotation : Rotation;
			AdjustedAim = VWeapon.GetAdjustedAim(SocketLocation);
			if (AdjustedAim == VWeapon.Instigator.GetBaseAimRotation() || AdjustedAim == ControllerAim)
			{
				// no adjustment
				return rotator(DesiredAimPoint - SocketLocation);
			}
			else
			{
				// FIXME: AdjustedAim.Pitch = Instigator.LimitPitch(AdjustedAim.Pitch);
				return AdjustedAim;
			}
		}
		else
		{
			Q = QuatFromAxisAndAngle(Normal(DirB cross DirA), ACos(MaxAdjust));
			return Rotator( QuatRotateVector(Q,DirB));
		}
	}
	else
	{
		return Rotation;
	}
}

/**
 * function cloaks or decloaks the vehicle.
 */
simulated function ToggleCloak()
{
	//Cloak the tail piece of the vehicle
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		// cloaking!
		if(bIsVehicleCloaked && Mesh.Materials[1] != CloakedBodyMIC)
		{
			//Same material as the main body
			Mesh.SetMaterial(1, CloakedBodyMIC);
			UpdateShadowSettings( FALSE );
			DynamicLightEnvironmentComponent(Mesh.LightEnvironment).bCastShadows = FALSE;
		}
		// decloaking
		else if(!bIsVehicleCloaked && Mesh.Materials[1] != DamageMaterialInstance[1])
		{
			//Back to secondary material for the tail
			Mesh.SetMaterial(1, DamageMaterialInstance[1]);
			UpdateShadowSettings(!class'Engine'.static.IsSplitScreen() && class'UTPlayerController'.Default.PawnShadowMode == SHADOW_All);
			DynamicLightEnvironmentComponent(Mesh.LightEnvironment).bCastShadows = TRUE;
		}
	}

	super.ToggleCloak();
}


/** Override set inputs so get direct information when deployed. */
simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
	if(IsDeployed())
	{
		Super(Vehicle).SetInputs(InForward,InStrafe,InUp);
	}
	else
	{
		Super(UTVehicle).SetInputs(InForward,InStrafe,InUp);
	}
}


simulated function TeamChanged()
{
	local MaterialInterface NewMaterial;

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		if (Team < 2 && SecondaryTeamSkins[Team] != None)
		{
			NewMaterial = SecondaryTeamSkins[Team];
		}
		else if (SecondaryTeamSkins[0] != None)
		{
			NewMaterial = SecondaryTeamSkins[0];
		}

		//Always reparent the DamageMIC
		if (NewMaterial != None)
		{
			if (DamageMaterialInstance[1] != None)
			{
				DamageMaterialInstance[1].SetParent(NewMaterial);
			}
		}

		//If we aren't cloaked, set the 'visible' skin
		if(Mesh.Materials[1] != CloakedBodyMIC)
		{
			Mesh.SetMaterial(1, DamageMaterialInstance[1]);
		}
	}

	super.TeamChanged();
}

defaultproperties
{
   VisibleGroundSpeed=900.000000
   VisibleAirSpeed=1000.000000
   VisibleMaxSpeed=1300.000000
   CloakedSpeedModifier=0.450000
   SlowSpeed=300.000000
   DeployCheckDistance=375.000000
   bStickDeflectionThrottle=True
   bLookSteerOnNormalControls=True
   bLookSteerOnSimpleControls=True
   bReducedFallingCollisionDamage=True
   DeflectionReverseThresh=-0.300000
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTStealthVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTStealthVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   ObjectiveGetOutDist=1500.000000
   HornIndex=1
   VehicleIndex=12
   LookSteerSensitivity=2.200000
   LookSteerDamping=0.040000
   ConsoleSteerScale=0.900000
   StolenAnnouncementIndex=5
   VehiclePositionString="in uno Stealthbender"
   VehicleNameString="Stealth Bender"
   NeedToPickUpAnnouncement=(AnnouncementText="Controlla lo Stealthbender")
   SpawnRadius=125.000000
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=60.000000)
   Begin Object Class=UTVehicleSimHellbender Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHellbender'UTGame.Default__UTVehicleSimHellbender'
      Name="SimObject"
      ObjectArchetype=UTVehicleSimHellbender'UTGame.Default__UTVehicleSimHellbender'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleHellbenderWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
      SkelControlName="Rt_Rear_Control"
      BoneName="Rt_Rear_Tire"
      BoneOffset=(X=0.000000,Y=42.000000,Z=0.000000)
      LatSlipFactor=2.000000
      Name="RRWheel"
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
      SkelControlName="Lt_Rear_Control"
      BoneName="Lt_Rear_Tire"
      BoneOffset=(X=0.000000,Y=-42.000000,Z=0.000000)
      LatSlipFactor=2.000000
      Name="LRWheel"
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
   End Object
   Wheels(1)=LRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
      SteerFactor=1.000000
      SkelControlName="RT_Front_Control"
      BoneName="Rt_Front_Tire"
      BoneOffset=(X=0.000000,Y=42.000000,Z=0.000000)
      LatSlipFactor=2.000000
      HandbrakeLongSlipFactor=0.800000
      HandbrakeLatSlipFactor=0.800000
      Name="RFWheel"
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
      SteerFactor=1.000000
      SkelControlName="Lt_Front_Control"
      BoneName="Lt_Front_Tire"
      BoneOffset=(X=0.000000,Y=-42.000000,Z=0.000000)
      LatSlipFactor=2.000000
      HandbrakeLongSlipFactor=0.800000
      HandbrakeLatSlipFactor=0.800000
      Name="LFWheel"
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicleHellbenderWheel'
   End Object
   Wheels(3)=LFWheel
   COMOffset=(X=0.000000,Y=0.000000,Z=-55.000000)
   bCanFlip=True
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_7 ObjName=MyStayUprightSetup_7 Archetype=RB_StayUprightSetup'UTGame.Default__UTStealthVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_7"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTStealthVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_StealthBender:MyStayUprightSetup_7'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_7 ObjName=MyStayUprightConstraintInstance_7 Archetype=RB_ConstraintInstance'UTGame.Default__UTStealthVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_7"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTStealthVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_StealthBender:MyStayUprightConstraintInstance_7'
   HeavySuspensionShiftPercent=0.200000
   MaxSpeed=1300.000000
   UprightLiftStrength=500.000000
   UprightTorqueStrength=400.000000
   bSeparateTurretFocus=True
   bHasHandbrake=True
   MomentumMult=1.000000
   NonPreferredVehiclePathMultiplier=2.000000
   GroundSpeed=900.000000
   AirSpeed=1000.000000
   BaseEyeHeight=0.000000
   EyeHeight=0.000000
   Health=600
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTStealthVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTStealthVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTStealthVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTStealthVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   ViewPitchMin=-13000.000000
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_StealthBender"
   ObjectArchetype=UTStealthVehicle'UTGame.Default__UTStealthVehicle'
}
