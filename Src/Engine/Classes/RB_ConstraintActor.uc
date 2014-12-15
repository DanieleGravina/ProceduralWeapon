//=============================================================================
// The Basic constraint actor class.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================

class RB_ConstraintActor extends Actor
    abstract
	placeable
	native(Physics);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

// Actors joined effected by this constraint (could be NULL for 'World')
var() Actor												ConstraintActor1;
var() Actor												ConstraintActor2;

var() editinline export noclear RB_ConstraintSetup		ConstraintSetup;
var() editinline export noclear RB_ConstraintInstance	ConstraintInstance;

// Disable collision between actors joined by this constraint.
var() const bool						bDisableCollision;

var() bool								bUpdateActor1RefFrame;
var() bool								bUpdateActor2RefFrame;

// Used if joint is a pulley to define pivot locations using actors in the level.
var(Pulley) Actor					PulleyPivotActor1;
var(Pulley) Actor					PulleyPivotActor2;

native final function SetDisableCollision(bool NewDisableCollision);
native final function InitConstraint(Actor Actor1, Actor Actor2, optional name Actor1Bone, optional name Actor2Bone, optional float BreakThreshold);
native final function TermConstraint();

/**
 * When destroyed using Kismet, break the constraint.
 */
simulated function OnDestroy(SeqAct_Destroy Action)
{
	TermConstraint();
}

defaultproperties
{
   Begin Object Class=RB_ConstraintInstance Name=MyConstraintInstance ObjName=MyConstraintInstance Archetype=RB_ConstraintInstance'Engine.Default__RB_ConstraintInstance'
      Name="MyConstraintInstance"
      ObjectArchetype=RB_ConstraintInstance'Engine.Default__RB_ConstraintInstance'
   End Object
   ConstraintInstance=RB_ConstraintInstance'Engine.Default__RB_ConstraintActor:MyConstraintInstance'
   bUpdateActor1RefFrame=True
   bUpdateActor2RefFrame=True
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   Begin Object Class=RB_ConstraintDrawComponent Name=MyConDrawComponent ObjName=MyConDrawComponent Archetype=RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintDrawComponent'
      Name="MyConDrawComponent"
      ObjectArchetype=RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintDrawComponent'
   End Object
   Components(1)=MyConDrawComponent
   Physics=PHYS_RigidBody
   TickGroup=TG_PostAsyncWork
   bHidden=True
   bNoDelete=True
   bEdShouldSnap=True
   DrawScale=0.500000
   CollisionType=COLLIDE_CustomDefault
   SupportedEvents(3)=Class'Engine.SeqEvent_ConstraintBroken'
   Name="Default__RB_ConstraintActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
