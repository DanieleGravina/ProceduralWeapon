/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_FuryBolt extends UTProjectile;

/**
attenuate damage over time
*/
function AttenuateDamage()
{
	if ( LifeSpan < 1.0 )
		Damage = 0.75 * Default.Damage;
	else
		Damage = Default.Damage * FMin(2.5, Square(MaxSpeed)/VSizeSq(Velocity));
}

simulated function HitWall(vector HitNormal, actor Wall, PrimitiveComponent WallComp)
{
	AttenuateDamage();
	Super.HitWall(HitNormal, Wall, WallComp);
}

simulated function ProcessTouch(Actor Other, Vector HitLocation, Vector HitNormal)
{
	AttenuateDamage();
	Super.ProcessTouch(Other, HitLocation, HitNormal);
}

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_Fury.Effects.P_VH_Fury_Projectile'
   ProjExplosionTemplate=ParticleSystem'VH_Fury.Effects.P_VH_Fury_Projectile_Impact'
   AccelRate=20000.000000
   MaxSpeed=12500.000000
   Damage=20.000000
   DamageRadius=200.000000
   MomentumTransfer=4000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_FuryBolt'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   LifeSpan=1.600000
   DrawScale=1.200000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_FuryBolt"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
