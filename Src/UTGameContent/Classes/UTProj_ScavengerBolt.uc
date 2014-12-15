/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_ScavengerBolt extends UTProj_ScavengerBoltBase;

defaultproperties
{
   BeamEffect=ParticleSystem'WP_LinkGun.Effects.P_WP_Linkgun_Altbeam_Gold'
   AmbientSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_OrbLoop01_Cue'
   ExplosionSound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_FireImpact_Cue'
   ProjFlightTemplate=ParticleSystem'VH_Scavenger.Effects.P_Scavenger_Death_Ball'
   ProjExplosionTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_Gun_Explode'
   MyDamageType=Class'UTGameContent.UTDmgType_ScavengerBolt'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_ScavengerBoltBase:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_ScavengerBoltBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_ScavengerBolt"
   ObjectArchetype=UTProj_ScavengerBoltBase'UTGame.Default__UTProj_ScavengerBoltBase'
}
