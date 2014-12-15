/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ActorFactoryAI extends ActorFactory
	config(Editor)
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() class<AIController>			ControllerClass;
var() class<Pawn>					PawnClass;
var() string						PawnName;

/** whether or not to give the spawned Pawn the default inventory for the gametype being played */
var() bool bGiveDefaultInventory;
/** additional inventory to give the Pawn */
var() array< class<Inventory> > InventoryList;
/** what team to put the AI on */
var() int TeamIndex;

defaultproperties
{
   ControllerClass=Class'Engine.AIController'
   TeamIndex=255
   bPlaceable=False
   Name="Default__ActorFactoryAI"
   ObjectArchetype=ActorFactory'Engine.Default__ActorFactory'
}
