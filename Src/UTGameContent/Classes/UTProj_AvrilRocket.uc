/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_AvrilRocket extends UTProj_AvrilRocketBase;

var array<DistanceBasedParticleTemplate> DistanceExplosionTemplates;

simulated function SpawnExplosionEffects(vector HitLocation, vector HitNormal)
{
	ProjExplosionTemplate = class'UTEmitter'.static.GetTemplateForDistance(DistanceExplosionTemplates, HitLocation, WorldInfo);

	Super.SpawnExplosionEffects(HitLocation, HitNormal);
}

defaultproperties
{
   DistanceExplosionTemplates(0)=(Template=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo_far',MinDistance=3500.000000)
   DistanceExplosionTemplates(1)=(Template=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo_mid',MinDistance=450.000000)
   DistanceExplosionTemplates(2)=(Template=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo_close')
   LockWarningInterval=1.000000
   bWaitForEffects=True
   AmbientSound=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRiL_Travel01Cue'
   ExplosionSound=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRiL_Impact01Cue'
   ProjFlightTemplate=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Smoke_Trail'
   ProjExplosionTemplate=ParticleSystem'WP_AVRiL.Particles.P_WP_Avril_Explo'
   AccelRate=750.000000
   ExplosionLightClass=Class'UTGame.UTRocketExplosionLight'
   Speed=550.000000
   MaxSpeed=2800.000000
   bRotationFollowsVelocity=True
   Damage=125.000000
   DamageRadius=150.000000
   MomentumTransfer=150000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_AvrilRocket'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_AvrilRocketBase:CollisionCylinder'
      CollisionHeight=18.000000
      CollisionRadius=18.000000
      CollideActors=True
      BlockActors=True
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_AvrilRocketBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bNetTemporary=False
   bUpdateSimulatedPosition=True
   bCollideComplex=False
   bProjTarget=True
   LifeSpan=7.000000
   CollisionComponent=CollisionCylinder
   RotationRate=(Pitch=0,Yaw=0,Roll=50000)
   DesiredRotation=(Pitch=0,Yaw=0,Roll=30000)
   Name="Default__UTProj_AvrilRocket"
   ObjectArchetype=UTProj_AvrilRocketBase'UTGame.Default__UTProj_AvrilRocketBase'
}
