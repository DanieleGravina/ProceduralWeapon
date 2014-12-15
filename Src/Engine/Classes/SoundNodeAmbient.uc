/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SoundNodeAmbient extends SoundNode
	native(Sound)
	collapsecategories
	hidecategories(Object)
	dependson(SoundNodeAttenuation)
	editinlinenew;


var()								SoundDistanceModel		DistanceModel;

var()								rawdistributionfloat	MinRadius;
var()								rawdistributionfloat	MaxRadius;
var()								rawdistributionfloat	LPFMinRadius;
var()								rawdistributionfloat	LPFMaxRadius;

var()								bool					bSpatialize;
var()								bool					bAttenuate;
var()								bool					bAttenuateWithLowPassFilter;

var()								SoundNodeWave			Wave;

var()								rawdistributionfloat		VolumeModulation;
var()								rawdistributionfloat		PitchModulation;


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
   MinRadius=(Distribution=DistributionMinRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(400.000000,400.000000,400.000000,400.000000,400.000000,400.000000))
   MaxRadius=(Distribution=DistributionMaxRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(5000.000000,5000.000000,5000.000000,5000.000000,5000.000000,5000.000000))
   LPFMinRadius=(Distribution=DistributionLPFMinRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1500.000000,1500.000000,1500.000000,1500.000000,1500.000000,1500.000000))
   LPFMaxRadius=(Distribution=DistributionLPFMaxRadius,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(2500.000000,2500.000000,2500.000000,2500.000000,2500.000000,2500.000000))
   bSpatialize=True
   bAttenuate=True
   VolumeModulation=(Distribution=DistributionVolume,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   PitchModulation=(Distribution=DistributionPitch,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   Name="Default__SoundNodeAmbient"
   ObjectArchetype=SoundNode'Engine.Default__SoundNode'
}
