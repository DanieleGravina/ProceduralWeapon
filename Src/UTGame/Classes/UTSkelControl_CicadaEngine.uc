/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSkelControl_CicadaEngine extends SkelControlSingleBone
	hidecategories(Translation, Rotation, Adjustment)
	native(Animation);

/** This holds the max. amount the engine can pitch */
var() float ForwardPitch;

/** This holds the min. amount the engine can pitch */
var() float BackPitch;

/** How fast does it change direction */
var() float PitchRate;

/** Velocity Range */

var() float MaxVelocity;
var() float MinVelocity;

var() float MaxVelocityPitchRateMultiplier;

/** Used to time the change */
var transient float PitchTime;

/** Holds the last thrust value */
var transient float LastThrust;

/** This holds the desired pitches for a given engine */
var transient int DesiredPitch;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   ForwardPitch=-40.000000
   BackPitch=40.000000
   PitchRate=0.500000
   MaxVelocity=2100.000000
   MinVelocity=100.000000
   MaxVelocityPitchRateMultiplier=0.150000
   bApplyRotation=True
   bAddRotation=True
   BoneRotationSpace=BCS_ActorSpace
   bIgnoreWhenNotRendered=True
   Name="Default__UTSkelControl_CicadaEngine"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
