/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


//-----------------------------------------------------------
//
//-----------------------------------------------------------
class InheritanceTestDerived extends InheritanceTestBase;

defaultproperties
{
   Begin Object Class=NestingTest_SecondLevelComponent Name=NestingTestComponent ObjName=NestingTestComponent Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__InheritanceTestBase:NestingTestComponent'
      ObjectArchetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__InheritanceTestBase:NestingTestComponent'
   End Object
   TestComponent=NestingTestComponent
   Name="Default__InheritanceTestDerived"
   ObjectArchetype=InheritanceTestBase'UnrealScriptTest.Default__InheritanceTestBase'
}
