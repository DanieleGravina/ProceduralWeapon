/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_ScorpionGlob_Red extends UTProj_ScorpionGlob_Base;

defaultproperties
{
   ExplosionSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactExplode_Cue'
   ProjFlightTemplate=ParticleSystem'VH_Scorpion.Effects.P_Scorpion_Bounce_Projectile_Red'
   ProjExplosionTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Gun_Impact_Red'
   MyDamageType=Class'UTGameContent.UTDmgType_ScorpionGlobRed'
   ImpactSound=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireImpactFizzle_Cue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_ScorpionGlob_Base:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_ScorpionGlob_Base:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_ScorpionGlob_Red"
   ObjectArchetype=UTProj_ScorpionGlob_Base'UTGame.Default__UTProj_ScorpionGlob_Base'
}
