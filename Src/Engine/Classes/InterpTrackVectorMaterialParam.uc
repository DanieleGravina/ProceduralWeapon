class InterpTrackVectorMaterialParam extends InterpTrackVectorBase
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

/** Name of parameter in the MaterialInstnace which this track mill modify over time. */
var()	name		ParamName;

defaultproperties
{
   TrackInstClass=Class'Engine.InterpTrackInstVectorMaterialParam'
   TrackTitle="Vector Material Param"
   Name="Default__InterpTrackVectorMaterialParam"
   ObjectArchetype=InterpTrackVectorBase'Engine.Default__InterpTrackVectorBase'
}
