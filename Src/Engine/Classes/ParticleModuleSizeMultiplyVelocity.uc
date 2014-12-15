/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleSizeMultiplyVelocity extends ParticleModuleSizeBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

var(Size)					rawdistributionvector	VelocityMultiplier;
var(Size)					bool					MultiplyX;
var(Size)					bool					MultiplyY;
var(Size)					bool					MultiplyZ;

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
   VelocityMultiplier=(Distribution=DistributionVelocityMultiplier,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   MultiplyX=True
   MultiplyY=True
   MultiplyZ=True
   bSpawnModule=True
   bUpdateModule=True
   Name="Default__ParticleModuleSizeMultiplyVelocity"
   ObjectArchetype=ParticleModuleSizeBase'Engine.Default__ParticleModuleSizeBase'
}
