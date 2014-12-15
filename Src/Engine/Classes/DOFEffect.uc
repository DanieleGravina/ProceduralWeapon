/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Depth of Field post process effect
 *
 */
class DOFEffect extends PostProcessEffect
	native
	abstract;

/** exponent to apply to blur amount after it has been normalized to [0,1] */
var() float FalloffExponent;
/** affects the size of the Poisson disc kernel */
var() float BlurKernelSize;
/** [0,1] value for clamping how much blur to apply to items in front of the focus plane */
var() float MaxNearBlurAmount;
/** [0,1] value for clamping how much blur to apply to items behind the focus plane */
var() float MaxFarBlurAmount;
/** blur color for debugging etc */
var() color ModulateBlurColor;

/** control how the focus point is determined */
var() enum EFocusType
{
	// use distance from the view
	FOCUS_Distance,
	// use a world space point
	FOCUS_Position	
} FocusType;
/** inner focus radius */
var() float FocusInnerRadius;
/** used when FOCUS_Distance is enabled */
var() float FocusDistance;
/** used when FOCUS_Position is enabled */
var() vector FocusPosition;

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
   FalloffExponent=2.000000
   BlurKernelSize=2.000000
   MaxNearBlurAmount=1.000000
   MaxFarBlurAmount=1.000000
   ModulateBlurColor=(B=255,G=255,R=255,A=255)
   FocusInnerRadius=400.000000
   FocusDistance=800.000000
   Name="Default__DOFEffect"
   ObjectArchetype=PostProcessEffect'Engine.Default__PostProcessEffect'
}
