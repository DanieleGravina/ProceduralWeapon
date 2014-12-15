/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SoundNodeOscillator extends SoundNode
	native(Sound)
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var()	rawdistributionfloat	Amplitude;
var()	rawdistributionfloat	Frequency;
var()	rawdistributionfloat	Offset;
var()	rawdistributionfloat	Center;

var()	bool					bModulatePitch;
var()	bool					bModulateVolume;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Amplitude=(Distribution=DistributionAmplitude,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   Frequency=(Distribution=DistributionFrequency,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   Offset=(Distribution=DistributionOffset,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   Center=(Distribution=DistributionCenter,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.000000,0.000000,0.000000,0.000000,0.000000,0.000000))
   Name="Default__SoundNodeOscillator"
   ObjectArchetype=SoundNode'Engine.Default__SoundNode'
}
