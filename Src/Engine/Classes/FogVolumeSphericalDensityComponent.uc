/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeSphericalDensityComponent extends FogVolumeDensityComponent
	native(FogVolume)
	collapsecategories
	hidecategories(Object)
	editinlinenew;

/** This is the density at the center of the sphere, which will be the maximum. */
var()	const	interp	float	MaxDensity;

/** The sphere's center in world space. */
var()	const	interp	vector	SphereCenter;

/** The sphere's radius. */
var()	const	interp	float	SphereRadius;

/** A preview component for visualizing the sphere in the editor. */
var const DrawLightRadiusComponent PreviewSphereRadius;

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

defaultproperties
{
   MaxDensity=0.002000
   SphereRadius=600.000000
   Name="Default__FogVolumeSphericalDensityComponent"
   ObjectArchetype=FogVolumeDensityComponent'Engine.Default__FogVolumeDensityComponent'
}
