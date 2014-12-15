/**
 *	ParticleModuleBeamSource
 *
 *	This module implements a single source for a beam emitter.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class ParticleModuleBeamSource extends ParticleModuleBeamBase
	native(Particle)
	editinlinenew
	dontcollapsecategories
	hidecategories(Object);

/** The method flag																			*/
var(Source)									Beam2SourceTargetMethod			SourceMethod;

/** The strength of the tangent from the source point for each beam							*/
var(Source)									name							SourceName;

/** Whether to treat the as an absolute position in world space.							*/
var(Source)									bool							bSourceAbsolute;

/** Default source-point to use																*/
var(Source)									rawdistributionvector			Source;

/** Whether to lock the source to the life of the particle									*/
var(Source)									bool							bLockSource;

/** The method to use for the source tangent.												*/
var(Source)									Beam2SourceTargetTangentMethod	SourceTangentMethod;

/** The tangent for the source point for each beam											*/
var(Source)									rawdistributionvector			SourceTangent;

/** Whether to lock the source to the life of the particle									*/
var(Source)									bool							bLockSourceTangent;

/** The strength of the tangent from the source point for each beam							*/
var(Source)									rawdistributionfloat			SourceStrength;

/** Whether to lock the source to the life of the particle									*/
var(Source)									bool							bLockSourceStength;

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
   Source=(Distribution=DistributionSource,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(50.000000,50.000000,50.000000,50.000000,50.000000,50.000000,50.000000,50.000000))
   SourceTangent=(Distribution=DistributionSourceTangent,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,1.000000,1.000000,0.000000,0.000000,1.000000,0.000000,0.000000))
   SourceStrength=(Distribution=DistributionSourceStrength,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(25.000000,25.000000,25.000000,25.000000))
   Name="Default__ParticleModuleBeamSource"
   ObjectArchetype=ParticleModuleBeamBase'Engine.Default__ParticleModuleBeamBase'
}
