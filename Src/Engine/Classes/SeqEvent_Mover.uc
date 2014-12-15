/** event that encapsulates basic mover functionality such as activating when a player gets on/off, automatically reversing direction after
 *	a delay, and handling hitting other actors in transit
 *	the Originator of this event should be the mover (InterpActor or subclass), which notifies us when things we might care about happen
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqEvent_Mover extends SequenceEvent
	native(Sequence)
	hidecategories(SequenceEvent);

/** how long the mover should stay open before automatically closing (reverse playback)
 * values <= 0.0 turn off this auto behavior and allow manual control (via the "Completed" and "Aborted" output links for the attached matinee action)
 */
var() float StayOpenTime;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event RegisterEvent()
{
	local InterpActor Mover;

	// tell the mover how long to stay after interpolation before calling NotifyFinishedOpen()
	Mover = InterpActor(Originator);
	if (Mover != None)
	{
		Mover.StayOpenTime = StayOpenTime;
	}
}

/** notification that our linked Mover has encroached on the given Actor */
function NotifyEncroachingOn(Actor Hit)
{
	local SeqVar_Object ObjVar;
	local array<int> ActivateIndices;

	ActivateIndices[0] = 3;
	// specify true for bPushTop as it's important that it gets executed before the matinee action that caused the movement
	// as that matinee may get its direction reversed or otherwise modified
	if (CheckActivate(Originator, Instigator, false, ActivateIndices, true))
	{
		// set the "Actor Hit" output variable to the actor we hit
		foreach LinkedVariables(class'SeqVar_Object', ObjVar, "Actor Hit")
		{
			ObjVar.SetObjectValue(Hit);
		}
	}
}

/** notification that an Actor has attached itself to the mover */
function NotifyAttached(Actor Other)
{
	local array<int> ActivateIndices;

	// if a pawn got on the mover, and it isn't already moving, then activate
	if (Pawn(Other) != None && IsZero(Originator.Velocity))
	{
		ActivateIndices[0] = 0;
		CheckActivate(Originator, Other, false, ActivateIndices);
	}
}

/** notification that an Actor has been detached from the mover */
function NotifyDetached(Actor Other)
{
	local Pawn P;
	local array<int> ActivateIndices;

	// should always be true, but iterators tend to crash when accessing None so be sure
	if (Originator == None)
	{
		WarnInternal("Originator mover missing");
	}
	else if (Pawn(Other) != None)
	{
		// activate the "detached" output if there are no more pawns touching the mover
		foreach Originator.BasedActors(class'Pawn', P)
		{
			return;
		}
		ActivateIndices[0] = 1;
		CheckActivate(Originator, Instigator, false, ActivateIndices);
	}
}

/** notification that the mover has completed all opening actions and is now ready to close */
function NotifyFinishedOpen()
{
	local array<int> ActivateIndices;

	// activate the "open finished" link
	ActivateIndices[0] = 2;
	CheckActivate(Originator, Instigator, false, ActivateIndices);
}

defaultproperties
{
   StayOpenTime=1.500000
   MaxTriggerCount=0
   bPlayerOnly=False
   OutputLinks(0)=(LinkDesc="Pawn Attached")
   OutputLinks(1)=(LinkDesc="Pawn Detached")
   OutputLinks(2)=(LinkDesc="Open Finished")
   OutputLinks(3)=(LinkDesc="Hit Actor")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Actor Hit",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Mover"
   ObjCategory="Physics"
   Name="Default__SeqEvent_Mover"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
