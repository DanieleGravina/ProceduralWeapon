/**
 * Used for testing and verifying actors which contain components that do not themselves contain components or subobjects.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class CTNoNestRoot extends ComponentTestActorBase
	native;

var()		CTNoNesting			UnmodifiedComponent_SingleRef;
var()		CTNoNesting			ModifiedComponent_SingleRef;

var()		CTNoNesting			UnmodifiedComponent_MultipleRef;
var()		CTNoNesting			ModifiedComponent_MultipleRef;

var()		array<CTNoNesting>	UnmodifiedComponent_Array;
var()		array<CTNoNesting>	ModifiedComponent_Array;

defaultproperties
{
   Begin Object Class=CTNoNesting Name=UnmodifiedComponent_SingleRefTemplate ObjName=UnmodifiedComponent_SingleRefTemplate Archetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="UnmodifiedComponent_SingleRefTemplate"
      ObjectArchetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
   End Object
   UnmodifiedComponent_SingleRef=UnmodifiedComponent_SingleRefTemplate
   Begin Object Class=CTNoNesting Name=ModifiedComponent_SingleRefTemplate ObjName=ModifiedComponent_SingleRefTemplate Archetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="ModifiedComponent_SingleRefTemplate"
      ObjectArchetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
   End Object
   ModifiedComponent_SingleRef=ModifiedComponent_SingleRefTemplate
   Begin Object Class=CTNoNesting Name=UnmodifiedComponent_MultipleRefTemplate ObjName=UnmodifiedComponent_MultipleRefTemplate Archetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="UnmodifiedComponent_MultipleRefTemplate"
      ObjectArchetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
   End Object
   UnmodifiedComponent_MultipleRef=UnmodifiedComponent_MultipleRefTemplate
   Begin Object Class=CTNoNesting Name=ModifiedComponent_MultipleRefTemplate ObjName=ModifiedComponent_MultipleRefTemplate Archetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
      UnmodifiedInt=20
      ModifiedFloat=20.000000
      Name="ModifiedComponent_MultipleRefTemplate"
      ObjectArchetype=CTNoNesting'UnrealScriptTest.Default__CTNoNesting'
   End Object
   ModifiedComponent_MultipleRef=ModifiedComponent_MultipleRefTemplate
   UnmodifiedComponent_Array(0)=UnmodifiedComponent_MultipleRefTemplate
   ModifiedComponent_Array(0)=ModifiedComponent_MultipleRefTemplate
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
      ObjectArchetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__CTNoNestRoot"
   ObjectArchetype=ComponentTestActorBase'UnrealScriptTest.Default__ComponentTestActorBase'
}
