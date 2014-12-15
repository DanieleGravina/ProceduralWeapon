/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSkelControl_JetThruster extends SkelControlSingleBone
	hidecategories(Translation, Rotation, Adjustment)
	native(Animation);

var(Thruster) float MaxForwardVelocity;
var(Thruster) float BlendRate;

var transient float DesiredStrength;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   MaxForwardVelocity=1500.000000
   BlendRate=0.300000
   bIgnoreWhenNotRendered=True
   Name="Default__UTSkelControl_JetThruster"
   ObjectArchetype=SkelControlSingleBone'Engine.Default__SkelControlSingleBone'
}
