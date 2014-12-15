/**
 * Event which is activated by gameplay code when a new item is added to a controller's inventory list.
 * Orignator: the pawn that owns the InventoryList that the item was added to
 * Instigator: the inventory item that was added.
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqEvent_GetInventory extends SequenceEvent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bPlayerOnly=False
   VariableLinks(0)=(LinkDesc="Inventory")
   ObjName="Get Inventory"
   ObjCategory="Pawn"
   Name="Default__SeqEvent_GetInventory"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
