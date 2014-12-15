/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleColor extends ParticleModuleColorBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

/** Initial color for a particle as a function of Emitter time. Range is 0-255 for X/Y/Z, corresponding to R/G/B. */
var(Color) rawdistributionvector	StartColor;
var(Color) rawdistributionfloat		StartAlpha;
var(Color) bool						bClampAlpha;

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

defaultproperties
{
   StartColor=(Distribution=DistributionStartColor,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   StartAlpha=(Distribution=DistributionStartAlpha,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.000000,1.000000,1.000000,1.000000))
   bClampAlpha=True
   bSpawnModule=True
   bCurvesAsColor=True
   Name="Default__ParticleModuleColor"
   ObjectArchetype=ParticleModuleColorBase'Engine.Default__ParticleModuleColorBase'
}
