/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_TankShell extends UTProjectile;

var array<DistanceBasedParticleTemplate> DistanceExplosionTemplates;

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{
	ProjExplosionTemplate = class'UTEmitter'.static.GetTemplateForDistance(DistanceExplosionTemplates, HitLocation, WorldInfo);

	Super.SpawnExplosionEffects(HitLocation, HitNormal);
}

defaultproperties
{
   DistanceExplosionTemplates(0)=(Template=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Cannon_Impact_FAR',MinDistance=3000.000000)
   DistanceExplosionTemplates(1)=(Template=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Cannon_Impact_MID',MinDistance=400.000000)
   DistanceExplosionTemplates(2)=(Template=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Cannon_Impact_Close')
   bWaitForEffects=True
   bAttachExplosionToVehicles=False
   AmbientSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Travel_Cue'
   ExplosionSound=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Explode'
   ProjFlightTemplate=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Cannon_Trail'
   ExplosionDecal=DecalMaterial'VH_Goliath.Materials.DM_Goliath_Cannon_Decal'
   DecalWidth=350.000000
   DecalHeight=350.000000
   ExplosionLightClass=Class'UTGame.UTTankShellExplosionLight'
   MaxExplosionLightDistance=7000.000000
   Speed=15000.000000
   MaxSpeed=15000.000000
   Damage=360.000000
   DamageRadius=630.000000
   MomentumTransfer=150000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_TankShell'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bAlwaysRelevant=True
   LifeSpan=1.200000
   CollisionComponent=CollisionCylinder
   RotationRate=(Pitch=0,Yaw=0,Roll=50000)
   DesiredRotation=(Pitch=0,Yaw=0,Roll=30000)
   Name="Default__UTProj_TankShell"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
