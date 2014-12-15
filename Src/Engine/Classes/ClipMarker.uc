/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Clip markers for brush clipping mode.  2 or 3 of these are placed in a level to define a clipping plane.
 * These should NOT be manually added to the level -- the editor automatically adds and deletes them as necessary.
 */
class ClipMarker extends Keypoint
	placeable
	native;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Keypoint:Sprite'
      Sprite=Texture2D'EngineResources.S_ClipMarker'
      ObjectArchetype=SpriteComponent'Engine.Default__Keypoint:Sprite'
   End Object
   Components(0)=Sprite
   bEdShouldSnap=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__ClipMarker"
   ObjectArchetype=Keypoint'Engine.Default__Keypoint'
}
