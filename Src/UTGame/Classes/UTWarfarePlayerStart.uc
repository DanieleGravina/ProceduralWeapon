/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTWarfarePlayerStart extends PlayerStart;

/** if set, prioritize this start when the associated objective is under attack */
var() bool bPrioritizeWhenUnderAttack;

defaultproperties
{
   bPrioritizeWhenUnderAttack=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__PlayerStart:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__PlayerStart:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__PlayerStart:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__PlayerStart:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__PlayerStart:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__PlayerStart:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__PlayerStart:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__PlayerStart:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__PlayerStart:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__PlayerStart:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTWarfarePlayerStart"
   ObjectArchetype=PlayerStart'Engine.Default__PlayerStart'
}
