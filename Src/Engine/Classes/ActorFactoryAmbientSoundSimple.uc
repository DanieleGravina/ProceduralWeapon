/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryAmbientSoundSimple extends ActorFactory
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

var()	SoundNodeWave	SoundNodeWave;

defaultproperties
{
   MenuName="Add AmbientSoundSimple"
   NewActorClass=Class'Engine.AmbientSoundSimple'
   Name="Default__ActorFactoryAmbientSoundSimple"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
