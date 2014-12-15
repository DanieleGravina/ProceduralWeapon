//=============================================================================
// PhysicsVolume:  a bounding volume which affects actor physics
// Each Actor is affected at any time by one PhysicsVolume
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class PhysicsVolume extends Volume
	native
	nativereplication
	placeable;

var()		interp vector	ZoneVelocity;
var()		bool		bVelocityAffectsWalking;
var()		float		GroundFriction;
var()		float		TerminalVelocity;
var()		float		DamagePerSec;
var() class<DamageType>	DamageType<AllowAbstract>;
var()		int			Priority;	// determines which PhysicsVolume takes precedence if they overlap
var() float  FluidFriction;

var()		bool	bPainCausing;			// Zone causes pain.
var			bool	BACKUP_bPainCausing;
var()		bool	bDestructive;			// Destroys most actors which enter it.
var()		bool	bNoInventory;
var()		bool	bMoveProjectiles;		// this velocity zone should impart velocity to projectiles and effects
var()		bool	bBounceVelocity;		// this velocity zone should bounce actors that land in it
var()		bool	bNeutralZone;			// Players can't take damage in this zone.

/**
 *	By default, the origin of an Actor must be inside a PhysicsVolume for it to affect it.
 *	If this flag is true though, if this Actor touches the volume at all, it will affect it.
 */
var()		bool	bPhysicsOnContact;

/**
 *	This controls the force that will be applied to PHYS_RigidBody objects in this volume to get them
 *	to match the ZoneVelocity.
 */
var()		float	RigidBodyDamping;

/** Applies a cap on the maximum damping force that is applied to objects. */
var()		float	MaxDampingForce;

var			bool	bWaterVolume;
var	Info PainTimer;

/** Controller that gets credit for any damage caused by this volume */
var Controller DamageInstigator;

var PhysicsVolume NextPhysicsVolume;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

native function float GetGravityZ();

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	BACKUP_bPainCausing	= bPainCausing;

	if ( Role < ROLE_Authority )
		return;
	if ( bPainCausing )
		PainTimer = Spawn(class'VolumeTimer', self);
}

/* Reset() - reset actor to initial state - used when restarting level without reloading. */
function Reset()
{
	bPainCausing	= BACKUP_bPainCausing;
	bForceNetUpdate = TRUE;
}

/* Called when an actor in this PhysicsVolume changes its physics mode
*/
event PhysicsChangedFor(Actor Other);

event ActorEnteredVolume(Actor Other);
event ActorLeavingVolume(Actor Other);

event PawnEnteredVolume(Pawn Other);
event PawnLeavingVolume(Pawn Other);

simulated function OnToggle( SeqAct_Toggle inAction )
{
	Super.OnToggle( inAction );

	if( inAction.InputLinks[0].bHasImpulse )
	{
		// Turn on pain if that was it's original state
		bPainCausing = BACKUP_bPainCausing;
	}
	else
	if( inAction.InputLinks[1].bHasImpulse )
	{
		// Turn off pain
		bPainCausing = FALSE;
	}
	else
	if( inAction.InputLinks[2].bHasImpulse )
	{
		// Toggle pain off, or on if original state caused pain
		bPainCausing = !bPainCausing && BACKUP_bPainCausing;
	}
}

/*
TimerPop
damage touched actors if pain causing.
since PhysicsVolume is static, this function is actually called by a volumetimer
*/
function TimerPop(VolumeTimer T)
{
	local actor A;

	if ( T == PainTimer )
	{
		if ( !bPainCausing )
			return;

		ForEach TouchingActors(class'Actor', A)
			if ( A.bCanBeDamaged && !A.bStatic )
			{
				CausePainTo(A);
			}
	}
}

simulated event Touch( Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal )
{
	Super.Touch(Other, OtherComp, HitLocation, HitNormal);
	if ( (Other == None) || Other.bStatic )
		return;
	if ( bNoInventory && (DroppedPickup(Other) != None) && (Other.Owner == None) )
	{
		Other.LifeSpan = 1.5;
		return;
	}
	if ( bMoveProjectiles && (ZoneVelocity != vect(0,0,0)) )
	{
		if ( Other.Physics == PHYS_Projectile )
			Other.Velocity += ZoneVelocity;
			else if ( (Other.Base == None) && Other.IsA('Emitter') && (Other.Physics == PHYS_None) )
		{
			Other.SetPhysics(PHYS_Projectile);
			Other.Velocity += ZoneVelocity;
		}
	}
	if ( bPainCausing )
	{
		if ( Other.bDestroyInPainVolume )
		{
			Other.Destroy();
			return;
		}
			if ( Other.bCanBeDamaged )
			{
				CausePainTo(Other);
			}
	}
}

function CausePainTo(Actor Other)
{
	if (DamagePerSec > 0)
	{
		if ( WorldInfo.bSoftKillZ && (Other.Physics != PHYS_Walking) )
			return;
		if ( (DamageType == None) || (DamageType == class'DamageType') )
			LogInternal("No valid damagetype specified for "$self);
		Other.TakeDamage(DamagePerSec, DamageInstigator, Location, vect(0,0,0), DamageType);
	}
	else
	{
		Other.HealDamage(DamagePerSec, DamageInstigator, DamageType);
	}
}

/** called from GameInfo::SetPlayerDefaults() on the Pawn's PhysicsVolume after the its default movement properties have been restored
 * allows the volume to reapply any movement modifiers on the Pawn
 */
function ModifyPlayer(Pawn PlayerPawn);

/** notification when a Pawn inside this volume becomes the ViewTarget for a PlayerController */
function NotifyPawnBecameViewTarget(Pawn P, PlayerController PC);

/** Kismet hook to set DamageInstigator */
function OnSetDamageInstigator(SeqAct_SetDamageInstigator Action)
{
	DamageInstigator = Action.GetController(Action.DamageInstigator);
}

defaultproperties
{
   bVelocityAffectsWalking=True
   GroundFriction=8.000000
   TerminalVelocity=3500.000000
   DamageType=Class'Engine.DamageType'
   FluidFriction=0.300000
   MaxDampingForce=1000000.000000
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
      BlockZeroExtent=True
      ObjectArchetype=BrushComponent'Engine.Default__Volume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   bAlwaysRelevant=True
   bOnlyDirtyReplication=True
   NetUpdateFrequency=0.100000
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_TouchAll
   Name="Default__PhysicsVolume"
   ObjectArchetype=Volume'Engine.Default__Volume'
}
