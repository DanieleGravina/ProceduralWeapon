//=============================================================================
// ParticleModuleLocationPrimitiveBase
// Base class for setting particle spawn locations based on primitives.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class ParticleModuleLocationPrimitiveBase extends ParticleModuleLocationBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

var(Location) bool					Positive_X;
var(Location) bool					Positive_Y;
var(Location) bool					Positive_Z;
var(Location) bool					Negative_X;
var(Location) bool					Negative_Y;
var(Location) bool					Negative_Z;
var(Location) bool					SurfaceOnly;
var(Location) bool					Velocity;
var(Location) rawdistributionfloat	VelocityScale;
var(Location) rawdistributionvector	StartLocation;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Positive_X=True
   Positive_Y=True
   Positive_Z=True
   Negative_X=True
   Negative_Y=True
   Negative_Z=True
   VelocityScale=(Distribution=DistributionVelocityScale,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.000000,1.000000,1.000000,1.000000))
   StartLocation=(Distribution=DistributionStartLocation,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   bSpawnModule=True
   Name="Default__ParticleModuleLocationPrimitiveBase"
   ObjectArchetype=ParticleModuleLocationBase'Engine.Default__ParticleModuleLocationBase'
}
