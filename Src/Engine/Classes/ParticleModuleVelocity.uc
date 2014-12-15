/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleVelocity extends ParticleModuleVelocityBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

var(Velocity) rawdistributionvector	StartVelocity;
var(Velocity) rawdistributionfloat	StartVelocityRadial;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   StartVelocity=(Distribution=DistributionStartVelocity,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   StartVelocityRadial=(Distribution=DistributionStartVelocityRadial,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   bSpawnModule=True
   Name="Default__ParticleModuleVelocity"
   ObjectArchetype=ParticleModuleVelocityBase'Engine.Default__ParticleModuleVelocityBase'
}
