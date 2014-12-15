/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTActorFactoryMover extends ActorFactoryDynamicSM
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

/** if true, also create a Kismet event and hook it up to the spawned actor */
var() bool bCreateKismetEvent;
/** the class of Kismet event to create if bCreateKismetEvent is true */
var class<SequenceEvent> EventClass;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bCreateKismetEvent=True
   EventClass=Class'Engine.SeqEvent_Mover'
   MenuName="Add Mover"
   NewActorClass=Class'Engine.InterpActor'
   Name="Default__UTActorFactoryMover"
   ObjectArchetype=ActorFactoryDynamicSM'Engine.Default__ActorFactoryDynamicSM'
}
