/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleAttractorPoint extends ParticleModuleAttractorBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

/**	The position of the point attractor from the source of the emitter.		*/
var(Attractor)				rawdistributionvector	Position;

/**	The radial range of the attractor.										*/
var(Attractor)				rawdistributionfloat	Range;

/**	The strength of the point attractor.									*/
var(Attractor)				rawdistributionfloat	Strength;

/**	The strength curve is a function of distance or of time.				*/
var(Attractor) bool									StrengthByDistance;

/**	If TRUE, the velocity adjustment will be applied to the base velocity.	*/
var(Attractor) bool									bAffectBaseVelocity;

/**	If TRUE, set the velocity.												*/
var(Attractor) bool									bOverrideVelocity;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Position=(Distribution=DistributionPosition,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   Range=(Distribution=DistributionRange,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.000000,0.000000,0.000000,0.000000))
   Strength=(Distribution=DistributionStrength,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.000000,0.000000,0.000000,0.000000))
   StrengthByDistance=True
   bUpdateModule=True
   bSupported3DDrawMode=True
   Name="Default__ParticleModuleAttractorPoint"
   ObjectArchetype=ParticleModuleAttractorBase'Engine.Default__ParticleModuleAttractorBase'
}
