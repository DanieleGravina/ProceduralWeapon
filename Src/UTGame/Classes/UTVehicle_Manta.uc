/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicle_Manta extends UTHoverVehicle
	native(Vehicle)
	abstract;

var(Movement)	float	JumpForceMag;

var(Movement)	float	MaxJumpZVel;

/** How far down to trace to check if we can jump */
var(Movement)   float   JumpCheckTraceDist;

var     float	JumpDelay, LastJumpTime;

var(Movement)   float   DuckForceMag;

var repnotify bool bDoBikeJump;
var repnotify bool bHoldingDuck;
var		bool							bPressingAltFire;

var soundcue JumpSound;
var soundcue DuckSound;

var float BladeBlur, DesiredBladeBlur;
/** if >= 0, index in VehicleEffects array for fan effect that gets its MantaFanSpin parameter set to BladeBlur */
var int FanEffectIndex;
/** parameter name for the fan blur, set to BladeBlur */
var name FanEffectParameterName;

/** Manta flame jet effect name**/
var name FlameJetEffectParameterName;
/** values for setting the FlameJet Particle System **/
var float FlameJetValue, DesiredFlameJetValue;

/** Suspension height when manta is being driven around normally */
var(Movement) protected float FullWheelSuspensionTravel;

/** Suspension height when manta is crouching */
var(Movement) protected float CrouchedWheelSuspensionTravel;

/** controls how fast to interpolate between various suspension heights */
var(Movement) protected float SuspensionTravelAdjustSpeed;

/** Suspension stiffness when manta is being driven around normally */
var(Movement) protected float FullWheelSuspensionStiffness;

/** Suspension stiffness when manta is crouching */
var(Movement) protected float CrouchedWheelSuspensionStiffness;

/** Adjustment for bone offset when changing suspension */
var  protected float BoneOffsetZAdjust;

/** max speed while crouched */
var(Movement) float CrouchedAirSpeed;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if ((!bNetOwner || bDemoRecording) && Role == ROLE_Authority)
		bDoBikeJump, bHoldingDuck;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetMaxRadius(SoundNodeAttenuation(EngineSound.SoundCue.FirstNode));
}

/**
 * Are we allowing this Pawn to be based on us?
 */
simulated function bool CanBeBaseForPawn(Pawn APawn)
{
	return bCanBeBaseForPawns && !bDriving;
}

/** DriverEnter()
Make Pawn P the new driver of this vehicle
*/
function bool DriverEnter(Pawn P)
{
	local Pawn BasedPawn;

	if ( super.DriverEnter(P) )
	{
		ForEach BasedActors(class'Pawn', BasedPawn)
		{
			if(BasedPawn != Driver)
			{
				BasedPawn.JumpOffPawn();
			}
		}
		return true;
	}
	return false;
}

simulated function bool OverrideBeginFire(byte FireModeNum)
{
	if (FireModeNum == 1)
	{
		bPressingAltFire = true;
		return true;
	}

	return false;
}

simulated function bool OverrideEndFire(byte FireModeNum)
{
	if (FireModeNum == 1)
	{
		bPressingAltFire = false;
		return true;
	}

	return false;
}

function PossessedBy(Controller C, bool bVehicleTransition)
{
	super.PossessedBy(C, bVehicleTransition);

	// reset jump/duck properties
	bHoldingDuck = false;
	LastJumpTime = 0;
	bDoBikeJump = false;
	bPressingAltFire = false;
}

simulated event MantaJumpEffect();

simulated event MantaDuckEffect();

//========================================
// AI Interface

function byte ChooseFireMode()
{
	local UTBot B;

	B = UTBot(Controller);
	if ( B != None
		&& (B.Skill > 1.7 + FRand())
		&& Pawn(Controller.Focus) != None
		&& Vehicle(Controller.Focus) == None
		&& Controller.MoveTarget == Controller.Focus
		&& Controller.InLatentExecution(Controller.LATENT_MOVETOWARD)
		&& VSize(Controller.FocalPoint - Location) < 800
		&& Controller.LineOfSightTo(Controller.Focus) )
	{
		return 1;
	}

	return 0;
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	Rise = 1;
	return true;
}

function IncomingMissile(Projectile P)
{
	local UTBot B;

	B = UTBot(Controller);
	if (B != None && B.Skill > 4.0 + 4.0 * FRand() && VSize(P.Location - Location) < VSize(P.Velocity))
	{
		DriverLeave(false);
	}
	else
	{
		Super.IncomingMissile(P);
	}
}

// AI hint
function bool FastVehicle()
{
	return true;
}

simulated function DrivingStatusChanged()
{
	bPressingAltFire = false;

	Super.DrivingStatusChanged();
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bDoBikeJump')
	{
		MantaJumpEffect();
	}
	else if (VarName == 'bHoldingDuck')
	{
		MantaDuckEffect();
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function float GetChargePower()
{
	return FClamp( (WorldInfo.TimeSeconds - LastJumpTime), 0, JumpDelay)/JumpDelay;
}

simulated event RigidBodyCollision( PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent,
				const out CollisionImpactData RigidCollisionData, int ContactIndex )
{
	// only process rigid body collision if not hitting ground
	if ( Abs(RigidCollisionData.ContactInfos[0].ContactNormal.Z) < WalkableFloorZ )
	{
		super.RigidBodyCollision(HitComponent, OtherComponent, RigidCollisionData, ContactIndex);
	}
}

simulated function bool ShouldClamp()
{
	return false;
}

function bool TooCloseToAttack(Actor Other)
{
	local float OtherRadius, OtherHeight;

	if (Pawn(Other) != None && Vehicle(Other) == None)
	{
		return false;
	}
	else if (Super.TooCloseToAttack(Other))
	{
		return true;
	}
	else
	{
		Other.GetBoundingCylinder(OtherRadius, OtherHeight);
		return (VSize2D(Other.Location - Location) < OtherRadius + CylinderComponent.CollisionRadius + 150.0);
	}
}

function bool RecommendCharge(UTBot B, Pawn Enemy)
{
	if ( B.Skill < 1 + FRand() )
	{
		return false;
	}
	if ( Vehicle(Enemy) == None )
	{
		return (VSize(Location - Enemy.Location) < 1000.0 + 3000.0*FRand());
	}
	return false;
}	

defaultproperties
{
   JumpForceMag=7000.000000
   MaxJumpZVel=900.000000
   JumpCheckTraceDist=175.000000
   JumpDelay=3.000000
   DuckForceMag=-350.000000
   FullWheelSuspensionTravel=145.000000
   CrouchedWheelSuspensionTravel=100.000000
   SuspensionTravelAdjustSpeed=100.000000
   FullWheelSuspensionStiffness=20.000000
   CrouchedWheelSuspensionStiffness=40.000000
   BoneOffsetZAdjust=45.000000
   CrouchedAirSpeed=1200.000000
   CustomGravityScaling=0.800000
   FullAirSpeed=1800.000000
   bEjectKilledBodies=True
   bLightArmor=True
   bHomingTarget=True
   bTakeWaterDamageWhileDriving=False
   bRagdollDriverOnDarkwalkerHorn=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHoverVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHoverVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   MaxDesireability=0.600000
   ObjectiveGetOutDist=750.000000
   VehicleIndex=6
   VehiclePositionString="In un Manta"
   VehicleNameString="Manta"
   SpawnRadius=125.000000
   DefaultFOV=90.000000
   CameraLag=0.020000
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
      MaxThrustForce=325.000000
      MaxReverseForce=250.000000
      LongDamping=0.300000
      MaxStrafeForce=260.000000
      LatDamping=0.300000
      DirectionChangeForce=375.000000
      TurnTorqueFactor=2500.000000
      TurnTorqueMax=1000.000000
      TurnDamping=0.250000
      MaxYawRate=100000.000000
      PitchTorqueFactor=200.000000
      PitchTorqueMax=18.000000
      PitchDamping=0.100000
      RollTorqueTurnFactor=1000.000000
      RollTorqueStrafeFactor=110.000000
      RollTorqueMax=500.000000
      RollDamping=0.200000
      MaxRandForce=20.000000
      RandForceInterval=0.400000
      WheelSuspensionStiffness=20.000000
      WheelSuspensionDamping=1.000000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Engine"
      BoneOffset=(X=-50.000000,Y=100.000000,Z=-200.000000)
      WheelRadius=10.000000
      SuspensionTravel=145.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="RThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(0)=RThruster
   Begin Object Class=UTHoverWheel Name=LThruster ObjName=LThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Engine"
      BoneOffset=(X=-50.000000,Y=-100.000000,Z=-200.000000)
      WheelRadius=10.000000
      SuspensionTravel=145.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="LThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(1)=LThruster
   Begin Object Class=UTHoverWheel Name=FThruster ObjName=FThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Engine"
      BoneOffset=(X=80.000000,Y=0.000000,Z=-200.000000)
      WheelRadius=10.000000
      SuspensionTravel=145.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="FThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(2)=FThruster
   bStayUpright=True
   bCanFlip=True
   StayUprightRollResistAngle=5.000000
   StayUprightPitchResistAngle=5.000000
   StayUprightStiffness=450.000000
   StayUprightDamping=20.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_4 ObjName=MyStayUprightSetup_4 Archetype=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_4"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Manta:MyStayUprightSetup_4'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_4 ObjName=MyStayUprightConstraintInstance_4 Archetype=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_4"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Manta:MyStayUprightConstraintInstance_4'
   UprightLiftStrength=30.000000
   UprightTorqueStrength=30.000000
   bDriverIsVisible=True
   bTurnInPlace=True
   bFollowLookDir=True
   bScriptedRise=True
   ExitRadius=160.000000
   MomentumMult=3.200000
   bCanStrafe=True
   bCanBeBaseForPawns=True
   MeleeRange=-100.000000
   GroundSpeed=1500.000000
   AirSpeed=1800.000000
   BaseEyeHeight=110.000000
   EyeHeight=110.000000
   Health=200
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTHoverVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTHoverVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTHoverVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTHoverVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Manta"
   ObjectArchetype=UTHoverVehicle'UTGame.Default__UTHoverVehicle'
}
