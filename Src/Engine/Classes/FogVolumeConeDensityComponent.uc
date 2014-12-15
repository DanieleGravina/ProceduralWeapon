/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeConeDensityComponent extends FogVolumeDensityComponent
	native(FogVolume)
	collapsecategories
	hidecategories(Object)
	editinlinenew;

/** This is the density at the center of the cone, which will be the maximum. */
var()	const	interp	float	MaxDensity;

/** The cone's vertex in world space. */
var()	const	interp	vector	ConeVertex;

/** The cone's radius. */
var()	const	interp	float	ConeRadius;

/** Direction of the cone */
var()	const	interp	vector	ConeAxis;

/** Angle from the axis that limits the cone's volume */
var()	const	interp	float	ConeMaxAngle;

/** A preview component for visualizing the cone in the editor. */
var const DrawLightConeComponent PreviewCone;

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
   ConeRadius=600.000000
   ConeAxis=(X=0.000000,Y=0.000000,Z=-1.000000)
   ConeMaxAngle=30.000000
   Name="Default__FogVolumeConeDensityComponent"
   ObjectArchetype=FogVolumeDensityComponent'Engine.Default__FogVolumeDensityComponent'
}
