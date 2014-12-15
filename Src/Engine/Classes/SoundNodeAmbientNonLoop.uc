/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SoundNodeAmbientNonLoop extends SoundNodeAmbient
	native(Sound)
	collapsecategories
	hidecategories(Object)
	dependson(SoundNodeAttenuation)
	editinlinenew;


var()								rawdistributionfloat	DelayTime;

struct native AmbientSoundSlot
{
	var()	SoundNodeWave	Wave;
	var()	float			PitchScale;
	var()	float			VolumeScale;
	var()	float			Weight;

	structdefaultproperties
	{
		PitchScale=1.0
		VolumeScale=1.0
		Weight=1.0
	}
};

var()								array<AmbientSoundSlot>	SoundSlots;

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
   DelayTime=(Distribution=DistributionDelayTime,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,1.000000,1.000000,1.000000,1.000000,1.000000))
   MinRadius=(Distribution=DistributionMinRadius)
   MaxRadius=(Distribution=DistributionMaxRadius)
   LPFMinRadius=(Distribution=DistributionLPFMinRadius)
   LPFMaxRadius=(Distribution=DistributionLPFMaxRadius)
   VolumeModulation=(Distribution=DistributionVolume)
   PitchModulation=(Distribution=DistributionPitch)
   Name="Default__SoundNodeAmbientNonLoop"
   ObjectArchetype=SoundNodeAmbient'Engine.Default__SoundNodeAmbient'
}
