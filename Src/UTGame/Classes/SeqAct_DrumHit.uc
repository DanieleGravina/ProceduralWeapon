/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * A custom action to demonstrate condensing a complex Kismet script into a single action.
 */
class SeqAct_DrumHit extends SeqAct_Latent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Sound to play on activation */
var() SoundCue HitSound;

/** Light brightness range */
var() editinline DistributionFloatUniform BrightnessRange;

/** Light brightness interpolation rates */
var() float BrightnessRampUpRate;
var() float BrightnessRampDownRate;

/** Which direction are we currently interpolating brightness? */
var transient float PulseDirection;

/** Current interpolation value */
var transient float LightBrightness;

/** Cached list of lights to interpolate */
var transient array<Light> CachedLights;

defaultproperties
{
   Begin Object Class=DistributionFloatUniform Name=LightBrightnessDistribution ObjName=LightBrightnessDistribution Archetype=DistributionFloatUniform'Engine.Default__DistributionFloatUniform'
      Max=1.000000
      Name="LightBrightnessDistribution"
      ObjectArchetype=DistributionFloatUniform'Engine.Default__DistributionFloatUniform'
   End Object
   BrightnessRange=LightBrightnessDistribution
   BrightnessRampUpRate=0.100000
   BrightnessRampDownRate=0.500000
   InputLinks(0)=(LinkDesc="Sound Only")
   InputLinks(1)=(LinkDesc="All")
   VariableLinks(0)=(LinkDesc="Sound Source")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Light",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Emitter",MinVars=1,MaxVars=255)
   ObjName="Drum Hit"
   ObjCategory="DemoGame"
   Name="Default__SeqAct_DrumHit"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
