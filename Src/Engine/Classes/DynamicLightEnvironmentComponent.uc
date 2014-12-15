/**
 * This is used to light components / actors during the game.  Doing something like:
 * LightEnvironment=FooLightEnvironment
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DynamicLightEnvironmentComponent extends LightEnvironmentComponent
	native;

/** The current state of the light environment. */
var private native transient const pointer State{class FDynamicLightEnvironmentState};

/** The number of seconds between light environment updates for actors which aren't visible. */
var() float InvisibleUpdateTime;

/** Minimum amount of time that needs to pass between full environment updates. */
var() float MinTimeBetweenFullUpdates;

/** The number of visibility samples to use within the primitive's bounding volume. */
var() int NumVolumeVisibilitySamples;

/** The color of the ambient shadow. */
var() LinearColor AmbientShadowColor;

/** The direction of the ambient shadow source. */
var() vector AmbientShadowSourceDirection;

/** Ambient color added in addition to the level's lighting. */
var() LinearColor AmbientGlow;

/** Desaturation percentage of level lighting, which can be used to help team colored characters stand out better under colored lighting. */
var() float LightDesaturation;

/** The distance to create the light from the owner's origin, in radius units. */
var() float LightDistance;

/** The distance for the shadow to project beyond the owner's origin, in radius units. */
var() float ShadowDistance;

/** Whether the light environment should cast shadows */
var() bool bCastShadows;

/** Time since the caster was last visible at which the mod shadow will fade out completely.  */
var() float ModShadowFadeoutTime;

/** Exponent that controls mod shadow fadeout curve. */
var() float ModShadowFadeoutExponent;

/** Quality of shadow buffer filtering to use on the light environment */
var() EShadowFilterQuality ShadowFilterQuality;

/** Whether the light environment should be dynamically updated. */
var() bool bDynamic;

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
   InvisibleUpdateTime=4.000000
   MinTimeBetweenFullUpdates=0.300000
   NumVolumeVisibilitySamples=1
   AmbientShadowColor=(R=0.150000,G=0.150000,B=0.150000,A=1.000000)
   AmbientShadowSourceDirection=(X=0.000000,Y=0.000000,Z=1.000000)
   AmbientGlow=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   LightDistance=1.500000
   ShadowDistance=1.000000
   bCastShadows=True
   bDynamic=True
   ModShadowFadeoutExponent=3.000000
   TickGroup=TG_PostAsyncWork
   Name="Default__DynamicLightEnvironmentComponent"
   ObjectArchetype=LightEnvironmentComponent'Engine.Default__LightEnvironmentComponent'
}
