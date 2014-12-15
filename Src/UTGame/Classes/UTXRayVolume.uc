/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


/** Applies X-Ray effect to all pawns inside the volume */
class UTXRayVolume extends PhysicsVolume
	notplaceable
	abstract;

/** saved partial damage (in case of high frame rate */
var float	SavedDamage;

/** minimum SavedDamage before we actually apply it
* (needs to be large enough to counter any scaling factors that might reduce to below 1)
*/
var float MinimumDamage;

/** each second, LifeSpan is decreased by this much extra for each living Pawn in the volume */
var float PawnLifeDrainPerSec;
/** Time dilation scaling factor for pawns in this volume */
var float PawnTimeScalingFactor;

var ParticleSystemComponent SlowEffect, GeneratorEffect;
var SkeletalMeshComponent GeneratorMesh;

/** sounds played for various actions */
var SoundCue ActivateSound, DestroySound, EnterSound, ExitSound;
/** ambient sounds */
var SoundCue OutsideAmbientSound, InsideAmbientSound;
var AudioComponent AmbientSoundComponent;

/** camera emitter played on player in volume */
var class<UTEmitCameraEffect> InsideCameraEffect;

/** Materials to use for characters when the XRay effect is active */
var Material XRayInvisMaterial;

/** We use a delegate so that different types of creators can get the OnDestroyed event */
delegate OnDeployableUsedUp(actor ChildDeployable);


simulated event PostBeginPlay()
{
	local vector HitLocation, HitNormal;
	local vector TraceStart;

	Super.PostBeginPlay();

	//Position of visual mesh (relative to actor location)
	TraceStart = Location + (GeneratorMesh.Translation >> Rotation);

	//Get the Z location of where the visual mesh will be placed
	if (Trace(HitLocation, HitNormal, TraceStart - vect(0,0,250), TraceStart, false) != None)
	{
		//But spawn the thing in the X/Y of the actor location
		HitLocation.X = Location.X;
		HitLocation.Y = Location.Y;
		SetLocation(HitLocation);
	}
	else
	{
		Destroy();
		return;
	}

	if (CollisionComponent == None)
	{
		WarnInternal("UTXRayVolume with no CollisionComponent");
	}
	if (GeneratorMesh != none)
	{
		GeneratorMesh.PlayAnim('Deploy');
		SetTimer(1.3f,false,'ActivateSlowEffect');
	}
	else
	{
		ActivateSlowEffect();
	}
	
	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		AmbientSoundComponent.SoundCue = OutsideAmbientSound;
		AmbientSoundComponent.Play();
	}

	if ( Role == ROLE_Authority )
	{
		SetTimer(1.0, true);
	}
}

simulated function Tick(float DeltaTime)
{
	local int SeatIndex;
	local float DamageAmount;
	local Actor HitActor;
	local Pawn HitPawn;
	local UTVehicle HitVehicle;

	DamageAmount = DamagePerSec;
	SavedDamage += DamageAmount * DeltaTime;
	DamageAmount = int(SavedDamage);

	// If the accumulated damage is large enough, pass it on to the actors
	if (DamageAmount >= MinimumDamage)
	{
		SavedDamage -= DamageAmount;
		foreach TouchingActors(class'Actor', HitActor)
		{
			if (Encompasses(HitActor))
			{
				HitPawn = Pawn(HitActor);
				HitVehicle = UTVehicle(HitActor);
				
				if (HitPawn != None || HitVehicle != None)
				{
					HitActor.TakeDamage(DamageAmount, DamageInstigator, HitActor.Location, vect(0,0,0), DamageType,,self);
				}
				if (HitVehicle != None)
				{
					// Now check each seat in the vehicle.
					for (SeatIndex = 0; SeatIndex < HitVehicle.Seats.length; ++SeatIndex)
					{
						HitPawn = HitVehicle.Seats[SeatIndex].StoragePawn;
						if (HitPawn != None)
						{
							HitPawn.TakeDamage(DamageAmount, DamageInstigator, HitActor.Location, vect(0,0,0), DamageType,,self);
						}
					}
				}
			}
		}
	}

	Super.Tick(DeltaTime);
}

simulated event CollisionChanged();

simulated function ActivateSlowEffect()
{
	local Actor A;

	SetCollision(true,false,false);
	// force any actors inside us to go slow
	foreach DynamicActors(class'Actor', A)
	{
		if ( Encompasses(A) && (A != self) )
		{
			A.SetZone(true);
		}
	}
	if (Role == ROLE_Authority)
	{
		PlaySound(ActivateSound);
	}
	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		if (SlowEffect != None)
		{
			SlowEffect.SetActive(true);
		}
		if (GeneratorEffect != None)
		{
			GeneratorEffect.SetActive(true);
		}
	}
}

simulated event Destroyed()
{
	local Actor A;

	Super.Destroyed();

	// force any actors inside us to go back to normal
	foreach DynamicActors(class'Actor', A)
	{
		if (Encompasses(A))
		{
			if (A.IsA('Pawn'))
			{
				PawnLeavingVolume(Pawn(A));
			}
		}
	}


	if (Role == ROLE_Authority)
	{
		PlaySound(DestroySound);
	}

	OnDeployableUsedUp(self);
}

simulated event PawnEnteredVolume(Pawn Other)
{
	local UTPawn OtherPawn;
	local UTPlayerController PC;

	ActorEnteredVolume(Other);
	OtherPawn = UTPawn(Other);
	PC = UTPlayerController(Other.Controller);
	if (PC != None && PC.IsLocalPlayerController())
	{
		PC.ClientPlaySound(EnterSound);
		AmbientSoundComponent.Stop();
		AmbientSoundComponent.SoundCue = InsideAmbientSound;
		AmbientSoundComponent.Play();
		if (InsideCameraEffect != None)
		{
			PC.ClientSpawnCameraEffect(InsideCameraEffect);
		}
	}
	if (OtherPawn != None)
	{
		OtherPawn.SetXRayEffect(true, XRayInvisMaterial);
		OtherPawn.CustomTimeDilation = PawnTimeScalingFactor;
	}
}

simulated function PawnLeavingVolume(Pawn Other)
{
	local UTPawn OtherPawn;
	local UTPlayerController PC;

	OtherPawn = UTPawn(Other);
	PC = UTPlayerController(Other.Controller);
	if (PC != None && PC.IsLocalPlayerController())
	{
		PC.ClientPlaySound(ExitSound);
		AmbientSoundComponent.Stop();
		AmbientSoundComponent.SoundCue = OutsideAmbientSound;
		AmbientSoundComponent.Play();
		if (InsideCameraEffect != None)
		{
			PC.ClearCameraEffect();
		}
	}
	if (OtherPawn != None)
	{
		OtherPawn.SetXRayEffect(false);
		OtherPawn.CustomTimeDilation = OtherPawn.Default.CustomTimeDilation;
	}
}

simulated function NotifyPawnBecameViewTarget(Pawn P, PlayerController PC)
{
	local UTPlayerController UTPC;

	if (InsideCameraEffect != None)
	{
		UTPC = UTPlayerController(PC);
		if (UTPC != None)
		{
			UTPC.ClientSpawnCameraEffect(InsideCameraEffect);
		}
	}
}

function Timer()
{
	local Pawn P;
	local UTGameObjective O;

	ForEach TouchingActors(class'Pawn', P)
	{
		if ( P.PlayerReplicationInfo != None )
		{
			LifeSpan -= PawnLifeDrainPerSec;
		}
	}
	ForEach TouchingActors(class'UTGameObjective', O)
	{
		if ( !O.bIsDisabled )
		{
			LifeSpan -= 1.5 * PawnLifeDrainPerSec;
		}
	}
	if ( LifeSpan == 0.0 )
	{
		Lifespan = 0.001;
	}
}

function Reset()
{
	Destroy();
}

simulated function bool StopsProjectile(Projectile P)
{
	return false;
}

defaultproperties
{
   MinimumDamage=1.000000
   PawnTimeScalingFactor=0.400000
   DamagePerSec=2.000000
   Priority=100000
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
      ObjectArchetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   RemoteRole=ROLE_SimulatedProxy
   bStatic=False
   bHidden=False
   bNoDelete=False
   bNetInitialRotation=True
   bCollideActors=False
   NetUpdateFrequency=1.000000
   LifeSpan=180.000000
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTXRayVolume"
   ObjectArchetype=PhysicsVolume'Engine.Default__PhysicsVolume'
}
