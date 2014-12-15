/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqEvent_TurretSpawn extends SequenceEvent
	native(Sequence)
	hidecategories(SequenceEvent);

var name TurretGroupName;
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)


/** notification that the mover has completed all opening actions and is now ready to close */
simulated event TurretSpawned()
{
	local array<int> ActivateIndices;

	ActivateIndices[0] = 0;
	CheckActivate(Originator, Instigator, false, ActivateIndices);
}

defaultproperties
{
   TurretGroupName="TurretGroup"
   bPlayerOnly=False
   OutputLinks(0)=(LinkDesc="Spawned")
   ObjName="Turret Spawned"
   ObjCategory="Turrets"
   Name="Default__UTSeqEvent_TurretSpawn"
   ObjectArchetype=SequenceEvent'Engine.Default__SequenceEvent'
}
