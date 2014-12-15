/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SoundNodeModulator extends SoundNode
	native(Sound)
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var()	rawdistributionfloat	VolumeModulation;
var()	rawdistributionfloat	PitchModulation;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   VolumeModulation=(Distribution=DistributionVolume,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.900000,1.100000,0.900000,1.100000,0.900000,1.100000))
   PitchModulation=(Distribution=DistributionPitch,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.900000,1.100000,0.900000,1.100000,0.900000,1.100000))
   Name="Default__SoundNodeModulator"
   ObjectArchetype=SoundNode'Engine.Default__SoundNode'
}
