/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** UTVehicles with bIsOnTrack = true will only consider paths between these nodes */
class UTTrackTurretPathNode extends PathNode
	native;

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__PathNode:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__PathNode:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__PathNode:Sprite'
      Sprite=Texture2D'EngineResources.PathNode'
      ObjectArchetype=SpriteComponent'Engine.Default__PathNode:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__PathNode:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__PathNode:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__PathNode:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__PathNode:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__PathNode:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__PathNode:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTTrackTurretPathNode"
   ObjectArchetype=PathNode'Engine.Default__PathNode'
}
