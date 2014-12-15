/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class SeqAct_SetDOFParams extends SeqAct_Latent
	native(Sequence);
	
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

/** inner focus radius */
var() float FocusInnerRadius;
/** used when FOCUS_Distance is enabled */
var() float FocusDistance;
/** used when FOCUS_Position is enabled */
var() vector FocusPosition;
/** Time to interpolate values over */
var() float InterpolateSeconds;
/** Elapsed interpolation time */
var float InterpolateElapsed;

// Previous values, used in lerp()
var float OldFalloffExponent;
var float OldBlurKernelSize;
var float OldMaxNearBlurAmount;
var float OldMaxFarBlurAmount;
var color OldModulateBlurColor;
var float OldFocusInnerRadius;
var float OldFocusDistance;
var vector OldFocusPosition;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   FalloffExponent=4.000000
   BlurKernelSize=5.000000
   MaxNearBlurAmount=1.000000
   MaxFarBlurAmount=1.000000
   ModulateBlurColor=(B=255,G=255,R=255,A=255)
   FocusInnerRadius=600.000000
   FocusDistance=600.000000
   InterpolateSeconds=2.000000
   InputLinks(0)=(LinkDesc="Enable")
   InputLinks(1)=(LinkDesc="Disable")
   ObjName="Depth Of Field"
   ObjCategory="Camera"
   Name="Default__SeqAct_SetDOFParams"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
