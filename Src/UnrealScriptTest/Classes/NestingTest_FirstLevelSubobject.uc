/**
 * Non-component counterpart for NestingTest_FirstLevelComponent
 * This object contains its own instanced subobjects and components.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class NestingTest_FirstLevelSubobject extends TestClassBase;

struct NestedObjectStruct
{
	var() instanced NestingTest_SecondLevelSubobject StructObject;
	var() instanced array<NestingTest_SecondLevelSubobject> StructObjectArray;
};

var()	instanced NestingTest_SecondLevelSubobject		NestedSubobject;

var() NestingTest_SecondLevelComponent				NestedComponent;

var()	NestedObjectStruct							NestedStruct;

defaultproperties
{
   Begin Object Class=NestingTest_SecondLevelSubobject Name=Subobject_NestedSubobjectTemplate ObjName=Subobject_NestedSubobjectTemplate Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_SecondLevelSubobject'
      Name="Subobject_NestedSubobjectTemplate"
      ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_SecondLevelSubobject'
   End Object
   NestedSubobject=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
   Begin Object Class=NestingTest_SecondLevelComponent Name=Subobject_NestedComponentTemplate ObjName=Subobject_NestedComponentTemplate Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_SecondLevelComponent'
      Name="Subobject_NestedComponentTemplate"
      ObjectArchetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_SecondLevelComponent'
   End Object
   NestedComponent=Subobject_NestedComponentTemplate
   NestedStruct=(StructObject=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate',StructObjectArray=(NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate',NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'))
   Name="Default__NestingTest_FirstLevelSubobject"
   ObjectArchetype=TestClassBase'UnrealScriptTest.Default__TestClassBase'
}
