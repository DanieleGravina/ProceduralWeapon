/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSkelControl_Rotate extends SkelControlSingleBone
	native(Animation);

/** Where we wish to get to */
var(Desired) rotator	DesiredBoneRotation;

/** The Rate we wish to rotate */
var(Desired) rotator	DesiredBoneRotationRate;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bApplyRotation=True
   bAddRotation=True
   BoneRotationSpace=BCS_BoneSpace
   Name="Default__UTSkelControl_Rotate"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
