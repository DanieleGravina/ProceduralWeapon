/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_RaptorRocketRed extends UTProj_RaptorRocket;

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Rocket_trail'
   ProjExplosionTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_RocketExplosion'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_RaptorRocket:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_RaptorRocket:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_RaptorRocketRed"
   ObjectArchetype=UTProj_RaptorRocket'UTGameContent.Default__UTProj_RaptorRocket'
}
