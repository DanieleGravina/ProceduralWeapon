	/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTVehicle_Viper extends UTHoverVehicle
	native(Vehicle)
	abstract;

var(Movement)   float   MaxJumpDuration;
var(Movement)	float	JumpForceMag;

var(Movement)	float	MinJumpDuration;

var(Movement)	float	MinZJumpVel;

/** How far down to trace to check if we can jump */
var(Movement)   float   JumpCheckTraceDist;

var     float   JumpCountdown;

var repnotify bool bDoBikeJump;
var repnotify bool bHoldingDuck;
var		bool							bPressingAltFire;

var soundcue JumpSound;
var soundcue DuckSound;

var(Movement) float GlideAirSpeed;
var(Movement) float GlideSpeedReductionRate;

/** CustomGravityScaling setting when wings not extended */
var(Movement) float NormalGravity;

/** CustomGravityScaling setting when wings are extended */
var(Movement) float GlidingGravity;

/** When falling, apply this torque to gently tip the nose of the vehicle down. */
var(Movement) float	FallingNoseDownTorque;

/** Self destruct effect properties */
var class<UTDamageType> SelfDestructDamageType;
var SoundCue SelfDestructSoundCue;
var SoundCue EjectSoundCue;

/** name of skel control to perform the self destruct spin move*/
var name SelfDestructSpinName;
/** Whether or not the self destruct sequence is in progress*/
var bool bSelfDestructInProgress;
/** who gets credit for self destruct damage caused */
var Controller SelfDestructInstigator;
/** when self destruct was engaged */
var float DestructStartTime;
/** how long self destruct lasts before blowing up if no targets found */
var float MaxDestructDuration;
/** How long Rise must be > 0 to self destruct*/
var float TimeToRiseForSelfDestruct;
/** flag for whether or not self destruct will go off if the vehicle is left */
var bool bSelfDestructReady;
/** sound to be played when Self Destruct is armed */
var SoundCue SelfDestructReadySnd;
/** replicated property identifies that self destruct is engaged */
var repnotify bool bSelfDestructArmed;
/** set when AI wants to self destruct or when forced by Kismet */
var bool bScriptedSelfDestruct;

/** replicated vector specifies force to apply to self-destructing viper (in direction ejecting driver was last looking when he left) */
var vector BoostDir;

/** magnitude to apply when determining BoostDir */
var float BoostForce;

/** This is the index of the effect that controls the jet exhause */
var int ExhaustIndex;

/** effect played when self destructing */
var ParticleSystem SelfDestructEffectTemplate;
/** the actual effect, var-ed so we can end it more appropriately*/
var ParticleSystemComponent SelfDestructEffect;

var name ExhaustParamName;

/** anim node that controls the gliding animation. Child 0 should be the normal anim, Child 1 the gliding anim. */
var AnimNodeBlend GlideBlend;
/** anim node that plays the idling animation. */
var AnimNodeSequence IdleAnimNode;

/** how long it takes to switch between gliding animation states */
var float GlideBlendTime;

/** sound played on sudden curves */
var AudioComponent  CurveSound;

/** Texture coordinates for SelfDestruct tooltip*/
var TextureCoordinates ViperSelfDestructToolTipIcon;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if (bNetDirty && Role == ROLE_Authority)
		BoostDir;
	if (bNetDirty && !bNetOwner && Role == ROLE_Authority)
		bSelfDestructArmed;
	if (!bNetOwner && Role == ROLE_Authority)
		bDoBikeJump, bHoldingDuck;
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	GlideBlend = AnimNodeBlend(Mesh.FindAnimNode('GlideNode'));
	IdleAnimNode = AnimNodeSequence(Mesh.FindAnimNode('IdleAnim'));

	// hack the radius
	SetMaxRadius(SoundNodeAttenuation(EngineSound.SoundCue.FirstNode));
}

simulated function SetVehicleEffectParms(name TriggerName, ParticleSystemComponent PSC)
{
	if (TriggerName == 'MantaOnFire')
	{
		PSC.SetFloatParameter('smokeamount', 0.95);
		PSC.SetFloatParameter('fireamount', 0.95);
	}
	else
	{
		Super.SetVehicleEffectParms(TriggerName, PSC);
	}
}

/** Self destruct immediately if activated and hit by EMP */
simulated function bool DisableVehicle()
{
	local bool bResult;

	bResult = super.DisableVehicle();

	if ( SelfDestructInstigator != None )
	{
		SelfDestruct(None);
		return true;
	}
	return bResult;
}

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local PlayerController PC;

	// viper is fragile so it takes momentum even from weapons that don't usually impart it
	if ( (DamageType == class'UTDmgType_Enforcer') && !IsZero(HitLocation) )
	{
		Momentum = (Location - HitLocation) * float(Damage) * 20.0;
	}
	// take double damage while self destructing
	if (bSelfDestructArmed)
	{
		Damage *= 2;
		PC = PlayerController(SelfDestructInstigator);
	}
	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);

	if ( (Role == ROLE_Authority) && (Health < 0) && bSelfDestructArmed && (EventInstigator != PC) )
	{
		if ( PC != None )
			PC.ReceiveLocalizedMessage(class'UTLastSecondMessage', 1, PC.PlayerReplicationInfo, None, None);
		if ( PlayerController(EventInstigator) != None )
		{
			PlayerController(EventInstigator).ReceiveLocalizedMessage(class'UTLastSecondMessage', 1, PC.PlayerReplicationInfo, None, None);
		}
	}
}

function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
	VehicleEvent('MantaNormal');
	return Super.Died(Killer,DamageType,HitLocation);
}

simulated function DrivingStatusChanged()
{
	if ( !bDriving )
	{
		bPressingAltFire = false;
		VehicleEvent('CrushStop');
	}
	Super.DrivingStatusChanged();
}

// The pawn Driver has tried to take control of this vehicle
function bool TryToDrive(Pawn P)
{
	return (SelfDestructInstigator == None) && Super.TryToDrive(P);
}

/** If exit while boosting, boost out of the vehicle
Try to exit above
*/
function bool FindAutoExit(Pawn ExitingDriver)
{
	local vector X,Y,Z;
	local float PlaceDist;

	if ( bSelfDestructReady )
	{
		GetAxes(Rotation, X,Y,Z);
		Y *= -1;

		PlaceDist = 150 + 4*ExitingDriver.GetCollisionHeight();

		if ( TryExitPos(ExitingDriver, GetTargetLocation() + PlaceDist * Z, false) )
			return true;
	}
	return Super.FindAutoExit(ExitingDriver);
}

event bool DriverLeave(bool bForceLeave)
{
	local vector AimPoint, HitLocation, HitNormal, CameraLocation;
	local rotator CameraRotation;
	local Actor HitActor;

	if (bSelfDestructReady)
	{
		// we need to calculate the aim point BEFORE getting out of the vehicle
		// because the driver's camera uses different code and therefore may be pointing in a different direction
		if ( PlayerController(Controller) != None )
		{
			PlayerController(Controller).ClientPlaySound(EjectSoundCue);
			PlayerController(Controller).GetPlayerViewPoint(CameraLocation, CameraRotation);
			AimPoint = CameraLocation + 8000*Vector(CameraRotation);
			HitActor = Trace(HitLocation, HitNormal, AimPoint, CameraLocation, true,,,TRACEFLAG_Blocking);
			if ( HitActor != None)
			{
				AimPoint = HitLocation;
			}
			BoostDir = BoostForce * Normal(AimPoint - Location);
		}
		else if (Controller != None)
		{
			BoostDir = BoostForce * Normal(Controller.FocalPoint - Location);
		}
		else
		{
			BoostDir = BoostForce * vector(Rotation);
		}
	}

	return Super.DriverLeave(bForceLeave);
}

function bool EagleEyeTarget()
{
	return bSelfDestructReady;
}

simulated function StopVehicleSounds()
{
	super.StopVehicleSounds();
	CurveSound.Stop();
}

simulated function PlaySelfDestruct()
{
	local int i, CurrentRoll;

	DeadVehicleLifeSpan = BurnOutTime + 0.01;

	// Terminate stay-upright constraint
	if ( StayUprightConstraintInstance != None)
	{
		StayUprightConstraintInstance.TermConstraint();
	}

	Mesh.SetActorCollision(false, false);

	bNoEncroachCheck = true;
	UpdateShadowSettings( FALSE );
	bBlockActors = false;

	CurrentRoll = Rotation.Roll & 65535;
	bFlipRight = (CurrentRoll == Clamp(CurrentRoll, 0, 32768));

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		// kill ground effects
		for (i = 0; i < GroundEffectIndices.length; i++)
		{
			VehicleEffects[GroundEffectIndices[i]].EffectRef.SetHidden(true);
			VehicleEffects[GroundEffectIndices[i]].EffectRef.DeactivateSystem();
		}
		GroundEffectIndices.length = 0;

		if(SelfDestructEffect == none)
		{
			SelfDestructEffect = new(self) class'UTParticleSystemComponent';
			SelfDestructEffect.SetTemplate(SelfDestructEffectTemplate);
			AttachComponent(SelfDestructEffect);
		}
	}
}

function DriverLeft()
{
	if (bSelfDestructReady)
	{
		// arm self destruct if exit vehicle while pushing rise or crouch
		bSelfDestructArmed = true;

		SelfDestructInstigator = Driver.Controller;
		EjectDriver();
		DestructStartTime = WorldInfo.TimeSeconds;

		PlaySelfDestruct();
	}

	Super.DriverLeft();
}

event SelfDestruct(Actor ImpactedActor)
{
	Health = -100000;
	Mesh.SetActorCollision(false, false);
	KillerController = SelfDestructInstigator;
	BlowUpVehicle();
	if ( ImpactedActor != None )
	{
		ImpactedActor.TakeDamage(600, SelfDestructInstigator, GetTargetLocation(), 200000 * Normal(Velocity), SelfDestructDamageType,, self);
	}
	HurtRadius(600,600, SelfDestructDamageType, 200000, GetTargetLocation(), ImpactedActor, SelfDestructInstigator);
	PlaySound(SelfDestructSoundCue);
	DestructStartTime = WorldInfo.TimeSeconds;
	bSelfDestructArmed = false;
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bSelfDestructArmed')
	{
		PlaySelfDestruct();
	}
	else if (VarName == 'bDoBikeJump')
	{
		JumpCountdown = MaxJumpDuration;
		ViperJumpEffect();
	}
	else if (VarName == 'bHoldingDuck')
	{
		JumpCountdown = 0.0;
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function BlowupVehicle()
{
	if (SelfDestructEffect != None)
	{
		SelfDestructEffect.DeactivateSystem();
		SelfDestructEffect.SetHidden(true);
	}
	Super.BlowupVehicle();
}

simulated function ArmSelfDestruct()
{
	if (bSelfDestructInProgress) // sanity check
	{
		bSelfDestructReady = true;
		if (IsLocallyControlled() && IsHumanControlled())
		{
			Playsound(SelfDestructReadySnd, true, true, true);
		}
		bSelfDestructInProgress = false;
		if (bScriptedSelfDestruct)
		{
			DriverLeave(true);
		}
	}
}

function OnSelfDestruct(UTSeqAct_SelfDestruct Action)
{
	bScriptedSelfDestruct = true;
}

simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
	super.SetInputs(InForward,InStrafe,InUp);
	if(bPressingAltFire)
	{
		Rise = 1.0f;
	}
}
simulated function bool OverrideBeginFire(byte FireModeNum)
{
	if (FireModeNum == 1)
	{
		bPressingAltFire = true;
		Rise=1.0f;
		return true;
	}

	return false;
}

simulated function bool OverrideEndFire(byte FireModeNum)
{
	local PlayerController PC;
	if (FireModeNum == 1)
	{
		Rise=0.0f;
		if(bSelfDestructReady)
		{
			DriverLeave(true);
		}
		else
		{
			PC=PlayerController(Seats[0].SeatPawn.Controller);
			if(PC != none)
			{
				PC.ReceiveLocalizedMessage(class'UTVehicleMessage', 0);
			}
		}
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
	JumpCountDown = 0;
	bDoBikeJump = false;
	bPressingAltFire = false;
}

simulated event ViperJumpEffect()
{
	PlaySound(JumpSound, true);
	VehicleEvent('BoostStart');
	if (Role == ROLE_Authority || IsLocallyControlled())
	{
		bSelfDestructReady = false;
		SetTimer(TimeToRiseForSelfDestruct, false, 'ArmSelfDestruct');
		bSelfDestructInProgress = true;
	}
}

simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{
	local PlayerController PC;

	super.DisplayHud(Hud, Canvas, HudPOS, SeatIndex);

	if (bDriving && bSelfDestructReady && !bSelfDestructArmed)
	{
		PC = PlayerController(Seats[0].SeatPawn.Controller);
		if (PC != none)
		{
			Hud.DrawToolTip(Canvas, PC, "GBA_AltFire", Canvas.ClipX * 0.5, Canvas.ClipY * 0.95, ViperSelfDestructToolTipIcon.U, ViperSelfDestructToolTipIcon.V, ViperSelfDestructToolTipIcon.UL, ViperSelfDestructToolTipIcon.VL, Canvas.ClipY / 768);
		}
	}
}

//========================================
// AI Interface

function byte ChooseFireMode()
{
	if (Pawn(Controller.Focus) != None
		&& Vehicle(Controller.Focus) == None
		&& Controller.MoveTarget == Controller.Focus
		&& Controller.InLatentExecution(Controller.LATENT_MOVETOWARD)
		&& VSize(Controller.FocalPoint - Location) < 800
		&& Controller.LineOfSightTo(Controller.Focus) )
	{
		return 1;
	}
	// self destruct if low health and target is an objective or a high health vehicle
	else if (Health < HealthMax / 2 && (UTGameObjective(Controller.Focus) != None || (Vehicle(Controller.Focus) != None && Vehicle(Controller.Focus).Health >= 300)))
	{
		bScriptedSelfDestruct = true;
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
   MaxJumpDuration=0.900000
   JumpForceMag=600.000000
   MinJumpDuration=0.500000
   MinZJumpVel=500.000000
   JumpCheckTraceDist=175.000000
   GlideAirSpeed=1.000000
   GlideSpeedReductionRate=1.000000
   NormalGravity=0.900000
   GlidingGravity=0.300000
   FallingNoseDownTorque=100.000000
   MaxDestructDuration=2.200000
   BoostForce=500.000000
   CustomGravityScaling=0.900000
   StallZGravityScaling=4.000000
   FullAirSpeed=1800.000000
   bEjectKilledBodies=True
   bLightArmor=True
   bHomingTarget=True
   bTakeWaterDamageWhileDriving=False
   bRagdollDriverOnDarkwalkerHorn=True
   bIsNecrisVehicle=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHoverVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHoverVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   MaxDesireability=0.600000
   ObjectiveGetOutDist=750.000000
   HornIndex=2
   VehicleIndex=13
   VehiclePositionString="In un Viper"
   VehicleNameString="Viper"
   SpawnRadius=125.000000
   DefaultFOV=90.000000
   CameraLag=0.040000
   LookForwardDist=100.000000
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
      MaxThrustForce=500.000000
      MaxReverseForce=300.000000
      LongDamping=0.300000
      MaxStrafeForce=300.000000
      LatDamping=0.300000
      TurnTorqueFactor=5000.000000
      TurnTorqueMax=1000.000000
      TurnDamping=0.500000
      MaxYawRate=100000.000000
      PitchTorqueMax=35.000000
      PitchDamping=0.250000
      RollTorqueTurnFactor=250.000000
      RollTorqueStrafeFactor=220.000000
      RollTorqueMax=220.000000
      RollDamping=0.250000
      MaxRandForce=3.000000
      RandForceInterval=0.750000
      StrafeTurnDamping=0.100000
      WheelSuspensionStiffness=45.000000
      WheelSuspensionDamping=6.000000
      WheelSuspensionBias=-0.500000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bHoverWheel=True
      SteerFactor=1.000000
      BoneName="Base"
      BoneOffset=(X=-150.000000,Y=65.000000,Z=-140.000000)
      WheelRadius=30.000000
      SuspensionTravel=110.000000
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
      BoneName="Base"
      BoneOffset=(X=-150.000000,Y=-65.000000,Z=-140.000000)
      WheelRadius=30.000000
      SuspensionTravel=110.000000
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
      BoneName="Base"
      BoneOffset=(X=60.000000,Y=0.000000,Z=-140.000000)
      WheelRadius=38.000000
      SuspensionTravel=110.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="FThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(2)=FThruster
   COMOffset=(X=-50.000000,Y=0.000000,Z=-70.000000)
   bStayUpright=True
   bCanFlip=True
   StayUprightRollResistAngle=35.000000
   StayUprightPitchResistAngle=30.000000
   StayUprightStiffness=800.000000
   StayUprightDamping=20.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_5 ObjName=MyStayUprightSetup_5 Archetype=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_5"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Viper:MyStayUprightSetup_5'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_5 ObjName=MyStayUprightConstraintInstance_5 Archetype=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_5"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Viper:MyStayUprightConstraintInstance_5'
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
   BaseEyeHeight=40.000000
   EyeHeight=40.000000
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
   Name="Default__UTVehicle_Viper"
   ObjectArchetype=UTHoverVehicle'UTGame.Default__UTHoverVehicle'
}