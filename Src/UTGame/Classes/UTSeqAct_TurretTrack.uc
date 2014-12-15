/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_TurretTrack extends SeqAct_Interp
	native(Sequence)
	hidecategories(SeqAct_Interp);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

function Reset()
{
	SetPosition(0.0, false);
}

defaultproperties
{
   ReplicatedActorClass=Class'UTGame.UTTurretTrackActor'
   InputLinks(0)=(LinkDesc="Spawned")
   ObjName="Turret Track"
   Name="Default__UTSeqAct_TurretTrack"
   ObjectArchetype=SeqAct_Interp'Engine.Default__SeqAct_Interp'
}
