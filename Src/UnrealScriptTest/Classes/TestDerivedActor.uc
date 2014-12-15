/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


//-----------------------------------------------------------
//
//-----------------------------------------------------------
class TestDerivedActor extends TestPlaceableActor;

var() instanced Test0020_StructDefaults	StructDefaultTestObj;

defaultproperties
{
   Begin Object Class=InheritanceTestDerived Name=TestComp ObjName=TestComp Archetype=InheritanceTestDerived'UnrealScriptTest.Default__TestPlaceableActor:TestComp'
      Begin Object Class=NestingTest_SecondLevelComponent Name=NestingTestComponent ObjName=NestingTestComponent Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__TestPlaceableActor:TestComp.NestingTestComponent'
         ObjectArchetype=NestingTest_SecondLevelComponent'NestingTestComponent'
      End Object
      ObjectArchetype=InheritanceTestDerived'UnrealScriptTest.Default__TestPlaceableActor:TestComp'
   End Object
   ComponentVar=TestComp
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UnrealScriptTest.Default__TestPlaceableActor:Sprite'
      ObjectArchetype=SpriteComponent'UnrealScriptTest.Default__TestPlaceableActor:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=TestComp
   Name="Default__TestDerivedActor"
   ObjectArchetype=TestPlaceableActor'UnrealScriptTest.Default__TestPlaceableActor'
}
