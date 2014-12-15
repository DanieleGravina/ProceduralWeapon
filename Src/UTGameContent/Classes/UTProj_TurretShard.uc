/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_TurretShard extends UTProj_StingerShard;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'UTGame.Default__UTProj_StingerShard:ProjectileMesh'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTProj_StingerShard:ProjectileMesh'
   End Object
   MyMesh=ProjectileMesh
   ProjFlightTemplate=ParticleSystem'VH_Leviathan.Effects.PS_VH_Leviathan_Shard'
   ProjExplosionTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_ShardImpact'
   AccelRate=3000.000000
   Speed=4500.000000
   MaxSpeed=6000.000000
   Damage=30.000000
   MyDamageType=Class'UTGameContent.UTDmgType_TurretShard'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_StingerShard:CollisionCylinder'
      CollisionHeight=13.000000
      CollisionRadius=13.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_StingerShard:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bCollideComplex=False
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_TurretShard"
   ObjectArchetype=UTProj_StingerShard'UTGame.Default__UTProj_StingerShard'
}
