/**
 * Activated when an receives the OnRigidBodyCollision notification from the physics system.
 * Originator: the actor that was just sitting there
 * Instigator: the actor that did the colliding
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqEvent_RigidBodyCollision extends SequenceEvent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Minimum impact speed (along contact normal) for this event to fire. */
var()	float	MinCollisionVelocity;

defaultproperties
{
   bPlayerOnly=False
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="ImpactVelocity",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Vector',LinkDesc="ImpactLocation",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Rigid Body Collision"
   ObjCategory="Physics"
   Name="Default__SeqEvent_RigidBodyCollision"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
