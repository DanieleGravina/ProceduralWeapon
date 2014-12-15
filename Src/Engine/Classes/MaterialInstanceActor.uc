/**
 *	Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 *	Utility class designed to allow you to connect a MaterialInterface to a Matinee action.
 */

class MaterialInstanceActor extends Actor
	native
	placeable
	hidecategories(Movement)
	hidecategories(Advanced)
	hidecategories(Collision)
	hidecategories(Display)
	hidecategories(Actor)
	hidecategories(Attachment);

/** Pointer to MaterialInterface that we want to control paramters of using Matinee. */
var()	MaterialInstanceConstant	MatInst;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EngineResources.MatInstActSprite'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   bNoDelete=True
   Name="Default__MaterialInstanceActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
