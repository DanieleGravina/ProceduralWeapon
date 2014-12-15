/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicle_Scorpion extends UTVehicle
	native(Vehicle)
	abstract;

/** animation for the Scorpion's extendable blades */
var UTAnimBlendByWeapon BladeBlend;

/** Internal variable.  Maintains brake light state to avoid extraMatInst calls.	*/
var bool bBrakeLightOn;

/** Internal variable.  Maintains reverse light state to avoid extra MatInst calls.	*/
var bool bReverseLightOn;

/** Internal variable.  Maintains headlight state to avoid extra MatInst calls.	*/
var bool bHeadlightsOn;

/** whether or not the blades are currently extended */
var repnotify bool bBladesExtended;

/** whether or not the blade on each side has been broken off */
var repnotify bool bLeftBladeBroken, bRightBladeBroken;

/** how far along blades a hit against world geometry will break them */
var float BladeBreakPoint;

/** material parameter that should be modified to turn the brake lights on and off */
var name BrakeLightParameterName;

/** material parameter that should be modified to turn the reverse lights on and off */
var name ReverseLightParameterName;

/** material parameter that should be modified to turn the headlights on and off */
var name HeadLightParameterName;

/** socket names for the start and end of the blade traces
	if the corresponding blade is not broken anything that gets in between the start and end bone triggers a BladeHit() event */
var name RightBladeStartSocket, RightBladeEndSocket, LeftBladeStartSocket, LeftBladeEndSocket;

/** damage type for blade kills */
var class<DamageType> BladeDamageType;

/** blade sounds */
var SoundCue BladeBreakSound, BladeExtendSound, BladeRetractSound;

/** rocket booster properties */
var float BoosterForceMagnitude;

var repnotify bool	bBoostersActivated;
/** If true, steering is very limited (enabled while boosting) */
var		bool	bSteeringLimited;
var Controller SelfDestructInstigator;

/** Radius to auto-check for targets when in self-destruct mode */
var float BoosterCheckRadius;

/** How long you can boost */
var float MaxBoostDuration;
/** used to track boost duration */
var float BoostStartTime;
/** How long it takes to recharge between boosts */
var float BoostChargeDuration;
/** used to track boost recharging duration */
var float BoostChargeTime;
var AudioComponent BoosterSound;

/** Coordinates for the boost tooltip textures */
var UIRoot.TextureCoordinates BoostToolTipIconCoords;

/** Coordinates for the eject tooltip textures */
var UIRoot.TextureCoordinates EjectToolTipIconCoords;

var class<UTDamageType> SelfDestructDamageType;
var float BoostPowerSpeed;
var float BoostReleaseTime;
var float BoostReleaseDelay;
var SoundCue SelfDestructSoundCue;
var SoundCue SelfDestructReadyCue;
var SoundCue SelfDestructWarningSound;
var SoundCue SelfDestructEnabledSound;
var SoundCue SelfDestructEnabledLoop;

var CameraAnim RedBoostCamAnim;
var CameraAnim BlueBoostCamAnim;

/** Sound played whenever Suspension moves suddenly */
var SoundCue SuspensionShiftSound;
var AudioComponent SelfDestructEnabledComponent;
var AudioComponent SelfDestructWarningComponent;
var AudioComponent SelfDestructReadyComponent;
var SoundCue EjectSoundCue;

/** desired camera FOV while using booster */
var float BoosterFOVAngle;

/** animation for the boosters */
var UTAnimBlendByWeapon BoosterBlend;

/** set when boosters activated by Kismet script, so keep them active regardless of input */
var bool bScriptedBoosters;

/** replicated flag indicating when self destruct is activated */
var repnotify bool bSelfDestructArmed;

/** double tap forward to start rocket boosters */
var bool bTryToBoost;
var bool bWasThrottle;
var float ThrottleStartTime;

var() float	BoostUprightTorqueFactor;
var() float	BoostUprightMaxTorque;

var float	DefaultUprightTorqueFactor;
var float	DefaultUprightMaxTorque;

/** dynamic light */
var	PointLightComponent LeftBoosterLight, RightBoosterLight;

var RB_ConstraintActor BladeVictimConstraint[2];

var StaticMesh ScorpionHood;

/** Rocket speed is the (clamped) max speed while boosting */
var float RocketSpeed;

/** Square of minimum speed needed to engage self destruct */
var float SelfDestructSpeedSquared;

/** How long the springs should be when the wheels need to be locked to the ground */
var() float LockSuspensionTravel;

/** How stiff the suspension should be when the wheels need to be locked to the ground */
var() float LockSuspensionStiffness;

/** How much the steering should be restricted while boosting */
var() float BoostSteerFactors[3];

/** swap BigExplosionTemplate for this when self-destructing */
var ParticleSystem SelfDestructExplosionTemplate;
var class<UTGib> HatchGibClass;

/** The mesh to spawn when the blades are broken off **/
var StaticMesh BrokenBladeMesh;

/** Last time bot tried to do blade boost */
var float LastBladeBoostTime;

var bool bAISelfDestruct;

replication
{
	if (bNetDirty)
		bBladesExtended, bLeftBladeBroken, bRightBladeBroken, bSelfDestructArmed;
	if (bNetDirty)
		bBoostersActivated;
}

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Returns true if self destruct conditions (boosting, going fast enough) are met */
native final function bool ReadyToSelfDestruct();

function bool EagleEyeTarget()
{
	return ReadyToSelfDestruct();
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if(SimObj.bAutoDrive)
	{
		SetDriving(true);
	}

	if (WorldInfo.NetMode != NM_DedicatedServer && !bDeleteMe && DamageMaterialInstance[0] != none)
	{
		// turn off headlights
		DamageMaterialInstance[0].SetScalarParameterValue('Green_Glows_Headlights', 0.f );
	}

	BladeBlend = UTAnimBlendByWeapon(Mesh.Animations.FindAnimNode('BladeNode'));
	if (BladeBlend == None) WarnInternal("Could not find BladeNode for mesh (" $ Mesh $ ")");

	BoosterBlend = UTAnimBlendByWeapon(Mesh.Animations.FindAnimNode('BoosterNode'));
	if (BoosterBlend == None) WarnInternal("Could not find BoosterNode for mesh (" $ Mesh $ ")");
}

/**
 * RanInto() called for encroaching actors which successfully moved the other actor out of the way
 *
 * @param	Other 		The pawn that was hit
 */
event RanInto(Actor Other)
{
	local float BoostRemaining;

	if ( bBoostersActivated && !bAISelfDestruct && (Other == Controller.Enemy) && (UTBot(Controller) != None) )
	{
		DeactivateRocketBoosters();
		bBoostersActivated = FALSE;
		BoostRemaining = MaxBoostDuration - WorldInfo.TimeSeconds + BoostStartTime;
		BoostChargeTime = WorldInfo.TimeSeconds - FMin(BoostChargeDuration - 2.f, BoostRemaining * BoostChargeDuration/MaxBoostDuration);
	}
	super.RanInto(Other);
}

function PancakeOther(Pawn Other)
{
	local float BoostRemaining;

	if ( bBoostersActivated && !bAISelfDestruct && (Other == Controller.Enemy) && (UTBot(Controller) != None) )
	{
		DeactivateRocketBoosters();
		bBoostersActivated = FALSE;
		BoostRemaining = MaxBoostDuration - WorldInfo.TimeSeconds + BoostStartTime;
		BoostChargeTime = WorldInfo.TimeSeconds - FMin(BoostChargeDuration - 2.f, BoostRemaining * BoostChargeDuration/MaxBoostDuration);
	}
	super.PancakeOther(Other);
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

simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
	Super.SetInputs(InForward, InStrafe, InUp);

	if (!bBoostersActivated && WorldInfo.TimeSeconds - BoostChargeTime > BoostChargeDuration)
	{
		if (bScriptedBoosters)
		{
			bTryToBoost = true;
		}
		else if (IsLocallyControlled())
		{
			if (Throttle > 0.0)
			{
				if (Rise > 0.0)
				{
					ServerBoost();
					bTryToBoost = true;
				}
				else if (!bWasThrottle)
				{
					if (WorldInfo.TimeSeconds - ThrottleStartTime < class'PlayerInput'.default.DoubleClickTime)
					{
						ServerBoost();
						bTryToBoost = true;
					}
					ThrottleStartTime = WorldInfo.TimeSeconds;
				}
				bWasThrottle = true;
			}
			else if (Throttle <= 0)
			{
				bWasThrottle = false;
			}
		}
	}
}

simulated function StopVehicleSounds()
{
	super.StopVehicleSounds();
	BoosterSound.Stop();
}

simulated event SuspensionHeavyShift(float Delta)
{
	if(Delta>0)
	{
		PlaySound(SuspensionShiftSound);
	}
}

/**
when called makes the wheels stick to the ground more
*/
simulated function LockWheels()
{
	local SVehicleSimCar SimCar;

	bSteeringLimited = true;
	SimCar = SVehicleSimCar(SimObj);

	Wheels[0].SuspensionTravel = LockSuspensionTravel;
	Wheels[1].SuspensionTravel = LockSuspensionTravel;
	SimCar.WheelSuspensionStiffness= LockSuspensionStiffness;
	SimCar.MaxSteerAngleCurve.Points[0].OutVal = BoostSteerFactors[0]; //10.0;
	SimCar.MaxSteerAngleCurve.Points[1].OutVal = BoostSteerFactors[1]; //4.0;
	SimCar.MaxSteerAngleCurve.Points[2].OutVal = BoostSteerFactors[2]; //1.2;

}

/**
Resets the variables that are changed in the LockWheels call
*/
simulated function UnlockWheels()
{
	local SVehicleSimCar SimCar;

	bSteeringLimited = false;
	SimCar = SVehicleSimCar(SimObj);

	Wheels[0].SuspensionTravel = Default.Wheels[0].SuspensionTravel;
	Wheels[1].SuspensionTravel = Default.Wheels[1].SuspensionTravel;
	SimCar.WheelSuspensionStiffness = SVehicleSimCar(Default.SimObj).WheelSuspensionStiffness;
}
/** ActivateRocketBoosters()
called when player activates rocket boosters
*/
simulated event ActivateRocketBoosters()
{
	local CameraAnim UseCamAnim;

	bSteeringLimited = true;

	AirSpeed = Default.RocketSpeed;

	if ( WorldInfo.NetMode == NM_DedicatedServer )
		return;

	// Play any animations/etc here

	if ( UTPlayerController(Controller) != none )
	{
		UTPlayerController(Controller).StartZoom(BoosterFOVAngle,60);

		UseCamAnim = (Team==1) ? BlueBoostCamAnim : RedBoostCamAnim;
		UTPlayerController(Controller).PlayCameraAnim(UseCamAnim, 1.0, 1.0, 0.1, 0.2, FALSE, FALSE);
	}

	// play animation
	BoosterBlend.AnimFire('boosters_out', true,,, 'boosters_out_idle');
	// activate booster sound and effects
	BoosterSound.Play();
	if (VehicleEffects[0].EffectRef != none)
	{
		VehicleEffects[0].EffectRef.bJustAttached = TRUE;
	}
	if (VehicleEffects[1].EffectRef != none)
	{
		VehicleEffects[1].EffectRef.bJustAttached = TRUE;
	}
	VehicleEvent( 'BoostStart' );

	if ( PlayerController(Controller) != None )
	{
		Mesh.AttachComponentToSocket(LeftBoosterLight, VehicleEffects[0].EffectSocket);
		Mesh.AttachComponentToSocket(RightBoosterLight, VehicleEffects[1].EffectSocket);
		LeftBoosterLight.SetEnabled(TRUE);
		RightBoosterLight.SetEnabled(TRUE);
	}
	LockWheels();

	DefaultUprightMaxTorque = UTVehicleSimCar(SimObj).InAirUprightMaxTorque;
	DefaultUprightTorqueFactor = UTVehicleSimCar(SimObj).InAirUprightTorqueFactor;

	UTVehicleSimCar(SimObj).InAirUprightMaxTorque = BoostUprightMaxTorque;
	UTVehicleSimCar(SimObj).InAirUprightTorqueFactor = BoostUprightTorqueFactor;
}

/** DeactivateHandbrake()
called (usually by a timer) to deactivate the handbrake
*/
simulated function DeactivateHandbrake()
{
    bOutputHandbrake = FALSE;
    bHoldingDownHandbrake = FALSE;
}

simulated event EnableFullSteering()
{
	local SVehicleSimCar SimCar;

	bSteeringLimited = false;
	SimCar = SVehicleSimCar(SimObj);
	SimCar.MaxSteerAngleCurve.Points[0].OutVal = SVehicleSimCar(Default.SimObj).MaxSteerAngleCurve.Points[0].OutVal;
	SimCar.MaxSteerAngleCurve.Points[1].OutVal = SVehicleSimCar(Default.SimObj).MaxSteerAngleCurve.Points[1].OutVal;
	SimCar.MaxSteerAngleCurve.Points[2].OutVal = SVehicleSimCar(Default.SimObj).MaxSteerAngleCurve.Points[2].OutVal;
}

/** DeactivateRocketBoosters()
called when player deactivates rocket boosters or they run out
*/
simulated event DeactivateRocketBoosters()
{
	local UTPlayerController PC;

	// Set handbrake to decrease the possibility of a rollover
//	bOutputHandbrake = TRUE;
//	bHoldingDownHandbrake = TRUE;
//	SetTimer(3.0f, FALSE, 'DeactivateHandbrake');
	AirSpeed = Default.AirSpeed;
	EnableFullSteering();

	if ( WorldInfo.NetMode == NM_DedicatedServer )
		return;

	PC = UTPlayerController(Controller);
	if ( PC != none )
	{
		PC.StartZoom(PC.DefaultFOV,120);
	}

	// play animation
	BoosterBlend.AnimStopFire();
	// deactivate booster sound and effects
	BoosterSound.Stop();
	VehicleEvent( 'BoostStop' );

	LeftBoosterLight.SetEnabled(FALSE);
	RightBoosterLight.SetEnabled(FALSE);
	Mesh.DetachComponent(LeftBoosterLight);
	Mesh.DetachComponent(RightBoosterLight);
	UnlockWheels();

	UTVehicleSimCar(SimObj).InAirUprightMaxTorque = DefaultUprightMaxTorque;
	UTVehicleSimCar(SimObj).InAirUprightTorqueFactor = DefaultUprightTorqueFactor;
}

function OnActivateRocketBoosters(UTSeqAct_ActivateRocketBoosters BoosterAction)
{
	bScriptedBoosters = true;
}

reliable server function ServerBoost()
{
    bTryToBoost = true;
}

simulated function float AdjustFOVAngle(float FOVAngle)
{
	if (bBoostersActivated)
	{
		return Lerp( FOVAngle, BoosterFOVAngle, FMin(WorldInfo.TimeSeconds - BoostStartTime, 1.0) );
	}
	else
	{
		return Lerp( BoosterFOVAngle, FOVAngle, FMin(WorldInfo.TimeSeconds - BoostChargeTime, 1.0) );
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

simulated function BlowupVehicle()
{
	if (bBoostersActivated)
	{
	    bBoostersActivated=FALSE;
		DeactivateRocketBoosters();
	}

	Super.BlowupVehicle();
}

event SelfDestruct(Actor ImpactedActor)
{
	Health = -100000;
	if(SelfDestructWarningComponent != none)
	{
		SelfDestructWarningComponent.Stop();
	}
	if(SelfDestructEnabledComponent != none)
	{
		SelfDestructEnabledComponent.Stop();
	}
	KillerController = SelfDestructInstigator;
	BlowUpVehicle();
	if ( ImpactedActor != None )
	{
		ImpactedActor.TakeDamage(600, SelfDestructInstigator, GetTargetLocation(), 200000 * Normal(Velocity), SelfDestructDamageType,, self);
	}
	HurtRadius(600,600, SelfDestructDamageType, 200000, GetTargetLocation(), ImpactedActor, SelfDestructInstigator);
	PlaySound(SelfDestructSoundCue);
	BoostStartTime = WorldInfo.TimeSeconds;
}

// The pawn Driver has tried to take control of this vehicle
function bool TryToDrive(Pawn P)
{
	return (SelfDestructInstigator == None) && Super.TryToDrive(P);
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bBladesExtended')
	{
		SetBladesExtended(bBladesExtended);
	}
	else if (VarName == 'bLeftBladeBroken')
	{
		BreakOffBlade(true);
	}
	else if (VarName == 'bRightBladeBroken')
	{
		BreakOffBlade(false);
	}
	else if (VarName == 'bBoostersActivated')
	{
		if ( bBoostersActivated )
		{
			ActivateRocketBoosters();
		}
		else
		{
			DeActivateRocketBoosters();
		}
	}
	else if (VarName == 'bSelfDestructArmed')
	{
		PlaySelfDestruct();
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function bool OverrideBeginFire(byte FireModeNum)
{
	if (FireModeNum == 1)
	{
		if (Role == ROLE_Authority && !bBladesExtended)
		{
			SetBladesExtended(true);
		}
		// note: the blade hit checks are in native tick
		return true;
	}

	return false;
}

simulated function bool OverrideEndFire(byte FireModeNum)
{
	if (FireModeNum == 1)
	{
		if (Role == ROLE_Authority && bBladesExtended)
		{
			SetBladesExtended(false);
		}
		return true;
	}

	return false;
}

/** extends and retracts the blades */
simulated function SetBladesExtended(bool bExtended)
{
	local int i;

	bBladesExtended = bExtended;
	if (bBladesExtended)
	{
		BladeBlend.AnimFire('Blades_out', true,,, 'Blades_out_idle');
		PlaySound(BladeExtendSound, true);
	}
	else
	{
		for (i = 0; i < 2; i++)
		{
			if (BladeVictimConstraint[i] != None)
			{
				BladeVictimConstraint[i].Destroy();
				BladeVictimConstraint[i] = None;
			}
		}
		BladeBlend.AnimStopFire();
		PlaySound(BladeRetractSound, true);
	}
}
simulated function PlaySelfDestruct()
{
	local UTGib HatchGib;
	local SkelControlBase SkelControl;

	DeadVehicleLifeSpan = BurnOutTime + 0.01;
	UTVehicleSimCar(SimObj).bDriverlessBraking = false;
	// play sound
	PlaySound(SelfDestructEnabledSound);
	if(SelfDestructWarningComponent == none)
	{
		SelfDestructWarningComponent = CreateAudioComponent(SelfDestructWarningSound, FALSE, TRUE);
		if ( SelfDestructWarningComponent != None )
		{
			SelfDestructWarningComponent.Location = Location;
			SelfDestructWarningComponent.bUseOwnerLocation = true;
			AttachComponent(SelfDestructWarningComponent);
		}
	}
	if ( SelfDestructWarningComponent != None )
	{
		SelfDestructWarningComponent.Play();
	}
	if(SelfDestructEnabledComponent == None)
	{
		SelfDestructEnabledComponent = CreateAudioComponent(SelfDestructEnabledLoop, FALSE, TRUE);
		if ( SelfDestructEnabledComponent != None )
		{
			SelfDestructEnabledComponent.Location = Location;
			SelfDestructEnabledComponent.bUseOwnerLocation = true;
			AttachComponent(SelfDestructEnabledComponent);
		}
	}
	if ( SelfDestructEnabledComponent != None )
	{
		SelfDestructEnabledComponent.FadeIn(1.0f,1.0f);
	}
	// blow off the hatch
	SkelControl = Mesh.FindSkelControl('Hatch');
	if (SkelControl != None)
	{
		SkelControl.BoneScale = 0.0;
		HatchGib = Spawn(HatchGibClass, self,, Mesh.GetBoneLocation('Hatch_Slide'), rot(0,0,0));
		if(HatchGib != none)
		{
			HatchGib.Velocity = 0.25*Velocity;
			HatchGib.Velocity.Z = 400.0;
			HatchGib.GibMeshComp.WakeRigidBody();
			HatchGib.GibMeshComp.SetRBLinearVelocity(HatchGib.Velocity, false);
		}
	}
	BigExplosionTemplates.length = 1;
	BigExplosionTemplates[0].Template = SelfDestructExplosionTemplate;
	BigExplosionTemplates[0].MinDistance = 0.0;
}

simulated function DisplayHud(UTHud Hud, Canvas Canvas, vector2D HudPOS, optional int SeatIndex)
{
	local PlayerController PC;
	super.DisplayHud(HUD, Canvas, HudPOS, SeatIndex);

	PC = PlayerController(Seats[0].SeatPawn.Controller);
	if (PC != none)
	{
		if (Throttle > 0.0 && !bBoostersActivated && (WorldInfo.TimeSeconds - BoostChargeTime > BoostChargeDuration))
		{
		   	Hud.DrawToolTip(Canvas, PC, "GBA_Jump", Canvas.ClipX * 0.5, Canvas.ClipY * 0.95, BoostToolTipIconCoords.U, BoostToolTipIconCoords.V, BoostToolTipIconCoords.UL, BoostToolTipIconCoords.VL, Canvas.ClipY / 768);
		}
		else if (ReadyToSelfDestruct())
		{
			Hud.DrawToolTip(Canvas, PC, "GBA_Use", Canvas.ClipX * 0.5, Canvas.ClipY * 0.95, EjectToolTipIconCoords.U, EjectToolTipIconCoords.V, EjectToolTipIconCoords.UL, EjectToolTipIconCoords.VL, Canvas.ClipY / 768);
		}
	}
}

function DriverLeft()
{
	if ( ReadyToSelfDestruct() )
	{
		SelfDestructInstigator = (Driver != none) ? Driver.Controller : None;

		bShouldEject = true;
		if ( PlayerController(SelfDestructInstigator) != None )
		{
			PlayerController(SelfDestructInstigator).ClientPlaySound(EjectSoundCue);
		}

		BoostStartTime = WorldInfo.TimeSeconds - MaxBoostDuration + 1.0;
		bSelfDestructArmed = true;
		PlaySelfDestruct();
	}
	else if (bBladesExtended)
	{
		SetBladesExtended(false);
	}

	Super.DriverLeft();
}

/**
 * Extra damage if hit while boosting
 */
simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local PlayerController PC;

	if (Role == ROLE_Authority)
	{
		if ( SelfDestructInstigator != None )
		{
			PC = PlayerController(SelfDestructInstigator);
			Damage *= 2.0;
		}
		else if ( bBoostersActivated )
			Damage *= 1.5;
	}

	Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);

	if ( (Role == ROLE_Authority) && (Health < 0) && (SelfDestructInstigator != None) && (EventInstigator != PC) )
	{
		if ( PC != None )
			PC.ReceiveLocalizedMessage(class'UTLastSecondMessage', 1, PC.PlayerReplicationInfo, None, None);
		if ( PlayerController(EventInstigator) != None )
		{
			PlayerController(EventInstigator).ReceiveLocalizedMessage(class'UTLastSecondMessage', 1, PC.PlayerReplicationInfo, None, None);
		}
	}
}

/** called when the blades hit something (not called for broken blades) */
simulated event BladeHit(Actor HitActor, vector HitLocation, bool bLeftBlade)
{
	local TraceHitInfo HitInfo;
	local vector VelDir;
	local Pawn P;
	local int index;

	if (HitActor.bBlockActors)
	{
		if (Vehicle(HitActor) != None)
		{
			if (HitActor.IsA('UTVehicle_Hoverboard'))
			{
				P = Vehicle(HitActor).Driver;
			}
		}
		else
		{
			P = Pawn(HitActor);
			if ( UTPawn(P) != None && UTPawn(P).IsHero() )
			{
				// heroes break blades
				P = None;
			}
		}

		// if we hit a vehicle or a non-pawn, break off the blade and do no damage
		if (P == None)
		{
			if (Role == ROLE_Authority)
			{
				if (bLeftBlade)
				{
					bLeftBladeBroken = true;
				}
				else
				{
					bRightBladeBroken = true;
				}
				BreakOffBlade(bLeftBlade);
			}
		}
		// else we hit a pawn and we are now going to do damage to said pawn
		else
		{
			if (Role == ROLE_Authority)
			{
				P.TakeDamage(1000, Controller, HitLocation, Velocity * 100.f, BladeDamageType);
			}
			if ( P.Health <= 0 && !P.bDeleteMe && P.Physics == PHYS_RigidBody
				&& P.Mesh != None && P.Mesh.PhysicsAssetInstance != None )
			{
				// grab ragdoll
				VelDir = Normal(Velocity);
				P.CheckHitInfo( HitInfo, P.Mesh, VelDir, HitLocation );
				if ( HitInfo.BoneName == '' )
				{
					P.CheckHitInfo( HitInfo, P.Mesh, Normal(P.Location - HitLocation), HitLocation );
				}
				if ( HitInfo.BoneName != '' )
				{
					index = 0;
					if ( BladeVictimConstraint[index] != None )
					{
						index = 1;
						if ( BladeVictimConstraint[index] != None )
						{
							index = 0;
							BladeVictimConstraint[index].Destroy();
							BladeVictimConstraint[index] = None;
						}
					}
					BladeVictimConstraint[index] = Spawn(class'RB_ConstraintActorSpawnable',,,HitLocation);
					BladeVictimConstraint[index].InitConstraint( self, P, '', HitInfo.BoneName, 200.f);
					BladeVictimConstraint[index].LifeSpan = 1 + 4*FRand();
				}
			}
		}
	}
}


/** If exit while boosting, boost out of the vehicle
Try to exit above
*/
function bool FindAutoExit(Pawn ExitingDriver)
{
	local vector X,Y,Z;
	local float PlaceDist;

	if ( bBoostersActivated )
	{
		GetAxes(Rotation, X,Y,Z);
		Y *= -1;

		PlaceDist = 150 + 4*ExitingDriver.GetCollisionHeight();

		if ( TryExitPos(ExitingDriver, GetTargetLocation() + PlaceDist * Z, false) )
			return true;
	}
	return Super.FindAutoExit(ExitingDriver);
}

//========================================
// AI Interface

function byte ChooseFireMode()
{
	local UTVehicle V;
	local float Dist;
	local vector FacingDir, EnemyDir;
	
	if ( bAISelfDestruct )
	{
		if ( !bTryToBoost )
			bAISelfDestruct = false;
		else
			return 0;
	}

	if ( Pawn(Controller.Focus) != None && Controller.MoveTarget == Controller.Focus
		&& Controller.InLatentExecution(Controller.LATENT_MOVETOWARD) )
	{
		V = UTVehicle(Controller.Focus);
		if ( V == None )
		{
			Dist = VSize(Controller.FocalPoint - Location);
			if ( Dist < 1200.0 && Controller.LineOfSightTo(Controller.Focus) )
		{
				if ( (WorldInfo.TimeSeconds - LastBladeBoostTime > 5) && (Dist > 200.0) )
				{
					LastBladeBoostTime = WorldInfo.TimeSeconds;
					FacingDir = vector(Rotation);
					FacingDir.Z = 0;
					EnemyDir = Controller.Focus.Location - Location;
					EnemyDir.Z = 0;
					bTryToBoost = (Normal(FacingDir) dot Normal(EnemyDir) > 0.93) && (FRand() < 0.5);
				}

			return 1;
		}
		}
		else if ( (V.Health > 300 || V.ImportantVehicle()) && Controller.LineOfSightTo(Controller.Focus) )
		{
			// self destruct to take out highly armored vehicle
			bTryToBoost = true;
			bAISelfDestruct = true;
			SetTimer(0.3, true, 'CheckScriptedSelfDestruct');
		}
	}
	else if ( UTOnslaughtNodeObjective(Controller.Focus) != None && Controller.MoveTarget == Controller.Focus
		&& Controller.InLatentExecution(Controller.LATENT_MOVETOWARD) )
	{
		// self destruct to take out highly armored vehicle
		bTryToBoost = true;
		bAISelfDestruct = true;
		SetTimer(0.3, true, 'CheckScriptedSelfDestruct');
	}

	return 0;
}

function bool TooCloseToAttack(Actor Other)
{
	if (Pawn(Other) != None && Vehicle(Other) == None)
	{
		return false;
	}
	return Super.TooCloseToAttack(Other);
}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	local UTBot B;

	// tell AI to boost through a slow volume
	if (Other.IsA('UTSlowVolume'))
	{
		B = UTBot(Controller);
		if (B != None && B.Skill >= 2.0)
		{
			bTryToBoost = true;
		}
	}
}

function IncomingMissile(Projectile P)
{
	local UTBot B;

	B = UTBot(Controller);
	if (Health < 200 && B != None && B.Skill > 4.0 + 4.0 * FRand() && VSize(P.Location - Location) < VSize(P.Velocity))
	{
		DriverLeave(false);
	}
}

simulated function TeamChanged()
{
	super.TeamChanged();
	// clear out the flags since we have a new material:
	bBrakeLightOn = false;
	bReverseLightOn = false;
	bHeadlightsOn=false;
}

function OnSelfDestruct(UTSeqAct_SelfDestruct Action)
{
	bScriptedBoosters = true;
	SetTimer(0.5, true, 'CheckScriptedSelfDestruct');
}

function CheckScriptedSelfDestruct()
{
	if ( ReadyToSelfDestruct() )
	{
		DriverLeave(true);
		ClearTimer('CheckScriptedSelfDestruct');
		bAISelfDestruct = false;
	}
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

/** breaks off the given blade by scaling the bone to zero and spawning effects */
simulated function BreakOffBlade(bool bLeftBlade)
{
	local SkelControlBase SkelControl;
	local vector BoneLoc;

	PlaySound(BladeBreakSound, true);
	SkelControl = Mesh.FindSkelControl(bLeftBlade ? 'LeftBlade' : 'RightBlade');
	BoneLoc = Mesh.GetBoneLocation(bLeftBlade? 'Blade_L2' : 'Blade_R2');

	if (SkelControl != None)
	{
		SkelControl.BoneScale = 0.0;
	}
	else
	{
		WarnInternal("Failed to find skeletal controller named" @ (bLeftBlade ? 'LeftBlade' : 'RightBlade') @ "for mesh" @ Mesh);
	}

	if (WorldInfo.NetMode != NM_DedicatedServer && !IsZero(BoneLoc))
	{
		SpawnGibVehicle(BoneLoc, Rotation, BrokenBladeMesh, BoneLoc, true, vect(0,0,0), None, None);
	}
}

simulated function CauseMuzzleFlashLight(int SeatIndex)
{
	Super.CauseMuzzleFlashLight(SeatIndex);

	//@FIXME: should have general code for this in UTVehicle
	if (SeatIndex == 0)
	{
		VehicleEvent('MuzzleFlash');
	}
}

/**
 * We override here as the scorpion uttlery destroys itself when it blows up!  So we need to turn off the damage effects as they
 * are out of place just floating in the air.
 **/
simulated function SetBurnOut()
{
	Super.SetBurnOut();

	if( DeathExplosion != none )
	{
		DeathExplosion.ParticleSystemComponent.DeactivateSystem();
	}

	VehicleEvent( 'NoDamageSmoke' );
}

function bool IsGoodTowTruck()
{
	return true;
}

function bool RecommendCharge(UTBot B, Pawn Enemy)
{
	local UTVehicle V;
	
	if ( Enemy.bCanFly )
	{
		return false;
	}
	V = UTVehicle(Enemy);
	return (V == None) || V.ImportantVehicle() || (V.Health > 300);
}	

/** Recommend high priority charge at enemy */
function bool CriticalChargeAttack(UTBot B)
{
	return (UTVehicle(B.Enemy) != None) && RecommendCharge(B, B.Enemy);
}

/** returns true if vehicle should charge attack this node (also responsible for setting up charge) */
function bool ChargeAttackObjective(UTBot B, UTGameObjective O)
{
	local vector FacingDir, EnemyDir;
	local float Dist;

	Dist = VSize(O.Location - Location);
	if ( bAISelfDestruct || (Dist < 200.0) )
	{
		if ( !bTryToBoost )
			bAISelfDestruct = false;
	}

	if ( !bAISelfDestruct )
	{
		// only charge if already facing right if close
		FacingDir = vector(Rotation);
		FacingDir.Z = 0;
		EnemyDir = O.Location - Location;
		EnemyDir.Z = 0;
		bTryToBoost = (Normal(FacingDir) dot Normal(EnemyDir) > 0.9);
		if ( bTryToBoost )
		{
			bAISelfDestruct = true;
			SetTimer(0.3, true, 'CheckScriptedSelfDestruct');
		}
		if ( !bTryToBoost && (Dist < 600) )
			return false;
	}

	B.GoalString = "Charge Objective";
	return B.Squad.FindPathToObjective(B, O);
}

defaultproperties
{
   BladeBreakPoint=0.800000
   BoosterForceMagnitude=450.000000
   BoosterCheckRadius=150.000000
   MaxBoostDuration=2.000000
   BoostChargeDuration=5.000000
   BoostChargeTime=-10.000000
   BoostPowerSpeed=1800.000000
   BoostReleaseDelay=0.150000
   BoosterFOVAngle=105.000000
   BoostUprightTorqueFactor=-45.000000
   BoostUprightMaxTorque=50.000000
   RocketSpeed=2000.000000
   SelfDestructSpeedSquared=810000.000000
   LockSuspensionTravel=37.000000
   LockSuspensionStiffness=62.500000
   BoostSteerFactors(0)=10.000000
   BoostSteerFactors(1)=4.000000
   BoostSteerFactors(2)=1.200000
   bStickDeflectionThrottle=True
   bLightArmor=True
   bLookSteerOnNormalControls=True
   bLookSteerOnSimpleControls=True
   bReducedFallingCollisionDamage=True
   DeflectionReverseThresh=-0.300000
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   MaxDesireability=0.400000
   ObjectiveGetOutDist=1500.000000
   VehicleIndex=10
   LookSteerSensitivity=2.200000
   LookSteerDamping=0.070000
   ConsoleSteerScale=1.100000
   StolenAnnouncementIndex=5
   VehiclePositionString="In uno Scorpion"
   VehicleNameString="Scorpion"
   SpawnRadius=125.000000
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=60.000000)
   DefaultFOV=80.000000
   CameraLag=0.070000
   Begin Object Class=UTVehicleSimCar Name=SimObject ObjName=SimObject Archetype=UTVehicleSimCar'UTGame.Default__UTVehicleSimCar'
      TorqueVSpeedCurve=(Points=((InVal=-600.000000),(InVal=-300.000000,OutVal=80.000000),(OutVal=130.000000),(InVal=950.000000,OutVal=130.000000),(InVal=1050.000000,OutVal=10.000000),(InVal=1150.000000)))
      EngineRPMCurve=(Points=((InVal=-500.000000,OutVal=2500.000000),(OutVal=500.000000),(InVal=549.000000,OutVal=3500.000000),(InVal=550.000000,OutVal=1000.000000),(InVal=849.000000,OutVal=4500.000000),(InVal=850.000000,OutVal=1500.000000),(InVal=1100.000000,OutVal=5000.000000)))
      bAutoHandbrake=True
      SteeringReductionFactor=0.000000
      NumWheelsForFullSteering=4
      SteeringReductionSpeed=1400.000000
      SteeringReductionMinSpeed=1100.000000
      HardTurnMotorTorque=0.700000
      FrontalCollisionGripFactor=0.180000
      SpeedBasedTurnDamping=20.000000
      AirControlTurnTorque=40.000000
      InAirUprightTorqueFactor=-30.000000
      InAirUprightMaxTorque=15.000000
      MaxSteerAngleCurve=(Points=((OutVal=45.000000),(InVal=600.000000,OutVal=15.000000),(InVal=1100.000000,OutVal=10.000000),(InVal=1300.000000,OutVal=6.000000),(InVal=1600.000000,OutVal=1.000000)))
      SteerSpeed=110.000000
      EngineBrakeFactor=0.025000
      MaxBrakeTorque=5.000000
      StopThreshold=100.000000
      WheelSuspensionStiffness=100.000000
      WheelSuspensionDamping=3.000000
      WheelSuspensionBias=0.100000
      WheelLatExtremumValue=0.900000
      WheelLatAsymptoteValue=0.900000
      WheelInertia=0.200000
      bClampedFrictionModel=True
      AutoDriveSteer=0.300000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimCar'UTGame.Default__UTVehicleSimCar'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleScorpionWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
      SkelControlName="B_R_Tire_Cont"
      BoneName="B_R_Tire"
      BoneOffset=(X=0.000000,Y=20.000000,Z=0.000000)
      Name="RRWheel"
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleScorpionWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
      SkelControlName="B_L_Tire_Cont"
      BoneName="B_L_Tire"
      BoneOffset=(X=0.000000,Y=-20.000000,Z=0.000000)
      Name="LRWheel"
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
   End Object
   Wheels(1)=LRWheel
   Begin Object Class=UTVehicleScorpionWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
      SteerFactor=1.000000
      SkelControlName="F_R_Tire_Cont"
      BoneName="F_R_Tire"
      BoneOffset=(X=0.000000,Y=20.000000,Z=0.000000)
      LatSlipFactor=3.000000
      HandbrakeLongSlipFactor=0.800000
      HandbrakeLatSlipFactor=0.800000
      Name="RFWheel"
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleScorpionWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
      SteerFactor=1.000000
      SkelControlName="F_L_Tire_Cont"
      BoneName="F_L_Tire"
      BoneOffset=(X=0.000000,Y=-20.000000,Z=0.000000)
      LatSlipFactor=3.000000
      HandbrakeLongSlipFactor=0.800000
      HandbrakeLatSlipFactor=0.800000
      Name="LFWheel"
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicleScorpionWheel'
   End Object
   Wheels(3)=LFWheel
   COMOffset=(X=-40.000000,Y=0.000000,Z=-36.000000)
   bCanFlip=True
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_12 ObjName=MyStayUprightSetup_12 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_12"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Scorpion:MyStayUprightSetup_12'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_12 ObjName=MyStayUprightConstraintInstance_12 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_12"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Scorpion:MyStayUprightConstraintInstance_12'
   HeavySuspensionShiftPercent=0.750000
   UprightLiftStrength=280.000000
   UprightTorqueStrength=500.000000
   UprightTime=1.250000
   bSeparateTurretFocus=True
   bHasHandbrake=True
   MomentumMult=0.500000
   NonPreferredVehiclePathMultiplier=1.500000
   GroundSpeed=950.000000
   AirSpeed=1100.000000
   Health=300
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Scorpion"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
