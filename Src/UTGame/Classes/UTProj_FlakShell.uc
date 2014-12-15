/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_FlakShell extends UTProjectile;

simulated function Explode(vector HitLocation, vector HitNormal)
{
	local vector SpawnPos, BaseChunkDir;
	local actor HitActor;
	local rotator rot;
	local int i;
	local UTProj_FlakShard NewChunk;

	Super.Explode(HitLocation, HitNormal);

	SpawnPos = Location + 10 * HitNormal;

	HitActor = Trace(HitLocation, HitNormal, SpawnPos, Location, false);
	if (HitActor != None)
	{
		SpawnPos = HitLocation;
	}

	if ( (Role == ROLE_Authority) && (UTVehicle(ImpactedActor) == None) )
	{
		BaseChunkDir = Normal(HitNormal + 0.8 * Normal(Velocity));
		for (i = 0; i < 5; i++)
		{
			rot = rotator(4*BaseChunkDir + VRand());
			NewChunk = Spawn(class 'UTProj_FlakShard',, '', SpawnPos, rot);
			if (NewChunk != None)
			{
				NewChunk.bCheckShortRangeKill = false;
				NewChunk.Init(vector(rot));
			}
		}
	}
}

defaultproperties
{
   bWaitForEffects=True
   AmbientSound=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_FireAltInAirCue'
   ExplosionSound=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_FireAltImpactExplodeCue'
   ProjFlightTemplate=ParticleSystem'WP_FlakCannon.Effects.P_WP_Flak_Alt_Smoke_Trail'
   ProjExplosionTemplate=ParticleSystem'WP_FlakCannon.Effects.P_WP_Flak_Alt_Explosion'
   ExplosionDecal=MaterialInstanceTimeVarying'WP_FlakCannon.Decals.MITV_WP_FlakCannon_Impact_Decal01'
   DecalWidth=128.000000
   DecalHeight=128.000000
   TossZ=305.000000
   CheckRadius=40.000000
   ExplosionLightClass=Class'UTGame.UTRocketExplosionLight'
   Speed=1200.000000
   bRotationFollowsVelocity=True
   Damage=100.000000
   DamageRadius=200.000000
   MomentumTransfer=75000.000000
   MyDamageType=Class'UTGame.UTDmgType_FlakShell'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Physics=PHYS_Falling
   LifeSpan=6.000000
   DrawScale=1.500000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_FlakShell"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
