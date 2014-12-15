/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** The Root mission never get's played.  It is mearly the starting point and guareneteed to be index 0 */
class UTSeqObj_SPRootMission extends UTSeqObj_SPMission
	native(UI);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bFirstMission=True
   MissionInfo=(MissionTitle="NewGame")
   OutputLinks(0)=(LinkDesc="FirstMission")
   ObjName="Single Player Mission (ROOT)"
   ObjComment="Root Mission"
   Name="Default__UTSeqObj_SPRootMission"
   ObjectArchetype=UTSeqObj_SPMission'UTGame.Default__UTSeqObj_SPMission'
}
