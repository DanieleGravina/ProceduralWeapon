/**
 * Activated when a "usable" actor (such as a trigger) is used.
 * Originator: the usable actor that was used
 * Instigator: The pawn associated with the player did the using
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqEvent_Used extends SequenceEvent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** if true, requires player to aim at trigger to be able to interact with it. False, simple radius check will be performed */
var() bool	bAimToInteract;

/** Max distance from instigator to allow interactions. */
var() float InteractDistance;

/** Text to display when looking at this event */
var() string InteractText;

/** Icon to display when looking at this event */
var() Texture2D InteractIcon;

defaultproperties
{
   bAimToInteract=True
   InteractDistance=128.000000
   InteractText="Use"
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Distance",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Used"
   Name="Default__SeqEvent_Used"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
