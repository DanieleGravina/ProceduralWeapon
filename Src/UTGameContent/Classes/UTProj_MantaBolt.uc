/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_MantaBolt extends UTProjectile;

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{
	local vector x;
	if ( WorldInfo.NetMode != NM_DedicatedServer && EffectIsRelevant(Location,false,MaxEffectDistance) )
	{
		x = normal(Velocity cross HitNormal);
		x = normal(HitNormal cross x);

		WorldInfo.MyEmitterPool.SpawnEmitter(ProjExplosionTemplate, HitLocation, rotator(x));
		bSuppressExplosionFX = true;
	}

	if (ExplosionSound!=None)
	{
		PlaySound(ExplosionSound);
	}
}

defaultproperties
{
   ExplosionSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Shot'
   ProjFlightTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Projectile'
   ProjExplosionTemplate=ParticleSystem'VH_Manta.Effects.PS_Manta_Gun_Impact'
   AccelRate=16000.000000
   CheckRadius=30.000000
   MaxSpeed=7000.000000
   Damage=36.000000
   MomentumTransfer=4000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_MantaBolt'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   LifeSpan=1.600000
   DrawScale=2.000000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_MantaBolt"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
