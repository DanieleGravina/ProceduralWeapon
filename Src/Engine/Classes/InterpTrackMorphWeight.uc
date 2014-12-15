/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class InterpTrackMorphWeight extends InterpTrackFloatBase
	native(Interpolation);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Name of property in Group Actor which this track mill modify over time. */
var()	name	MorphNodeName;

defaultproperties
{
   TrackInstClass=Class'Engine.InterpTrackInstMorphWeight'
   TrackTitle="Morph Weight"
   bIsAnimControlTrack=True
   Name="Default__InterpTrackMorphWeight"
   ObjectArchetype=InterpTrackFloatBase'Engine.Default__InterpTrackFloatBase'
}
