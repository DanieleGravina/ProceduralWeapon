/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtGame_Content extends UTOnslaughtGame;

defaultproperties
{
   TeamAIType(0)=Class'UTGame.UTOnslaughtTeamAI'
   TeamAIType(1)=Class'UTGame.UTOnslaughtTeamAI'
   HUDType=Class'UTGame.UTOnslaughtHUD'
   PlayerReplicationInfoClass=Class'UTGame.UTOnslaughtPRI'
   GameReplicationInfoClass=Class'UTGame.UTOnslaughtGRI'
   MessageClass=Class'UTGameContent.UTOnslaughtMessage'
   Name="Default__UTOnslaughtGame_Content"
   ObjectArchetype=UTOnslaughtGame'UTGame.Default__UTOnslaughtGame'
}
