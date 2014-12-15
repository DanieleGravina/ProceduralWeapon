/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleMeshRotation extends ParticleModuleRotationBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

/** Initial rotation distribution, in ROTATIONS (1 = 360 degrees).						*/
var(Rotation)					rawdistributionvector	StartRotation;

/** Whether to apply the parents rotation as well										*/
var(Rotation)					bool					bInheritParent;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   StartRotation=(Distribution=DistributionStartRotation,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,360.000000,0.000000,0.000000,0.000000,360.000000,360.000000,360.000000,0.000000,0.000000,0.000000,360.000000,360.000000,360.000000))
   bSpawnModule=True
   Name="Default__ParticleModuleMeshRotation"
   ObjectArchetype=ParticleModuleRotationBase'Engine.Default__ParticleModuleRotationBase'
}
