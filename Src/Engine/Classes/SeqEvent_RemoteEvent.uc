/**
 * Activated by the ActivateRemoteEvent action.
 * Originator: current WorldInfo
 * Instigator: the actor that is assigned [in editor] as the ActivateRemoteEvent action's Instigator
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqEvent_RemoteEvent extends SequenceEvent
	native(Sequence);

/** Name of this event for remote activation */
var() Name EventName;

defaultproperties
{
   EventName="DefaultEvent"
   bPlayerOnly=False
   ObjName="Remote Event"
   Name="Default__SeqEvent_RemoteEvent"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
