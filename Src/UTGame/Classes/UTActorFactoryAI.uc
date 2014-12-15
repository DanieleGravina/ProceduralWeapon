/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTActorFactoryAI extends ActorFactoryAI
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() bool bForceDeathmatchAI;

/** Try and use physics hardware for this spawned object. */
var() bool bUseCompartment;

defaultproperties
{
   ControllerClass=Class'UTGame.UTBot'
   Name="Default__UTActorFactoryAI"
   ObjectArchetype=ActorFactoryAI'Engine.Default__ActorFactoryAI'
}
