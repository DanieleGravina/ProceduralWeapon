/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class InterpTrackSkelControlScale extends InterpTrackFloatBase
	native(Interpolation);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Name of property in Group Actor which this track mill modify over time. */
var()	name	SkelControlName;

defaultproperties
{
   TrackInstClass=Class'Engine.InterpTrackInstSkelControlScale'
   TrackTitle="SkelControl Scale"
   bIsAnimControlTrack=True
   Name="Default__InterpTrackSkelControlScale"
   ObjectArchetype=InterpTrackFloatBase'Engine.Default__InterpTrackFloatBase'
}
