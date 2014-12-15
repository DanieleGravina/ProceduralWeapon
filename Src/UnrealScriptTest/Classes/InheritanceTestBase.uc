/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


//-----------------------------------------------------------
//
//-----------------------------------------------------------
class InheritanceTestBase extends TestComponentsBase
	editinlinenew;

var() editconst	int									TestInt;
var() editconst	editinline NestingTest_SecondLevelComponent	TestComponent;

defaultproperties
{
   TestInt=2
   Begin Object Class=NestingTest_SecondLevelComponent Name=NestingTestComponent ObjName=NestingTestComponent Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_SecondLevelComponent'
      TestFloat=5.000000
      Name="NestingTestComponent"
      ObjectArchetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_SecondLevelComponent'
   End Object
   TestComponent=NestingTestComponent
   Name="Default__InheritanceTestBase"
   ObjectArchetype=TestComponentsBase'UnrealScriptTest.Default__TestComponentsBase'
}
