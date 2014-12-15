/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


/** creates a pickup (NOT pickup factory) in the world */
class UTActorFactoryPickup extends ActorFactory
	native;

var() class<Inventory> InventoryClass;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   NewActorClass=Class'UTGame.UTDroppedPickup'
   bPlaceable=False
   Name="Default__UTActorFactoryPickup"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
