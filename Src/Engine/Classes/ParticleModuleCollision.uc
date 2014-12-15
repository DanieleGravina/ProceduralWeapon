/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleCollision extends ParticleModuleCollisionBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

var(Collision)					rawdistributionvector		DampingFactor;
var(Collision)					rawdistributionvector		DampingFactorRotation;
var(Collision)					rawdistributionfloat		MaxCollisions;
var(Collision)					EParticleCollisionComplete	CollisionCompletionOption;
var(Collision)					bool						bApplyPhysics;
var(Collision)					rawdistributionfloat		ParticleMass;

/**
 *	The directional scalar value.
 *	This is a value that is used to scale the bounds to 'assist' in avoiding interpentration
 *	or large gaps.
 */
var(Collision)					float						DirScalar;

/**
 *	If TRUE, then collisions with Pawns will still react, but the
 *	UsedMaxCollisions count will not be decremented.
 *	(ie., They don't 'count' as collisions)
 */
var(Collision)					bool						bPawnsDoNotDecrementCount;
/**
 *	If TRUE, then collisions that do not have a vertical hit normal will
 *	still react, but UsedMaxCollisions count will not be decremented.
 *	(ie., They don't 'count' as collisions)
 *	Useful for having particles come to rest on floors.
 */
var(Collision)					bool						bOnlyVerticalNormalsDecrementCount;
/**
 *	The fudge factor to use to determine vertical.
 *	True vertical will have a Hit.Normal.Z == 1.0
 *	This will allow for Z components in the range of
 *	[1.0-VerticalFudgeFactor..1.0]
 *	to count as vertical collisions.
 */
var(Collision)					float						VerticalFudgeFactor;

/**
 *	How long to delay before checking a particle for collisions.
 *	Value is retrieved using the EmitterTime.
 *	It is stored in the particle payload data.
 *	During update, the particle flag IgnoreCollisions will be set
 *	until the particle relative time has surpassed the DelayAmount.
 */
var(Collision)					rawdistributionfloat		DelayAmount;

/**
 *	If TRUE, when the WorldInfo.bDropDetail flag is set, the module will be ignored.
 */
var(Performance)				bool						bDropDetail;

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
   DampingFactor=(Distribution=DistributionDampingFactor,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   DampingFactorRotation=(Distribution=DistributionDampingFactorRotation,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   MaxCollisions=(Distribution=DistributionMaxCollisions,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   bDropDetail=True
   ParticleMass=(Distribution=DistributionParticleMass,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.100000,0.100000,0.100000,0.100000))
   DirScalar=3.500000
   VerticalFudgeFactor=0.100000
   DelayAmount=(Distribution=DistributionDelayAmount,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.000000,0.000000,0.000000,0.000000))
   bSpawnModule=True
   bUpdateModule=True
   Name="Default__ParticleModuleCollision"
   ObjectArchetype=ParticleModuleCollisionBase'Engine.Default__ParticleModuleCollisionBase'
}
