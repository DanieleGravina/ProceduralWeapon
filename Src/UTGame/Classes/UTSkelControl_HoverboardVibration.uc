/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 *	Controller used by hoverboard for moving lower part in response to wheel movements.
 */

class UTSkelControl_HoverboardVibration extends SkelControlSingleBone
	hidecategories(Translation,Rotation)
	native(Animation);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()	float	VibFrequency;
var()	float	VibSpeedAmpScale;
var()	float	VibTurnAmpScale;
var()	float	VibMaxAmplitude;

var		float	VibInput;

defaultproperties
{
   bApplyTranslation=True
   bAddTranslation=True
   BoneTranslationSpace=BCS_BoneSpace
   Name="Default__UTSkelControl_HoverboardVibration"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
