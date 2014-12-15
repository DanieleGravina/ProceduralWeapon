/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_GiveInventory extends SequenceAction;

var() array<class<Inventory> >			InventoryList;
var() bool bClearExisting;

defaultproperties
{
   ObjName="Give Inventory"
   ObjCategory="Pawn"
   Name="Default__SeqAct_GiveInventory"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
