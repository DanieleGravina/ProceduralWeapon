/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryAmbientSound extends ActorFactory
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

var()	SoundCue		AmbientSoundCue;

defaultproperties
{
   MenuName="Add AmbientSound"
   NewActorClass=Class'Engine.AmbientSound'
   Name="Default__ActorFactoryAmbientSound"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
