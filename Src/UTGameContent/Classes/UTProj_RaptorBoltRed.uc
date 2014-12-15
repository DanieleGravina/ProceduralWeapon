/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_RaptorBoltRed extends UTProj_RaptorBolt;

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_Raptor.Effects.PS_Raptor_Projectile_Red'
   ProjExplosionTemplate=ParticleSystem'VH_Raptor.Effects.PS_Raptor_Gun_Impact'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_RaptorBolt:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_RaptorBolt:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_RaptorBoltRed"
   ObjectArchetype=UTProj_RaptorBolt'UTGameContent.Default__UTProj_RaptorBolt'
}
