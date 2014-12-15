/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_DarkWalkerBolt extends UTProjectile;

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_Darkwalker_Secondary_Projectile'
   ProjExplosionTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_Darkwalker_Secondary_Impact'
   AccelRate=20000.000000
   CheckRadius=40.000000
   Speed=4000.000000
   MaxSpeed=10000.000000
   Damage=40.000000
   MomentumTransfer=4000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_DarkWalkerBolt'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   LifeSpan=1.600000
   DrawScale=1.200000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_DarkWalkerBolt"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
