/**
 * Used for testing and verifying actors which contain components that contain one layer of nesting; i.e. the component contains
 * a component or subobject, but the nested component or subobject does not contain any components.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class CTSimpleNestRoot extends ComponentTestActorBase
	native;

var()	CTSimpleNestParent	UnmodifiedNestParent_SingleRef;
var()	CTSimpleNestParent	ModifiedNestParent_SingleRef;

var()	CTSimpleNestParent	UnmodifiedNestParent_MultipleRef;
var()	CTSimpleNestParent	ModifiedNestParent_MultipleRef;

var()	array<CTSimpleNestParent>	UnmodifiedNestParent_Array;
var()	array<CTSimpleNestParent>	ModifiedNestParent_Array;

defaultproperties
{
   Begin Object Class=CTSimpleNestParent Name=UnmodifiedNestParent_SingleRefTemplate ObjName=UnmodifiedNestParent_SingleRefTemplate Archetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_SingleRefTemplate ObjName=UnmodifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_MultipleRefTemplate ObjName=UnmodifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_MultipleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_SingleRefTemplate ObjName=ModifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_MultipleRefTemplate ObjName=ModifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_MultipleRefTemplate'
      End Object
      UnmodifiedChild_NotDefined_SingleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:UnmodifiedChild_NotDefined_SingleRefTemplate'
      UnmodifiedChild_NotDefined_MultipleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:UnmodifiedChild_NotDefined_MultipleRefTemplate'
      UnmodifiedChild_Undefined_Array(0)=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:UnmodifiedChild_NotDefined_MultipleRefTemplate'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="UnmodifiedNestParent_SingleRefTemplate"
      ObjectArchetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
   End Object
   UnmodifiedNestParent_SingleRef=UnmodifiedNestParent_SingleRefTemplate
   Begin Object Class=CTSimpleNestParent Name=ModifiedNestParent_SingleRefTemplate ObjName=ModifiedNestParent_SingleRefTemplate Archetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_SingleRefTemplate ObjName=UnmodifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_MultipleRefTemplate ObjName=UnmodifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_MultipleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_SingleRefTemplate ObjName=ModifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_MultipleRefTemplate ObjName=ModifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_MultipleRefTemplate'
      End Object
      ModifiedChild_NotDefined_SingleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:ModifiedChild_NotDefined_SingleRefTemplate'
      ModifiedChild_NotDefined_MultipleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:ModifiedChild_NotDefined_MultipleRefTemplate'
      ModifiedChild_Undefined_Array(0)=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:ModifiedChild_NotDefined_MultipleRefTemplate'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="ModifiedNestParent_SingleRefTemplate"
      ObjectArchetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
   End Object
   ModifiedNestParent_SingleRef=ModifiedNestParent_SingleRefTemplate
   Begin Object Class=CTSimpleNestParent Name=UnmodifiedNestParent_MultipleRefTemplate ObjName=UnmodifiedNestParent_MultipleRefTemplate Archetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_SingleRefTemplate ObjName=UnmodifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_MultipleRefTemplate ObjName=UnmodifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_MultipleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_SingleRefTemplate ObjName=ModifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_MultipleRefTemplate ObjName=ModifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_MultipleRefTemplate'
      End Object
      UnmodifiedChild_NotDefined_SingleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:UnmodifiedChild_NotDefined_SingleRefTemplate'
      UnmodifiedChild_NotDefined_MultipleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:UnmodifiedChild_NotDefined_MultipleRefTemplate'
      UnmodifiedChild_Undefined_Array(0)=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:UnmodifiedChild_NotDefined_MultipleRefTemplate'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="UnmodifiedNestParent_MultipleRefTemplate"
      ObjectArchetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
   End Object
   UnmodifiedNestParent_MultipleRef=UnmodifiedNestParent_MultipleRefTemplate
   Begin Object Class=CTSimpleNestParent Name=ModifiedNestParent_MultipleRefTemplate ObjName=ModifiedNestParent_MultipleRefTemplate Archetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_SingleRefTemplate ObjName=UnmodifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=UnmodifiedChild_Defined_MultipleRefTemplate ObjName=UnmodifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:UnmodifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'UnmodifiedChild_Defined_MultipleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_SingleRefTemplate ObjName=ModifiedChild_Defined_SingleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_SingleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_SingleRefTemplate'
      End Object
      Begin Object Class=CTSimpleNestChild Name=ModifiedChild_Defined_MultipleRefTemplate ObjName=ModifiedChild_Defined_MultipleRefTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestParent:ModifiedChild_Defined_MultipleRefTemplate'
         ObjectArchetype=CTSimpleNestChild'ModifiedChild_Defined_MultipleRefTemplate'
      End Object
      ModifiedChild_NotDefined_SingleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:ModifiedChild_NotDefined_SingleRefTemplate'
      ModifiedChild_NotDefined_MultipleRef=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:ModifiedChild_NotDefined_MultipleRefTemplate'
      ModifiedChild_Undefined_Array(0)=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestRoot:ModifiedChild_NotDefined_MultipleRefTemplate'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="ModifiedNestParent_MultipleRefTemplate"
      ObjectArchetype=CTSimpleNestParent'UnrealScriptTest.Default__CTSimpleNestParent'
   End Object
   ModifiedNestParent_MultipleRef=ModifiedNestParent_MultipleRefTemplate
   UnmodifiedNestParent_Array(0)=UnmodifiedNestParent_MultipleRefTemplate
   ModifiedNestParent_Array(0)=ModifiedNestParent_MultipleRefTemplate
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
      ObjectArchetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__CTSimpleNestRoot"
   ObjectArchetype=ComponentTestActorBase'UnrealScriptTest.Default__ComponentTestActorBase'
}
