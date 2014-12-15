/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTSeqAct_MissionSelectionReference extends SequenceAction;


var class<UTMissionInfo_Content> MissionSelectionClass;

defaultproperties
{
   MissionSelectionClass=Class'UTGameContent.UTMissionInfo_Content'
   ObjName="Mission Selection Reference"
   Name="Default__UTSeqAct_MissionSelectionReference"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
