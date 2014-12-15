//=============================================================================
// A sticky note.  Level designers can place these in the level and then
// view them as a batch in the error/warnings window.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class Note extends Actor
	placeable
	native;

var() string Text;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=255,G=200,R=150,A=255)
      ArrowSize=0.500000
      Name="Arrow"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(0)=Arrow
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EngineResources.S_Note'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(1)=Sprite
   bStatic=True
   bHidden=True
   bNoDelete=True
   bMovable=False
   CollisionType=COLLIDE_CustomDefault
   Name="Default__Note"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
