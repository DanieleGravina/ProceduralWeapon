/**
 * Non-component counterpart to NestingTest_SecondLevelComponent.
 * This component serves as a leaf in a nesting chain - it will be at least two layers deep from the subobject root.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class NestingTest_SecondLevelSubobject extends TestClassBase;

var()	color	TestColor;

defaultproperties
{
   Name="Default__NestingTest_SecondLevelSubobject"
   ObjectArchetype=TestClassBase'UnrealScriptTest.Default__TestClassBase'
}
