/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class Objective extends NavigationPoint
	native
	abstract
	placeable;

defaultproperties
{
   bMustBeReachable=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__Objective"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}