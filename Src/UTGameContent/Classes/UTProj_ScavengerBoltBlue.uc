/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_ScavengerBoltBlue extends UTProj_ScavengerBolt;

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_Scavenger.Effects.P_Scavenger_Death_Ball_Blue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_ScavengerBolt:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_ScavengerBolt:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_ScavengerBoltBlue"
   ObjectArchetype=UTProj_ScavengerBolt'UTGameContent.Default__UTProj_ScavengerBolt'
}
