/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryEmitter extends ActorFactory
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

var()	ParticleSystem		ParticleSystem;

defaultproperties
{
   GameplayActorClass=Class'Engine.EmitterSpawnable'
   MenuName="Add Emitter"
   NewActorClass=Class'Engine.Emitter'
   Name="Default__ActorFactoryEmitter"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
