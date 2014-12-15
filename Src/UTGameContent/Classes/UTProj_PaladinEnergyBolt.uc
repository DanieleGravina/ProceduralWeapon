/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTProj_PaladinEnergyBolt extends UTProjectile;

defaultproperties
{
   ExplosionSound=SoundCue'A_Vehicle_Paladin.SoundCues.A_Vehicle_Paladin_FireImpact'
   ProjFlightTemplate=ParticleSystem'VH_Paladin.Effects.P_VH_Paladin_PrimaryProj'
   ProjExplosionTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Explo'
   CheckRadius=40.000000
   ExplosionLightClass=Class'UTGame.UTShockComboExplosionLight'
   Speed=9000.000000
   MaxSpeed=9000.000000
   Damage=200.000000
   DamageRadius=450.000000
   MomentumTransfer=200000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_PaladinEnergyBolt'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_PaladinEnergyBolt"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
