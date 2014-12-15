/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_ActivateRemoteEvent extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Instigator to use in the event */
var() Actor Instigator;

/** Name of the event to activate */
var() Name EventName;

defaultproperties
{
   EventName="DefaultEvent"
   VariableLinks(0)=(LinkDesc="Instigator",PropertyName="Instigator")
   ObjClassVersion=2
   ObjName="Activate Remote Event"
   ObjCategory="Event"
   Name="Default__SeqAct_ActivateRemoteEvent"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
