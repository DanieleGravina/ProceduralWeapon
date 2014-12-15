/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_ScorpionGlob extends UTProj_ScorpionGlob_Base;

defaultproperties
{
   ExplosionSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue'
   ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile'
   ProjExplosionTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Gun_Impact'
   MyDamageType=Class'UTGameContent.UTDmgType_ScorpionGlob'
   ImpactSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactFizzle_Cue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_ScorpionGlob_Base:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_ScorpionGlob_Base:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_ScorpionGlob"
   ObjectArchetype=UTProj_ScorpionGlob_Base'UTGame.Default__UTProj_ScorpionGlob_Base'
}
