/**
 *	ParticleModuleLocationDirect
 *
 *	Sets the location of particles directly.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class ParticleModuleLocationDirect extends ParticleModuleLocationBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

/** */
var(Location) rawdistributionvector	Location;
var(Location) rawdistributionvector	LocationOffset;
var(Location) rawdistributionvector	ScaleFactor;
var(Location) rawdistributionvector	Direction;

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
   Location=(Distribution=DistributionLocation,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   LocationOffset=(Distribution=DistributionLocationOffset,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   ScaleFactor=(Distribution=DistributionScaleFactor,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   Direction=(Distribution=DistributionDirection,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   bSpawnModule=True
   bUpdateModule=True
   Name="Default__ParticleModuleLocationDirect"
   ObjectArchetype=ParticleModuleLocationBase'Engine.Default__ParticleModuleLocationBase'
}
