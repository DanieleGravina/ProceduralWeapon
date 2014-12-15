class InterpTrackFloatParticleParam extends InterpTrackFloatBase
	native(Interpolation);

/**
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

/** Name of property in the Emitter which this track mill modify over time. */
var()	name		ParamName;

defaultproperties
{
   TrackInstClass=Class'Engine.InterpTrackInstFloatParticleParam'
   TrackTitle="Float Particle Param"
   Name="Default__InterpTrackFloatParticleParam"
   ObjectArchetype=InterpTrackFloatBase'Engine.Default__InterpTrackFloatBase'
}
