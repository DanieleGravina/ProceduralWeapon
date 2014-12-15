/*=============================================================================
// AutoLadder - automatically placed at top and bottom of LadderVolume
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
============================================================================= */

class AutoLadder extends Ladder
	notplaceable
	native;

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Ladder:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__Ladder:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Ladder:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Ladder:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__Ladder:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__Ladder:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__Ladder:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__Ladder:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__Ladder:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__Ladder:PathRenderer'
   End Object
   Components(4)=PathRenderer
   bCollideWhenPlacing=False
   CollisionComponent=CollisionCylinder
   Name="Default__AutoLadder"
   ObjectArchetype=Ladder'Engine.Default__Ladder'
}
