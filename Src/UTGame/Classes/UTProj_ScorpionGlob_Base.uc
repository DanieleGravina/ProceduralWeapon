/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_ScorpionGlob_Base extends UTProjectile
	abstract
	native;

/** Used in TickSpecial() manta seeking code */
var float LastTraceTime;

var pawn SeekTarget;

var float SeekRangeSq;

/** Acceleration while homing in on hover vehicle */
var float SeekAccel;

/** used to notify AI of bio on the ground */
var UTAvoidMarker FearSpot;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if ( bNetDirty )
		SeekTarget;
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (FearSpot != None)
	{
		FearSpot.Destroy();
	}
}

simulated function Shutdown()
{
	super.ShutDown();

		if (FearSpot != None)
	{
		FearSpot.Destroy();
	}
}

simulated event PhysicsVolumeChange(PhysicsVolume NewVolume)
{
	if ( PhysicsVolume.bWaterVolume && !NewVolume.bWaterVolume )
	{
		SetTimer(5.0, false, 'Explode');
		Buoyancy = 0.5 * (Buoyancy + 1.08);

		// spawn marker so AI can avoid
		if (FearSpot == None && WorldInfo.Game != None && WorldInfo.Game.NumBots > 0)
		{
			FearSpot = Spawn(class'UTAvoidMarker');
		}
	}
}

/**
 * Explode this glob
 */
simulated function Explode(Vector HitLocation, vector HitNormal)
{
	super.Explode(HitLocation, HitNormal);
	if (FearSpot != None)
	{
		FearSpot.Destroy();
	}
}

defaultproperties
{
   SeekRangeSq=250000.000000
   SeekAccel=6000.000000
   ExplosionDecal=MaterialInstanceTimeVarying'WP_RocketLauncher.Decals.MITV_WP_RocketLauncher_Impact_Decal01'
   DecalWidth=128.000000
   DecalHeight=128.000000
   MaxEffectDistance=7000.000000
   CheckRadius=36.000000
   ExplosionLightClass=Class'UTGame.UTRocketExplosionLight'
   Buoyancy=1.500000
   Speed=4000.000000
   MaxSpeed=4000.000000
   Damage=80.000000
   DamageRadius=220.000000
   MomentumTransfer=40000.000000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Physics=PHYS_Falling
   bNetTemporary=False
   LifeSpan=1.600000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_ScorpionGlob_Base"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
