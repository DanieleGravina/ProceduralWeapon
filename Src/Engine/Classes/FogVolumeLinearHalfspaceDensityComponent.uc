/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeLinearHalfspaceDensityComponent extends FogVolumeDensityComponent
	native(FogVolume)
	collapsecategories
	hidecategories(Object)
	editinlinenew;

/** The linear distance based density coefficient */
var()	const	interp	float	PlaneDistanceFactor;

/** The plane that defines the fogged halfspace.  The normal of this plane faces away from the fogged halfspace. */
var		const	interp	plane	HalfspacePlane;

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

defaultproperties
{
   PlaneDistanceFactor=0.100000
   HalfspacePlane=(W=-300.000000,X=0.000000,Y=0.000000,Z=1.000000)
   Name="Default__FogVolumeLinearHalfspaceDensityComponent"
   ObjectArchetype=FogVolumeDensityComponent'Engine.Default__FogVolumeDensityComponent'
}
