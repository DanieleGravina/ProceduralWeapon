/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicle_Goliath extends UTVehicle
	native(Vehicle)
	abstract;

var protected MaterialInstanceConstant LeftTreadMaterialInstance, RightTreadMaterialInstance, LeftTeamMaterials[2], RightTeamMaterials[2];
/** material parameter controlling tread panner speed */
var name TreadSpeedParameterName;

var repnotify	rotator	GunnerWeaponRotation;
var	repnotify	vector	GunnerFlashLocation;

var name LeftBigWheel, LeftSmallWheels[3];
var name RightBigWheel, RightSmallWheels[3];

/** ambient sound component for machine gun */
var AudioComponent MachineGunAmbient;

/** Sound to play when maching gun stops firing. */
var SoundCue MachineGunStopSound;

var AudioComponent	TrackSound;
var float			TrackSoundParamScale;

var name			VolumeParamName;
var name			PitchParamName;

var float LeftTreadSpeed, RightTreadSpeed;

var SkeletalMeshComponent AntennaMesh;

/** The Cantilever Beam that is the Antenna itself*/
var UTSkelControl_CantileverBeam AntennaBeamControl;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if (bNetDirty)
		GunnerFlashLocation;
	if (!IsSeatControllerReplicationViewer(1) || bDemoRecording)
		GunnerWeaponRotation;
}

simulated function TeamChanged()
{
	if(LeftTreadMaterialInstance != none)
	{
		LeftTreadMaterialInstance.SetParent(LeftTeamMaterials[Team==1?1:0]);
	}
	if(RightTreadMaterialInstance != none)
	{
		RightTreadMaterialInstance.SetParent(RightTeamMaterials[Team==1?1:0]);
	}
	Super.TeamChanged();
}

/** For Antenna delegate purposes (let's turret motion be more dramatic)*/
function vector GetVelocity()
{
	return Velocity;
}

simulated function VehicleWeaponFireEffects(vector HitLocation, int SeatIndex)
{
	Super.VehicleWeaponFireEffects(HitLocation, SeatIndex);

	if (SeatIndex == 1 && !MachineGunAmbient.bWasPlaying)
	{
		MachineGunAmbient.Play();
	}
}

simulated function VehicleWeaponStoppedFiring(bool bViaReplication, int SeatIndex)
{
	if (SeatIndex == 1)
	{
		MachineGunAmbient.Stop();
		PlaySound(MachineGunStopSound, TRUE, FALSE, FALSE, Location, FALSE);
	}
}

simulated function StartEngineSound()
{
	Super.StartEngineSound();

	if(TrackSound != None)
	{
		TrackSound.Play();
	}
}

simulated function StopEngineSound()
{
	Super.StopEngineSound();

	if(TrackSound != None)
	{
		TrackSound.Stop();
	}
}

//=================================
// AI Interface

function bool ImportantVehicle()
{
	return true;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

simulated function GetSVehicleDebug( out Array<String> DebugInfo )
{
    DebugInfo[DebugInfo.Length] = "----Vehicle----: ";
	DebugInfo[DebugInfo.Length] = "Speed: "$VSize(Velocity)$" UUPS -- "$VSize(Velocity) * 0.0426125$" MPH";
	DebugInfo[DebugInfo.Length] = "LeftTrackTorque: "$SVehicleSimTank(SimObj).LeftTrackTorque;
	DebugInfo[DebugInfo.Length] = "RightTrackTorque: "$SVehicleSimTank(SimObj).RightTrackTorque;
	DebugInfo[DebugInfo.Length] = "LeftTrackVel: "$SVehicleSimTank(SimObj).LeftTrackVel;
	DebugInfo[DebugInfo.Length] = "RightTrackVel: "$SVehicleSimTank(SimObj).RightTrackVel;
	DebugInfo[DebugInfo.Length] = "Throttle: "$OutputGas;
	DebugInfo[DebugInfo.Length] = "Steering: "$OutputSteering;
	DebugInfo[DebugInfo.Length] = "Brake: "$OutputBrake;
}

simulated function DisplayWheelsDebug(HUD HUD, float YL)
{
    local int i;
    local vector WorldLoc, ScreenLoc, X, Y, Z, EndPoint, ScreenEndPoint;
    local Color SaveColor;

    SaveColor = HUD.Canvas.DrawColor;

	for (i=0; i<Wheels.Length; i++)
	{
	GetAxes(Rotation, X, Y, Z);
	WorldLoc =  Location + (Wheels[i].WheelPosition >> Rotation);
	ScreenLoc = HUD.Canvas.Project(WorldLoc);
	if (ScreenLoc.X >= 0 &&	ScreenLoc.X < HUD.Canvas.ClipX &&
		ScreenLoc.Y >= 0 && ScreenLoc.Y < HUD.Canvas.ClipY)
    	{
	    // Draw Text
	    HUD.Canvas.SetPos(ScreenLoc.X, ScreenLoc.Y);
	    HUD.Canvas.DrawText("SR "$Wheels[i].LongSlipRatio);

	    // Draw Lines
	    HUD.Canvas.DrawColor = HUD.RedColor;
	    EndPoint = WorldLoc + (Wheels[i].LongImpulse * 100 * Wheels[i].LongDirection) - (Wheels[i].WheelRadius * Z);
	    ScreenEndPoint = HUD.Canvas.Project(EndPoint);
	    DrawDebugLine(WorldLoc - (Wheels[i].WheelRadius * Z), EndPoint, 255, 0, 0);
	    HUD.Canvas.SetPos(ScreenEndPoint.X, ScreenEndPoint.Y);
	    HUD.Canvas.DrawText(Wheels[i].LongImpulse);

	    HUD.Canvas.DrawColor = HUD.GreenColor;
	    EndPoint = WorldLoc + (Wheels[i].LatImpulse * 100 * Wheels[i].LatDirection) - (Wheels[i].WheelRadius * Z);
	    ScreenEndPoint = HUD.Canvas.Project(EndPoint);
	    DrawDebugLine(WorldLoc - (Wheels[i].WheelRadius * Z), EndPoint, 0, 255, 0);
	    HUD.Canvas.SetPos(ScreenEndPoint.X, ScreenEndPoint.Y);
	    HUD.Canvas.DrawText(Wheels[i].LatImpulse);
	}
    }

    HUD.Canvas.DrawColor = SaveColor;
}

defaultproperties
{
   LeftBigWheel="wheel_LHS_01_Cont"
   LeftSmallWheels(0)="wheel_LHS_03_Cont"
   LeftSmallWheels(1)="wheel_LHS_04_Cont"
   LeftSmallWheels(2)="Whell_LHS_06_07_08_Cont"
   RightBigWheel="wheel_RHS_01_Cont"
   RightSmallWheels(0)="wheel_RHS_03_Cont"
   RightSmallWheels(1)="wheel_RHS_04_Cont"
   RightSmallWheels(2)="Wheel_RHS_06_07_08_Cont"
   VolumeParamName="VolumeModulationParam"
   PitchParamName="PitchModulationParam"
   bLookSteerOnSimpleControls=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   MaxDesireability=1.250000
   HornIndex=1
   VehicleIndex=3
   LeftStickDirDeadZone=0.100000
   LookSteerSensitivity=3.000000
   LookSteerDeadZone=0.050000
   ConsoleSteerScale=2.000000
   VehiclePositionString="In un Goliath"
   VehicleNameString="Goliath"
   NeedToPickUpAnnouncement=(AnnouncementText="Equipaggia il Goliath")
   HUDExtent=180.000000
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=130.000000)
   HeroBonus=2.000000
   GreedCoinBonus=6
   Begin Object Class=UTVehicleSimTank Name=SimObject ObjName=SimObject Archetype=UTVehicleSimTank'UTGame.Default__UTVehicleSimTank'
      FrontalCollisionGripFactor=0.180000
      EqualiseTrackSpeed=10.000000
      MaxEngineTorque=7800.000000
      EngineDamping=4.100000
      InsideTrackTorqueFactor=0.250000
      TurnInPlaceThrottle=0.500000
      StopThreshold=50.000000
      WheelSuspensionStiffness=500.000000
      WheelSuspensionDamping=40.000000
      WheelSuspensionBias=0.100000
      WheelLongExtremumSlip=1.500000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimTank'UTGame.Default__UTVehicleSimTank'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bUseMaterialSpecificEffects=True
      EffectDesiredSpinDir=1.000000
      SteerFactor=1.000000
      SkelControlName="wheel_RHS_02_Cont"
      BoneName="wheel_RHS_02"
      BoneOffset=(X=0.000000,Y=20.000000,Z=0.000000)
      WheelRadius=30.000000
      SuspensionTravel=45.000000
      Side=SIDE_Right
      LongSlipFactor=250.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=1000.000000
      Name="RRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleWheel Name=RMWheel ObjName=RMWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      SkelControlName="wheel_RHS_04_Cont"
      BoneName="wheel_RHS_04"
      BoneOffset=(X=-50.000000,Y=20.000000,Z=0.000000)
      WheelRadius=30.000000
      SuspensionTravel=45.000000
      Side=SIDE_Right
      LongSlipFactor=250.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=1000.000000
      Name="RMWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(1)=RMWheel
   Begin Object Class=UTVehicleWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bUseMaterialSpecificEffects=True
      EffectDesiredSpinDir=-1.000000
      SteerFactor=1.000000
      SkelControlName="wheel_RHS_05_Cont"
      BoneName="wheel_RHS_05"
      BoneOffset=(X=0.000000,Y=20.000000,Z=0.000000)
      WheelRadius=30.000000
      SuspensionTravel=45.000000
      Side=SIDE_Right
      LongSlipFactor=250.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=1000.000000
      Name="RFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bUseMaterialSpecificEffects=True
      EffectDesiredSpinDir=1.000000
      SteerFactor=1.000000
      SkelControlName="wheel_LHS_02_Cont"
      BoneName="wheel_LHS_02"
      BoneOffset=(X=0.000000,Y=-20.000000,Z=0.000000)
      WheelRadius=30.000000
      SuspensionTravel=45.000000
      Side=SIDE_Left
      LongSlipFactor=250.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=1000.000000
      Name="LRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(3)=LRWheel
   Begin Object Class=UTVehicleWheel Name=LMWheel ObjName=LMWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      SkelControlName="wheel_LHS_04_Cont"
      BoneName="wheel_LHS_04"
      BoneOffset=(X=-50.000000,Y=-20.000000,Z=0.000000)
      WheelRadius=30.000000
      SuspensionTravel=45.000000
      Side=SIDE_Left
      LongSlipFactor=250.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=1000.000000
      Name="LMWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(4)=LMWheel
   Begin Object Class=UTVehicleWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bUseMaterialSpecificEffects=True
      EffectDesiredSpinDir=-1.000000
      SteerFactor=1.000000
      SkelControlName="wheel_LHS_05_Cont"
      BoneName="wheel_LHS_05"
      BoneOffset=(X=0.000000,Y=-20.000000,Z=0.000000)
      WheelRadius=30.000000
      SuspensionTravel=45.000000
      Side=SIDE_Left
      LongSlipFactor=250.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=1000.000000
      Name="LFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(5)=LFWheel
   COMOffset=(X=-20.000000,Y=0.000000,Z=-30.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_10 ObjName=MyStayUprightSetup_10 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_10"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Goliath:MyStayUprightSetup_10'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_10 ObjName=MyStayUprightConstraintInstance_10 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_10"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Goliath:MyStayUprightConstraintInstance_10'
   MaxSpeed=900.000000
   bTurnInPlace=True
   bSeparateTurretFocus=True
   MomentumMult=0.300000
   bCanStrafe=True
   NonPreferredVehiclePathMultiplier=3.000000
   GroundSpeed=520.000000
   Health=900
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      RBCollideWithChannels=(Untitled1=True,Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   ViewPitchMin=-13000.000000
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Goliath"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
