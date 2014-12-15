class InterpTrackToggle extends InterpTrack
	native(Interpolation);

/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * 
 *	A track containing toggle actions that are triggered as its played back. 
 */

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
// (cpptext)
// (cpptext)

/** Enumeration indicating toggle action	*/
enum ETrackToggleAction
{
	ETTA_Off,
	ETTA_On,
	ETTA_Toggle
};

/** Information for one toggle in the track. */
struct native ToggleTrackKey
{
	var		float				Time;
	var()	ETrackToggleAction	ToggleAction;
};	

/** Array of events to fire off. */
var	array<ToggleTrackKey>	ToggleTrack;

/** If true, events on this track are fired even when jumping forwads through a sequence - for example, skipping a cinematic. */
var() bool	bFireEventsWhenJumpingForwards;

/** 
 *	If true, the track will call ActivateSystem on the emitter each update (the old 'incorrect' behavior).
 *	If false (the default), the System will only be activated if it was previously inactive.
 */
var() bool	bActivateSystemEachUpdate;

defaultproperties
{
   bFireEventsWhenJumpingForwards=True
   TrackInstClass=Class'Engine.InterpTrackInstToggle'
   TrackTitle="Toggle"
   Name="Default__InterpTrackToggle"
   ObjectArchetype=InterpTrack'Engine.Default__InterpTrack'
}
