/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class WindDirectionalSourceComponent extends ActorComponent
	native
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var native private	transient noimport const pointer SceneProxy{FWindSourceSceneProxy};

var() float	Strength;
var() float Phase;
var() float Frequency;
var() float Speed;

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
   Strength=1.000000
   Frequency=1.000000
   Speed=1024.000000
   Name="Default__WindDirectionalSourceComponent"
   ObjectArchetype=ActorComponent'Engine.Default__ActorComponent'
}
