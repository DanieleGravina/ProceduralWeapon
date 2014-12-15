/**
 * Used for testing and verifying actors which contain components which are inherited from a base class.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class CTInheritTestRoot extends ComponentTestActorBase
	native;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
      ObjectArchetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__CTInheritTestRoot"
   ObjectArchetype=ComponentTestActorBase'UnrealScriptTest.Default__ComponentTestActorBase'
}
