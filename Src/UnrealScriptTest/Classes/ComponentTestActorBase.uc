/**
 * Base class for all actors used in testing and verifying the behavior of components.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class ComponentTestActorBase extends Actor
	placeable
	abstract
	native;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   CollisionType=COLLIDE_CustomDefault
   Name="Default__ComponentTestActorBase"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
