/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SoundNodeLooping extends SoundNode
	native(Sound)
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var()	bool					bLoopIndefinitely;
var()	rawdistributionfloat	LoopCount;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bLoopIndefinitely=True
   LoopCount=(Distribution=DistributionLoopCount,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1000000.000000,1000000.000000,1000000.000000,1000000.000000,1000000.000000,1000000.000000))
   Name="Default__SoundNodeLooping"
   ObjectArchetype=SoundNode'Engine.Default__SoundNode'
}
