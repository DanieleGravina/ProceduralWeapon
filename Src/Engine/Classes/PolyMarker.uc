//=============================================================================
// PolyMarker.
//
// These are markers for the polygon drawing mode.
//
// These should NOT be manually added to the level.  The editor adds and
// deletes them on it's own.
//
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class PolyMarker extends Keypoint
	placeable
	native;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Keypoint:Sprite'
      Sprite=Texture2D'EngineResources.S_PolyMarker'
      ObjectArchetype=SpriteComponent'Engine.Default__Keypoint:Sprite'
   End Object
   Components(0)=Sprite
   bEdShouldSnap=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__PolyMarker"
   ObjectArchetype=Keypoint'Engine.Default__Keypoint'
}
