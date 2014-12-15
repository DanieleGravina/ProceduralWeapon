/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================================================================
// The Prismatic joint class.
//=============================================================================

class RB_PrismaticActor extends RB_ConstraintActor
    placeable;

defaultproperties
{
   Begin Object Class=RB_PrismaticSetup Name=MyPrismaticSetup ObjName=MyPrismaticSetup Archetype=RB_PrismaticSetup'Engine.Default__RB_PrismaticSetup'
      Name="MyPrismaticSetup"
      ObjectArchetype=RB_PrismaticSetup'Engine.Default__RB_PrismaticSetup'
   End Object
   ConstraintSetup=RB_PrismaticSetup'Engine.Default__RB_PrismaticActor:MyPrismaticSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyConstraintInstance ObjName=MyConstraintInstance Archetype=RB_ConstraintInstance'Engine.Default__RB_ConstraintActor:MyConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'Engine.Default__RB_ConstraintActor:MyConstraintInstance'
   End Object
   ConstraintInstance=RB_ConstraintInstance'Engine.Default__RB_PrismaticActor:MyConstraintInstance'
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__RB_ConstraintActor:Sprite'
      Sprite=Texture2D'EngineResources.S_KPrismatic'
      ObjectArchetype=SpriteComponent'Engine.Default__RB_ConstraintActor:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=RB_ConstraintDrawComponent Name=MyConDrawComponent ObjName=MyConDrawComponent Archetype=RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor:MyConDrawComponent'
      ObjectArchetype=RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor:MyConDrawComponent'
   End Object
   Components(1)=MyConDrawComponent
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=64,G=64,R=255,A=255)
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(2)=ArrowComponent0
   Name="Default__RB_PrismaticActor"
   ObjectArchetype=RB_ConstraintActor'Engine.Default__RB_ConstraintActor'
}
