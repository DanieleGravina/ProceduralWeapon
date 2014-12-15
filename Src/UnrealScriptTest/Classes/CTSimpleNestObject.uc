/**
 * Used for testing and verifying actors which contain instanced subobjects which contain components that do not themselves contain components.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class CTSimpleNestObject extends TestClassBase
	native;

var()	CTSimpleNestChild		InnerComponent;

defaultproperties
{
   Begin Object Class=CTSimpleNestChild Name=InnerComponentTemplate ObjName=InnerComponentTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="InnerComponentTemplate"
      ObjectArchetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
   End Object
   InnerComponent=InnerComponentTemplate
   Name="Default__CTSimpleNestObject"
   ObjectArchetype=TestClassBase'UnrealScriptTest.Default__TestClassBase'
}
