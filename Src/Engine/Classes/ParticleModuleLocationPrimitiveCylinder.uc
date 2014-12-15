//=============================================================================
// ParticleModuleLocationPrimitiveCylinder
// Location primitive spawning within a cylinder.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class ParticleModuleLocationPrimitiveCylinder extends ParticleModuleLocationPrimitiveBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

var(Location) bool					RadialVelocity;
var(Location) rawdistributionfloat	StartRadius;
var(Location) rawdistributionfloat	StartHeight;

enum CylinderHeightAxis
{
	PMLPC_HEIGHTAXIS_X,
	PMLPC_HEIGHTAXIS_Y,
	PMLPC_HEIGHTAXIS_Z
};

var(Location)									CylinderHeightAxis	HeightAxis;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   RadialVelocity=True
   StartRadius=(Distribution=DistributionStartRadius,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.000000,50.000000,50.000000,50.000000))
   StartHeight=(Distribution=DistributionStartHeight,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(50.000000,50.000000,50.000000,50.000000))
   HeightAxis=PMLPC_HEIGHTAXIS_Z
   VelocityScale=(Distribution=DistributionVelocityScale)
   StartLocation=(Distribution=DistributionStartLocation)
   bSupported3DDrawMode=True
   Name="Default__ParticleModuleLocationPrimitiveCylinder"
   ObjectArchetype=ParticleModuleLocationPrimitiveBase'Engine.Default__ParticleModuleLocationPrimitiveBase'
}
