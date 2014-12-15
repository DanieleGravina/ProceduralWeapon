/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryDecal extends ActorFactory
	config(Editor)
	native(Decal);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var()	MaterialInterface	DecalMaterial;

defaultproperties
{
   MenuName="Add Decal"
   NewActorClass=Class'Engine.DecalActor'
   Name="Default__ActorFactoryDecal"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
