/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_LeviathanRocket extends UTProj_Rocket;

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_MissileTrailIgnited'
   ProjExplosionTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_MissileExplosion'
   Speed=5000.000000
   MaxSpeed=5000.000000
   Damage=80.000000
   DamageRadius=180.000000
   MomentumTransfer=50000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_LeviathanRocket'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_Rocket:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_LeviathanRocket"
   ObjectArchetype=UTProj_Rocket'UTGame.Default__UTProj_Rocket'
}
