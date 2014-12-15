/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeDensityComponent extends ActorComponent
	native(FogVolume)
	collapsecategories
	hidecategories(Object)
	abstract
	editinlinenew;

/** True if the fog is enabled. */
var()	const	bool			bEnabled;

/** Color used to approximate fog material color on transparency. */
var()	const	interp	LinearColor	ApproxFogLightColor;

/** Array of actors that will define the shape of the fog volume. */
var()	const	array<Actor>	FogVolumeActors;

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

/**
 * Changes the enabled state of the height fog component.
 * @param bSetEnabled - The new value for bEnabled.
 */
final native function SetEnabled(bool bSetEnabled);

defaultproperties
{
   bEnabled=True
   ApproxFogLightColor=(R=0.500000,G=0.500000,B=0.700000,A=1.000000)
   Name="Default__FogVolumeDensityComponent"
   ObjectArchetype=ActorComponent'Engine.Default__ActorComponent'
}
