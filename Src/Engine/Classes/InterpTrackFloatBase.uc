class InterpTrackFloatBase extends InterpTrack
	native(Interpolation)
	abstract;

/** 
 * InterpTrackFloatBase
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Actually track data containing keyframes of float as it varies over time. */
var		InterpCurveFloat	FloatTrack;

/** Tension of curve, used for keypoints using automatic tangents. */
var()	float				CurveTension;

defaultproperties
{
   TrackTitle="Generic Float Track"
   Name="Default__InterpTrackFloatBase"
   ObjectArchetype=InterpTrack'Engine.Default__InterpTrack'
}
