/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class InterpTrackVectorProp extends InterpTrackVectorBase
	native(Interpolation);

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

/** Name of property in Group Actor which this track mill modify over time. */
var()	editconst	name		PropertyName;

defaultproperties
{
   TrackInstClass=Class'Engine.InterpTrackInstVectorProp'
   TrackTitle="Vector Property"
   Name="Default__InterpTrackVectorProp"
   ObjectArchetype=InterpTrackVectorBase'Engine.Default__InterpTrackVectorBase'
}
