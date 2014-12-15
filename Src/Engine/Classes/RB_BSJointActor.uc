//=============================================================================
// The Ball-and-Socket joint class.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class RB_BSJointActor extends RB_ConstraintActor
    placeable;

defaultproperties
{
   Begin Object Class=RB_BSJointSetup Name=MyBSJointSetup ObjName=MyBSJointSetup Archetype=RB_BSJointSetup'Engine.Default__RB_BSJointSetup'
      Name="MyBSJointSetup"
      ObjectArchetype=RB_BSJointSetup'Engine.Default__RB_BSJointSetup'
   End Object
   ConstraintSetup=RB_BSJointSetup'Engine.Default__RB_BSJointActor:MyBSJointSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyConstraintInstance ObjName=MyConstraintInstance Archetype=RB_ConstraintInstance'Engine.Default__RB_ConstraintActor:MyConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'Engine.Default__RB_ConstraintActor:MyConstraintInstance'
   End Object
   ConstraintInstance=RB_ConstraintInstance'Engine.Default__RB_BSJointActor:MyConstraintInstance'
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__RB_ConstraintActor:Sprite'
      Sprite=Texture2D'EngineResources.S_KBSJoint'
      ObjectArchetype=SpriteComponent'Engine.Default__RB_ConstraintActor:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=RB_ConstraintDrawComponent Name=MyConDrawComponent ObjName=MyConDrawComponent Archetype=RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor:MyConDrawComponent'
      ObjectArchetype=RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor:MyConDrawComponent'
   End Object
   Components(1)=MyConDrawComponent
   Name="Default__RB_BSJointActor"
   ObjectArchetype=RB_ConstraintActor'Engine.Default__RB_ConstraintActor'
}
