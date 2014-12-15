class Trigger_Dynamic extends Trigger;

/**
 * Dynamic Trigger
 * Can be attached and moved in the level. More expensive than (static) triggers, use only when necessary.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Trigger:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__Trigger:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Trigger:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Trigger:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__Trigger_Dynamic"
   ObjectArchetype=Trigger'Engine.Default__Trigger'
}
