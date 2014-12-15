//=============================================================================
// ParticleModuleLocationPrimitiveSphere
// Location primitive spawning within a Sphere.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class ParticleModuleLocationPrimitiveSphere extends ParticleModuleLocationPrimitiveBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

var(Location) rawdistributionfloat	StartRadius;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   StartRadius=(Distribution=DistributionStartRadius,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.000000,50.000000,50.000000,50.000000))
   VelocityScale=(Distribution=DistributionVelocityScale)
   StartLocation=(Distribution=DistributionStartLocation)
   bSupported3DDrawMode=True
   Name="Default__ParticleModuleLocationPrimitiveSphere"
   ObjectArchetype=ParticleModuleLocationPrimitiveBase'Engine.Default__ParticleModuleLocationPrimitiveBase'
}
