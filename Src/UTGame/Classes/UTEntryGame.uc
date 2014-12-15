/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTEntryGame extends UTTeamGame;

function bool NeedPlayers()
{
	return false;
}

exec function AddBots(int num) {}

function StartMatch()
{}

// Parse options for this game...
event InitGame( string Options, out string ErrorMessage )
{}

auto State PendingMatch
{
	function RestartPlayer(Controller aPlayer)
	{
	}

	function Timer()
    {
    }

    function BeginState(Name PreviousStateName)
    {
		bWaitingToStartMatch = true;
		UTGameReplicationInfo(GameReplicationInfo).bWarmupRound = false;
	StartupStage = 0;
		bQuickStart = false;
    }

	function EndState(Name NextStateName)
	{
		UTGameReplicationInfo(GameReplicationInfo).bWarmupRound = false;
	}
}

defaultproperties
{
   bExportMenuData=False
   ConsolePlayerControllerClass=Class'UTGame.UTEntryPlayerController'
   HUDType=Class'UTGame.UTEntryHUD'
   PlayerControllerClass=Class'UTGame.UTEntryPlayerController'
   Name="Default__UTEntryGame"
   ObjectArchetype=UTTeamGame'UTGame.Default__UTTeamGame'
}
