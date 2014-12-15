/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSkelControl_RaptorTail extends SkelControlSingleBone
	hidecategories(Translation, Rotation, Adjustment)
	native(Animation);

var(Tail)	int	YawConstraint;
var(Tail)	int	Deadzone;

var int	  LastVehicleYaw;

var int   TailYaw;
var int	  DesiredTailYaw;

var bool bInitialized;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   YawConstraint=20
   Deadzone=50
   bApplyRotation=True
   BoneRotationSpace=BCS_ActorSpace
   bIgnoreWhenNotRendered=True
   Name="Default__UTSkelControl_RaptorTail"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
