/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class PointLightComponent extends LightComponent
	native
	collapsecategories
	hidecategories(Object)
	editinlinenew;

/** used to control when point light shadow mapping goes to a hack mode, the ShadowRadiusMultiplier is multiplied by the radius of object's bounding sphere */
var() interp float	ShadowRadiusMultiplier;

var() interp float	Radius;
/** Controls the radial falloff of the light */
var() interp float	FalloffExponent;
/** falloff for shadow when using LightShadow_Modulate */
var() float ShadowFalloffExponent;

var   const matrix							CachedParentToWorld; //@todo remove me please
var() const vector							Translation;

var const DrawLightRadiusComponent PreviewLightRadius;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

native final function SetTranslation(vector NewTranslation);

defaultproperties
{
   ShadowRadiusMultiplier=1.100000
   Radius=1024.000000
   FalloffExponent=2.000000
   ShadowFalloffExponent=2.000000
   Name="Default__PointLightComponent"
   ObjectArchetype=LightComponent'Engine.Default__LightComponent'
}
