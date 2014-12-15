/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSkelControl_CoreSpin extends SkelControlSingleBone
	native(Animation)
	hidecategories(Adjustments,Translation,Rotation);

/** How fast is the core to spin at max health */

var(Spin)	float 	DegreesPerSecondMax;	
var(Spin)	float	DegreesPerSecondMin;

/** Spin the other way */
var(Spin)	bool	bCounterClockwise;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   DegreesPerSecondMax=180.000000
   DegreesPerSecondMin=40.000000
   bApplyRotation=True
   bAddRotation=True
   BoneRotationSpace=BCS_ActorSpace
   Name="Default__UTSkelControl_CoreSpin"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
