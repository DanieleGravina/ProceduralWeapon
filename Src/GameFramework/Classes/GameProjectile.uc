/**
 * GameProjectile
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class GameProjectile extends Projectile
	config(Game)
	native
	abstract
	notplaceable;

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Projectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__Projectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Projectile:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Projectile:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__GameProjectile"
   ObjectArchetype=Projectile'Engine.Default__Projectile'
}
