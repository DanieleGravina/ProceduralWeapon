/**
 * Component for testing instancing nested subobjects.
 * This component contains its own instanced subobjects and components.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class NestingTest_FirstLevelComponent extends TestComponentsBase;

var	instanced NestingTest_SecondLevelSubobject		NestedSubobject;

var NestingTest_SecondLevelComponent				NestedComponent;

defaultproperties
{
   Begin Object Class=NestingTest_SecondLevelSubobject Name=Component_NestedSubobjectTemplate ObjName=Component_NestedSubobjectTemplate Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_SecondLevelSubobject'
      Name="Component_NestedSubobjectTemplate"
      ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_SecondLevelSubobject'
   End Object
   NestedSubobject=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelComponent:Component_NestedSubobjectTemplate'
   Begin Object Class=NestingTest_SecondLevelComponent Name=Component_NestedComponentTemplate ObjName=Component_NestedComponentTemplate Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_SecondLevelComponent'
      Name="Component_NestedComponentTemplate"
      ObjectArchetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_SecondLevelComponent'
   End Object
   NestedComponent=Component_NestedComponentTemplate
   Name="Default__NestingTest_FirstLevelComponent"
   ObjectArchetype=TestComponentsBase'UnrealScriptTest.Default__TestComponentsBase'
}
