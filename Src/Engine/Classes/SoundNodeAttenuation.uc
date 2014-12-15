/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SoundNodeAttenuation extends SoundNode
	native(Sound)
	collapsecategories
	hidecategories(Object)
	editinlinenew;


enum SoundDistanceModel
{
	ATTENUATION_Linear,
	ATTENUATION_Logarithmic,
	ATTENUATION_Inverse,
	ATTENUATION_LogReverse,
	ATTENUATION_NaturalSound
};

var()					SoundDistanceModel		DistanceModel;

/**
 * This is the point at which to start attenuating.  Prior to this point the sound will be at full volume.
 **/
var()					rawdistributionfloat	MinRadius;
var()					rawdistributionfloat	MaxRadius;
var()					float					dBAttenuationAtMax;
/**
 * This is the point at which to start applying a low pass filter.  Prior to this point the sound will be dry.
 **/
var()					rawdistributionfloat	LPFMinRadius;
var()					rawdistributionfloat	LPFMaxRadius;

var()					bool					bSpatialize;
var()					bool					bAttenuate;
var()					bool					bAttenuateWithLowPassFilter;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   MinRadius=(Distribution=DistributionMinRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(400.000000,400.000000,400.000000,400.000000,400.000000,400.000000))
   MaxRadius=(Distribution=DistributionMaxRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(5000.000000,5000.000000,5000.000000,5000.000000,5000.000000,5000.000000))
   dBAttenuationAtMax=-60.000000
   LPFMinRadius=(Distribution=DistributionLPFMinRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1500.000000,1500.000000,1500.000000,1500.000000,1500.000000,1500.000000))
   LPFMaxRadius=(Distribution=DistributionLPFMaxRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(5000.000000,5000.000000,5000.000000,5000.000000,5000.000000,5000.000000))
   bSpatialize=True
   bAttenuate=True
   bAttenuateWithLowPassFilter=True
   Name="Default__SoundNodeAttenuation"
   ObjectArchetype=SoundNode'Engine.Default__SoundNode'
}
