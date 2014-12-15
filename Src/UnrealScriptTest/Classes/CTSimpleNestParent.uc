/**
 * This class is used for testing and verifying the behavior of component instancing for actors which contain one layer of nested components.
 * This component contains a component property, and is assigned to the value of a component property in ComponentTestActor_SimpleNesting.
 * The component assigned to this component's component property does not have any components of its own.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class CTSimpleNestParent extends TestComponentsBase
	native;

var()	CTSimpleNestChild UnmodifiedChild_Defined_SingleRef;
var()	CTSimpleNestChild UnmodifiedChild_Defined_MultipleRef;
var()	CTSimpleNestChild ModifiedChild_Defined_SingleRef;
var()	CTSimpleNestChild ModifiedChild_Defined_MultipleRef;

var()	CTSimpleNestChild UnmodifiedChild_NotDefined_SingleRef;
var()	CTSimpleNestChild UnmodifiedChild_NotDefined_MultipleRef;
var()	CTSimpleNestChild ModifiedChild_NotDefined_SingleRef;
var()	CTSimpleNestChild ModifiedChild_NotDefined_MultipleRef;

var()	array<CTSimpleNestChild> UnmodifiedChild_Defined_Array;
var()	array<CTSimpleNestChild> ModifiedChild_Defined_Array;
var()	array<CTSimpleNestChild> UnmodifiedChild_Undefined_Array;
var()	array<CTSimpleNestChild> ModifiedChild_Undefined_Array;

defaultproperties
{
   Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_SingleRefTemplate ObjName=UnmodifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="UnmodifiedChild_Defined_SingleRefTemplate"
      ObjectArchetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
   End Object
   UnmodifiedChild_Defined_SingleRef=UnmodifiedChild_Defined_SingleRefTemplate
   Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_MultipleRefTemplate ObjName=UnmodifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="UnmodifiedChild_Defined_MultipleRefTemplate"
      ObjectArchetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
   End Object
   UnmodifiedChild_Defined_MultipleRef=UnmodifiedChild_Defined_MultipleRefTemplate
   Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_SingleRefTemplate ObjName=ModifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="ModifiedChild_Defined_SingleRefTemplate"
      ObjectArchetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
   End Object
   ModifiedChild_Defined_SingleRef=ModifiedChild_Defined_SingleRefTemplate
   Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_MultipleRefTemplate ObjName=ModifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="ModifiedChild_Defined_MultipleRefTemplate"
      ObjectArchetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestChild'
   End Object
   ModifiedChild_Defined_MultipleRef=ModifiedChild_Defined_MultipleRefTemplate
   UnmodifiedChild_Defined_Array(0)=UnmodifiedChild_Defined_MultipleRefTemplate
   ModifiedChild_Defined_Array(0)=ModifiedChild_Defined_MultipleRefTemplate
   Name="Default__CTSimpleNestParent"
   ObjectArchetype=TestComponentsBase'UnrealScriptTest.Default__TestComponentsBase'
}
