/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicle_Raptor extends UTAirVehicle
	native(Vehicle);

/** bForwardMode==true if vehicle is thrusting forward.  Used by wing controls. */
var bool bForwardMode;

var name TurretPivotSocketName;

var particlesystem TeamMF[2];

/** Control used to raise/lower landing gear. */
var SkelControlSingleBone	LandingGearControl;

var Name	LandingGearBoneName;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetMaxRadius(SoundNodeAttenuation(EngineSound.SoundCue.FirstNode));
}

simulated function PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	Super.PostInitAnimTree(SkelComp);

	if(SkelComp == Mesh)
	{
		LandingGearControl = SkelControlSingleBone( mesh.FindSkelControl('LandingGear') );
	}
}

simulated function ForceSingleWingUp(bool bRight)
{
	local UTSkelControl_RaptorWing WingControl;

	WingControl = UTSkelControl_RaptorWing( mesh.FindSkelControl('WingControl') );
	if (WingControl != none)
	{
		WingControl.ForceSingleWingUp(bRight, 3000);
	}
}

simulated function ForceWingsUp()
{
	local UTSkelControl_RaptorWing WingControl;

	WingControl = UTSkelControl_RaptorWing( mesh.FindSkelControl('WingControl') );
	if (WingControl != none)
	{
		WingControl.ForceWingsUp(3000);
	}
}

simulated function TeamChanged()
{
	super.Teamchanged();
	VehicleEffects[0].EffectTemplate = TeamMF[Team%2];
	if(VehicleEffects[0].EffectRef != none)
	{
		VehicleEffects[0].EffectRef.DeactivateSystem();
		VehicleEffects[0].EffectRef.KillParticlesForced();
		VehicleEffects[0].EffectRef.SetTemplate(TeamMF[Team%2]);
	}
	VehicleEffects[1].EffectTemplate = TeamMF[Team%2];
	if(VehicleEffects[1].EffectRef != none)
	{
		VehicleEffects[1].EffectRef.DeactivateSystem();
		VehicleEffects[1].EffectRef.KillParticlesForced();
		VehicleEffects[1].EffectRef.SetTemplate(TeamMF[Team%2]);
	}
}

simulated function bool ShouldClamp()
{
	return false;
}

simulated event GetBarrelLocationAndRotation(int SeatIndex, out vector SocketLocation, optional out rotator SocketRotation)
{
	if (Seats[SeatIndex].GunSocket.Length>0)
	{
		Mesh.GetSocketWorldLocationAndRotation(Seats[SeatIndex].GunSocket[GetBarrelIndex(SeatIndex)], SocketLocation, SocketRotation);
		SocketLocation = SocketLocation - 170 * vector(SocketRotation);
	}
	else
	{
		SocketLocation = Location;
		SocketRotation = Rotation;
	}
}

defaultproperties
{
   LandingGearBoneName="LandingGear"
   PushForce=50000.000000
   bLimitCameraZLookingUp=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAirVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAirVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   MaxDesireability=0.600000
   VehicleIndex=8
   VehiclePositionString="In un Raptor"
   VehicleNameString="Raptor"
   ExplosionInAirAngVel=2.000000
   SpawnRadius=180.000000
   CameraLag=0.050000
   Begin Object Class=UTVehicleSimChopper Name=SimObject ObjName=SimObject Archetype=UTVehicleSimChopper'UTGame.Default__UTVehicleSimChopper'
      MaxThrustForce=750.000000
      MaxReverseForce=100.000000
      LongDamping=0.700000
      MaxStrafeForce=450.000000
      LatDamping=0.700000
      MaxRiseForce=500.000000
      UpDamping=0.700000
      TurnTorqueFactor=8000.000000
      TurnTorqueMax=10000.000000
      TurnDamping=1.200000
      MaxYawRate=1.500000
      PitchTorqueFactor=450.000000
      PitchTorqueMax=60.000000
      PitchDamping=0.300000
      RollTorqueTurnFactor=450.000000
      RollTorqueStrafeFactor=50.000000
      RollTorqueMax=50.000000
      RollDamping=0.100000
      StopThreshold=100.000000
      MaxRandForce=25.000000
      RandForceInterval=0.500000
      bFullThrustOnDirectionChange=True
      Name="SimObject"
      ObjectArchetype=UTVehicleSimChopper'UTGame.Default__UTVehicleSimChopper'
   End Object
   SimObj=SimObject
   bStayUpright=True
   StayUprightRollResistAngle=5.000000
   StayUprightPitchResistAngle=5.000000
   StayUprightStiffness=400.000000
   StayUprightDamping=20.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_2 ObjName=MyStayUprightSetup_2 Archetype=RB_StayUprightSetup'UTGame.Default__UTAirVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_2"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTAirVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Raptor:MyStayUprightSetup_2'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_2 ObjName=MyStayUprightConstraintInstance_2 Archetype=RB_ConstraintInstance'UTGame.Default__UTAirVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_2"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTAirVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Raptor:MyStayUprightConstraintInstance_2'
   UprightLiftStrength=30.000000
   UprightTorqueStrength=30.000000
   GroundSpeed=2000.000000
   AirSpeed=2500.000000
   BaseEyeHeight=50.000000
   EyeHeight=50.000000
   Health=300
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTAirVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTAirVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTAirVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTAirVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Raptor"
   ObjectArchetype=UTAirVehicle'UTGame.Default__UTAirVehicle'
}
