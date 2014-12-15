/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTAnimBlendBySlotActive extends AnimNodeBlendPerBone
	native(Animation);


/** Cached pointer to slot node that we'll be monitoring. */
var AnimNodeSlot	ChildSlot;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Children(0)=(Name="Default")
   Children(1)=(Name="Slot")
   Name="Default__UTAnimBlendBySlotActive"
   ObjectArchetype=AnimNodeBlendPerBone'Engine.Default__AnimNodeBlendPerBone'
}
