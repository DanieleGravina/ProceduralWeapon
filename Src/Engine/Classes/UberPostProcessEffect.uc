/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Uber post process effect
 *
 */
class UberPostProcessEffect extends DOFAndBloomEffect
	native;

/** */
var() vector SceneShadows;
/** */
var() vector SceneHighLights;
/** */
var() vector SceneMidTones;
/** */
var() float  SceneDesaturation;

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
// (cpptext)
// (cpptext)
// (cpptext)

//
// The UberPostProcessingEffect performs DOF, Bloom, Material (Sharpen/Desaturate) and Tone Mapping
//
// For the DOF and Bloom parameters see DOFAndBloomEffect.uc.  The Material parameters are used as
// follows:
//
// Color0 = ((InputColor - SceneShadows) / SceneHighLights) ^ SceneMidTones
// Color1 = Luminance(Color0)
//
// OutputColor = Color0 * (1 - SceneDesaturation) + Color1 * SceneDesaturation
//

defaultproperties
{
   SceneShadows=(X=0.000000,Y=0.000000,Z=-0.003000)
   SceneHighLights=(X=0.800000,Y=0.800000,Z=0.800000)
   SceneMidTones=(X=1.300000,Y=1.300000,Z=1.300000)
   SceneDesaturation=0.400000
   Name="Default__UberPostProcessEffect"
   ObjectArchetype=DOFAndBloomEffect'Engine.Default__DOFAndBloomEffect'
}
