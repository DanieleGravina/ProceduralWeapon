/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSkelControl_MantaFlaps extends SkelControlSingleBone
	hidecategories(Translation, Rotation, Adjustment)
	native(Animation);

var(Manta)	float	MaxPitch;
var			float	OldZPitch;

/** 1/MaxPitchTime is minimum time to go from 0 to max pitch */
var			float	MaxPitchTime;

/** Max pitch change per second */
var			float	MaxPitchChange;

var name RightFlapControl;
var name LeftFlapControl;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   maxPitch=30.000000
   MaxPitchTime=4.000000
   MaxPitchChange=10000.000000
   RightFlapControl="right_flap"
   LeftFlapControl="left_flap"
   bApplyRotation=True
   BoneRotationSpace=BCS_ActorSpace
   bIgnoreWhenNotRendered=True
   Name="Default__UTSkelControl_MantaFlaps"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
