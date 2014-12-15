/**
 * Actor used for testing changes to object instancing and verifying functionality.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved
 */
class SubobjectTestActor extends Actor
	placeable;

var() NestingTest_FirstLevelComponent Component;
var() instanced NestingTest_FirstLevelSubobject Subobject;

defaultproperties
{
   Begin Object Class=NestingTest_FirstLevelComponent Name=ComponentTemplate ObjName=ComponentTemplate Archetype=NestingTest_FirstLevelComponent'UnrealScriptTest.Default__NestingTest_FirstLevelComponent'
      Begin Object Class=NestingTest_SecondLevelSubobject Name=Component_NestedSubobjectTemplate ObjName=Component_NestedSubobjectTemplate Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelComponent:Component_NestedSubobjectTemplate'
         ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelComponent:Component_NestedSubobjectTemplate'
      End Object
      Begin Object Class=NestingTest_SecondLevelComponent Name=Component_NestedComponentTemplate ObjName=Component_NestedComponentTemplate Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_FirstLevelComponent:Component_NestedComponentTemplate'
         ObjectArchetype=NestingTest_SecondLevelComponent'Component_NestedComponentTemplate'
      End Object
      NestedSubobject=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__SubobjectTestActor:ComponentTemplate.Component_NestedSubobjectTemplate'
      Name="ComponentTemplate"
      ObjectArchetype=NestingTest_FirstLevelComponent'UnrealScriptTest.Default__NestingTest_FirstLevelComponent'
   End Object
   Component=ComponentTemplate
   Begin Object Class=NestingTest_FirstLevelSubobject Name=SubobjectTemplate ObjName=SubobjectTemplate Archetype=NestingTest_FirstLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject'
      Begin Object Class=NestingTest_SecondLevelSubobject Name=Subobject_NestedSubobjectTemplate ObjName=Subobject_NestedSubobjectTemplate Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
         ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
      End Object
      Begin Object Class=NestingTest_SecondLevelSubobject Name=Subobject_NestedSubobjectTemplate_0 ObjName=Subobject_NestedSubobjectTemplate_0 Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
         Name="Subobject_NestedSubobjectTemplate_0"
         ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
      End Object
      Begin Object Class=NestingTest_SecondLevelSubobject Name=Subobject_NestedSubobjectTemplate_1 ObjName=Subobject_NestedSubobjectTemplate_1 Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
         Name="Subobject_NestedSubobjectTemplate_1"
         ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
      End Object
      Begin Object Class=NestingTest_SecondLevelSubobject Name=Subobject_NestedSubobjectTemplate_2 ObjName=Subobject_NestedSubobjectTemplate_2 Archetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
         Name="Subobject_NestedSubobjectTemplate_2"
         ObjectArchetype=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedSubobjectTemplate'
      End Object
      Begin Object Class=NestingTest_SecondLevelComponent Name=Subobject_NestedComponentTemplate ObjName=Subobject_NestedComponentTemplate Archetype=NestingTest_SecondLevelComponent'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject:Subobject_NestedComponentTemplate'
         ObjectArchetype=NestingTest_SecondLevelComponent'Subobject_NestedComponentTemplate'
      End Object
      NestedSubobject=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__SubobjectTestActor:SubobjectTemplate.Subobject_NestedSubobjectTemplate'
      NestedStruct=(StructObject=NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__SubobjectTestActor:SubobjectTemplate.Subobject_NestedSubobjectTemplate_0',StructObjectArray=(NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__SubobjectTestActor:SubobjectTemplate.Subobject_NestedSubobjectTemplate_1',NestingTest_SecondLevelSubobject'UnrealScriptTest.Default__SubobjectTestActor:SubobjectTemplate.Subobject_NestedSubobjectTemplate_2'))
      Name="SubobjectTemplate"
      ObjectArchetype=NestingTest_FirstLevelSubobject'UnrealScriptTest.Default__NestingTest_FirstLevelSubobject'
   End Object
   Subobject=NestingTest_FirstLevelSubobject'UnrealScriptTest.Default__SubobjectTestActor:SubobjectTemplate'
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   CollisionType=COLLIDE_CustomDefault
   Name="Default__SubobjectTestActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
