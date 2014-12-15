/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class InterpTrackInstVectorProp extends InterpTrackInstProperty
	native(Interpolation);


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Pointer to vector property in TrackObject. */
var	pointer		VectorProp; 

/** Saved value for restoring state when exiting Matinee. */
var	vector		ResetVector;

defaultproperties
{
   Name="Default__InterpTrackInstVectorProp"
   ObjectArchetype=InterpTrackInstProperty'Engine.Default__InterpTrackInstProperty'
}
