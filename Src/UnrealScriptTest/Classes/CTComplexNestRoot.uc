/**
 * Used for testing and verifying actors which contain components that contain more than one layer of nesting; i.e. the component contains
 * a component or subobject, and the nested component or subobject contains any components.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class CTComplexNestRoot extends ComponentTestActorBase
	native;

struct native ComplexNestStruct
{
	var() instanced CTSimpleNestObject			ComplexNestStructObject;
	var() instanced array<CTSimpleNestObject>	ComplexNestStructObjectArray;
};

var()	instanced	CTSimpleNestObject		SimpleNestObject;

var()	instanced	ComplexNestStruct		SimpleNestObjectStruct;

defaultproperties
{
   Begin Object Class=CTSimpleNestObject Name=SimpleNestObjectTemplate ObjName=SimpleNestObjectTemplate Archetype=CTSimpleNestObject'UnrealScriptTest.Default__CTSimpleNestObject'
      Begin Object Class=CTSimpleNestChild Name=InnerComponentTemplate ObjName=InnerComponentTemplate Archetype=CTSimpleNestChild'UnrealScriptTest.Default__CTSimpleNestObject:InnerComponentTemplate'
         ObjectArchetype=CTSimpleNestChild'InnerComponentTemplate'
      End Object
      Name="SimpleNestObjectTemplate"
      ObjectArchetype=CTSimpleNestObject'UnrealScriptTest.Default__CTSimpleNestObject'
   End Object
   SimpleNestObject=CTSimpleNestObject'UnrealScriptTest.Default__CTComplexNestRoot:SimpleNestObjectTemplate'
   SimpleNestObjectStruct=(ComplexNestStructObject=CTSimpleNestObject'UnrealScriptTest.Default__CTComplexNestRoot:StructObjectTemplate',ComplexNestStructObjectArray=(CTSimpleNestObject'UnrealScriptTest.Default__CTComplexNestRoot:StructArrayObjectTemplateA',CTSimpleNestObject'UnrealScriptTest.Default__CTComplexNestRoot:StructArrayObjectTemplateB'))
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
      ObjectArchetype=SpriteComponent'UnrealScriptTest.Default__ComponentTestActorBase:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__CTComplexNestRoot"
   ObjectArchetype=ComponentTestActorBase'UnrealScriptTest.Default__ComponentTestActorBase'
}
