/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DirectionalLightComponent extends LightComponent
	native
	collapsecategories
	hidecategories(Object)
	editinlinenew;

/**
 * Trace distance for static lighting. Objects further than TraceDistance away from an object won't be taken into 
 * account for static shadowing applied to said object. This is used to work around floating point consistency
 * issues in the collision code with regard to very long traces. The old default was WORLD_MAX.
 */
var(AdvancedLighting)	float	TraceDistance;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   TraceDistance=100000.000000
   bCastCompositeShadow=True
   Name="Default__DirectionalLightComponent"
   ObjectArchetype=LightComponent'Engine.Default__LightComponent'
}
