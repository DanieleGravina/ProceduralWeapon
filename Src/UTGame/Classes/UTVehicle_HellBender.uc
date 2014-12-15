/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_HellBender extends UTVehicle
	native(Vehicle)
	abstract;

var repnotify vector TurretFlashLocation;
var	repnotify byte TurretFlashCount;
var repnotify rotator TurretWeaponRotation;
var byte TurretFiringMode;
/** Sound played whenever the suspension shifts suddenly */
var AudioComponent SuspensionShiftSound;
/** Time the last SuspensionShift was played.*/
var float LastSuspensionShiftTime;
var name ExhaustEffectName;
/** The Template of the Beam to use */

/** Internal variable.  Maintains brake light state to avoid extraMatInst calls.	*/
var bool bBrakeLightOn;

/** Internal variable.  Maintains reverse light state to avoid extra MatInst calls.	*/
var bool bReverseLightOn;

/** material parameter that should be modified to turn the brake lights on and off */
var name BrakeLightParameterName;
/** material parameter that should be modified to turn the reverse lights on and off */
var name ReverseLightParameterName;

var ParticleSystem BeamTemplate;

/** burnout for license plate*/
var MaterialInterface PlateBO[2];

var MaterialInterface PlateTeamMaterials[2];
replication
{
	if (bNetDirty)
		TurretFlashLocation;
	if (!IsSeatControllerReplicationViewer(1) || bDemoRecording)
		TurretFlashCount, TurretWeaponRotation;
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated event SuspensionHeavyShift(float delta)
{
	if(LastSuspensionShiftTime + 0.4f < WorldInfo.TimeSeconds && delta>0 && WorldInfo.NetMode != NM_DEDICATEDSERVER)
	{
		SuspensionShiftSound.VolumeMultiplier = FMin((delta-HeavySuspensionShiftPercent)/(1.0-HeavySuspensionShiftPercent),1.0);
		SuspensionShiftSound.Play();
		LastSuspensionShiftTime=WorldInfo.TimeSeconds;
	}
}

simulated function SetBurnOut()
{
	Mesh.SetMaterial( 1, PlateBO[Team==1?1:0] );
	super.SetBurnOut();
}

simulated event RigidBodyCollision( PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent,
					const out CollisionImpactData RigidCollisionData, int ContactIndex )
{
	// only process rigid body collision if not hitting ground, or hitting at an angle
	if ( (Abs(RigidCollisionData.ContactInfos[0].ContactNormal.Z) < WalkableFloorZ)
		|| (Abs(RigidCollisionData.ContactInfos[0].ContactNormal dot vector(Rotation)) > 0.8)
		|| (VSizeSq(Mesh.GetRootBodyInstance().PreviousVelocity) * GetCollisionDamageModifier(RigidCollisionData.ContactInfos) > 5) )
	{
		super.RigidBodyCollision(HitComponent, OtherComponent, RigidCollisionData, ContactIndex);
	}
}

simulated function TeamChanged()
{
	Mesh.SetMaterial(1, PlateTeamMaterials[Team==1?1:0]);
	super.TeamChanged();
}

defaultproperties
{
   bStickDeflectionThrottle=True
   bEjectKilledBodies=True
   bLookSteerOnNormalControls=True
   bLookSteerOnSimpleControls=True
   bReducedFallingCollisionDamage=True
   DeflectionReverseThresh=-0.300000
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   ObjectiveGetOutDist=1500.000000
   HornIndex=1
   VehicleIndex=4
   LookSteerSensitivity=2.200000
   LookSteerDamping=0.040000
   ConsoleSteerScale=0.900000
   StolenAnnouncementIndex=5
   VehiclePositionString="In un Hellbender"
   VehicleNameString="Hell Bender"
   SpawnRadius=125.000000
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
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_11 ObjName=MyStayUprightSetup_11 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_11"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_HellBender:MyStayUprightSetup_11'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_11 ObjName=MyStayUprightConstraintInstance_11 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_11"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_HellBender:MyStayUprightConstraintInstance_11'
   HeavySuspensionShiftPercent=0.200000
   MaxSpeed=1050.000000
   UprightLiftStrength=500.000000
   UprightTorqueStrength=400.000000
   bSeparateTurretFocus=True
   bHasHandbrake=True
   MomentumMult=1.000000
   NonPreferredVehiclePathMultiplier=2.000000
   GroundSpeed=800.000000
   AirSpeed=950.000000
   BaseEyeHeight=0.000000
   EyeHeight=0.000000
   Health=600
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
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
   Name="Default__UTVehicle_HellBender"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
