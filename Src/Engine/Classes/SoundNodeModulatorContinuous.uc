/**
 * NOTE:  If you have a looping sound the PlaybackTime will keep increasing.  And PlaybackTime
 * is what is used to get values from the Distributions.   So the Modulation will work the first
 * time through but subsequent times will not work for distributions with have a "size" to them.
 *
 * In short using a SoundNodeModulatorContinuous for looping sounds is not advised.
 * 
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 **/
class SoundNodeModulatorContinuous extends SoundNode
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
   VolumeModulation=(Distribution=DistributionVolume,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   PitchModulation=(Distribution=DistributionPitch,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   Name="Default__SoundNodeModulatorContinuous"
   ObjectArchetype=SoundNode'Engine.Default__SoundNode'
}
