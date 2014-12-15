/**
 * Keyframe reduction algorithm that simply removes every second key.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class AnimationCompressionAlgorithm_RemoveEverySecondKey extends AnimationCompressionAlgorithm
	native(Anim);

/** Animations with fewer than MinKeys will not lose any keys. */
var()	int			MinKeys;

/**
 * If bStartAtSecondKey is TRUE, remove keys 1,3,5,etc.
 * If bStartAtSecondKey is FALSE, remove keys 0,2,4,etc.
 */
var()	bool		bStartAtSecondKey;

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
   MinKeys=10
   Description="Remove Every Second Key"
   Name="Default__AnimationCompressionAlgorithm_RemoveEverySecondKey"
   ObjectArchetype=AnimationCompressionAlgorithm'Engine.Default__AnimationCompressionAlgorithm'
}
