/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


//-----------------------------------------------------------
//
//-----------------------------------------------------------
class TestPlaceableActor extends Actor
	placeable;

var()	editconst	InheritanceTestDerived		ComponentVar;
var()	InheritanceTestDerived					RuntimeComponent;

defaultproperties
{
   Begin Object Class=InheritanceTestDerived Name=TestComp ObjName=TestComp Archetype=InheritanceTestDerived'UnrealScriptTest.Default__InheritanceTestDerived'
      Begin Object Class=NestingTest_SecondLevelComponent Name=NestingTestComponent ObjName=NestingTestComponent Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__InheritanceTestDerived:NestingTestComponent'
         ObjectArchetype=NestingTest_SecondLevelComponent'NestingTestComponent'
      End Object
      TestInt=5
      Name="TestComp"
      ObjectArchetype=InheritanceTestDerived'UnrealScriptTest.Default__InheritanceTestDerived'
   End Object
   ComponentVar=TestComp
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   Components(1)=TestComp
   CollisionType=COLLIDE_CustomDefault
   Name="Default__TestPlaceableActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
