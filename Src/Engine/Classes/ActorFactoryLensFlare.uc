/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryLensFlare extends ActorFactory
	config(Editor)
	collapsecategories
	hidecategories(Object)
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()	LensFlare		LensFlareObject;

defaultproperties
{
   MenuName="Add LensFlare"
   NewActorClass=Class'Engine.LensFlareSource'
   Name="Default__ActorFactoryLensFlare"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
