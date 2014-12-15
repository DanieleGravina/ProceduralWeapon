/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_NightShade extends UTStealthVehicle
	native(Vehicle)
	abstract;

/* Control visible dust underneath the nightshade */
var ParticleSystemComponent HoverDustPSC;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * function cloaks or decloaks the vehicle.
 */
simulated function Cloak(bool bIsEnabled, optional bool bForce=FALSE)
{
	if (bIsEnabled && Role == ROLE_Authority && DeployedState != EDS_Undeployed)
		return;

	super.Cloak(bIsEnabled, bForce);

	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		if (!bIsEnabled && bDriving)
		{
			//This param relates to back<->fwd movement (-5,0,5)
			//since the Nightshade is only visible while deployed
			//and not moving, 0 seems appropriate always
			HoverDustPSC.SetFloatParameter('Direction',0);
			HoverDustPSC.ActivateSystem();
		}
		else
		{
			HoverDustPSC.DeactivateSystem();
		}
	}
}

/**
 * Called when the vehicle is destroyed.  Clean up the seats/effects/etc
 */
simulated function Destroyed()
{
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		HoverDustPSC.DeactivateSystem();
	}
	super.Destroyed();
}

defaultproperties
{
   VisibleGroundSpeed=900.000000
   VisibleAirSpeed=1000.000000
   VisibleMaxSpeed=1300.000000
   CloakedSpeedModifier=0.450000
   SlowSpeed=300.000000
   DeployCheckDistance=375.000000
   MaxDeploySpeed=500.000000
   bRequireAllWheelsOnGround=False
   bStickDeflectionThrottle=True
   bReducedFallingCollisionDamage=True
   bStealthVehicle=True
   bIsNecrisVehicle=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTStealthVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTStealthVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   ObjectiveGetOutDist=1500.000000
   HornIndex=2
   VehicleIndex=7
   VehiclePositionString="In un Nightshade"
   VehicleNameString="Nightshade"
   NeedToPickUpAnnouncement=(AnnouncementText="Controlla il Nightshade")
   SpawnRadius=125.000000
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=60.000000)
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
      MaxThrustForce=600.000000
      MaxReverseForce=600.000000
      LongDamping=0.300000
      MaxStrafeForce=600.000000
      LatDamping=1.200000
      UpDamping=0.700000
      TurnTorqueFactor=4500.000000
      TurnTorqueMax=1500.000000
      TurnDamping=0.500000
      MaxYawRate=1.600000
      PitchTorqueMax=35.000000
      PitchDamping=0.100000
      RollTorqueMax=50.000000
      RollDamping=0.100000
      RandForceInterval=1000.000000
      bFullThrustOnDirectionChange=True
      bStabilizeStops=True
      WheelSuspensionStiffness=50.000000
      WheelSuspensionDamping=1.000000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=LFThruster ObjName=LFThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Base"
      BoneOffset=(X=120.000000,Y=80.000000,Z=-200.000000)
      WheelRadius=20.000000
      SuspensionTravel=120.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="LFThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(0)=LFThruster
   Begin Object Class=UTHoverWheel Name=RFThruster ObjName=RFThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Base"
      BoneOffset=(X=120.000000,Y=-80.000000,Z=-200.000000)
      WheelRadius=20.000000
      SuspensionTravel=120.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="RFThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(1)=RFThruster
   Begin Object Class=UTHoverWheel Name=LRThruster ObjName=LRThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Base"
      BoneOffset=(X=-120.000000,Y=80.000000,Z=-200.000000)
      WheelRadius=20.000000
      SuspensionTravel=120.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="LRThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(2)=LRThruster
   Begin Object Class=UTHoverWheel Name=RRThruster ObjName=RRThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Base"
      BoneOffset=(X=-120.000000,Y=-80.000000,Z=-200.000000)
      WheelRadius=20.000000
      SuspensionTravel=120.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="RRThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(3)=RRThruster
   COMOffset=(X=0.000000,Y=0.000000,Z=-55.000000)
   bStayUpright=True
   bCanFlip=True
   StayUprightRollResistAngle=5.000000
   StayUprightPitchResistAngle=5.000000
   StayUprightStiffness=2000.000000
   StayUprightDamping=20.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_6 ObjName=MyStayUprightSetup_6 Archetype=RB_StayUprightSetup'UTGame.Default__UTStealthVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_6"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTStealthVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_NightShade:MyStayUprightSetup_6'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_6 ObjName=MyStayUprightConstraintInstance_6 Archetype=RB_ConstraintInstance'UTGame.Default__UTStealthVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_6"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTStealthVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_NightShade:MyStayUprightConstraintInstance_6'
   MaxSpeed=1300.000000
   UprightLiftStrength=500.000000
   UprightTorqueStrength=400.000000
   bTurnInPlace=True
   bSeparateTurretFocus=True
   bCanStrafe=True
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
   Name="Default__UTVehicle_NightShade"
   ObjectArchetype=UTStealthVehicle'UTGame.Default__UTStealthVehicle'
}
