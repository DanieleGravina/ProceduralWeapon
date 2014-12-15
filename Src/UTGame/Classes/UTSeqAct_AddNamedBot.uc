/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSeqAct_AddNamedBot extends SequenceAction;

/** name of bot to spawn */
var() string BotName;
/** If true, force the bot to a given team */
var() bool bForceTeam;
/** The Team to add this bot to.  For DM leave at 0, otherwise Red=0, Blue=1 */
var() int TeamIndex;
/** NavigationPoint to spawn the bot at */
var() NavigationPoint StartSpot;

/** reference to bot controller so Kismet can work with it further */
var UTBot SpawnedBot;

event Activated()
{
	local UTGame Game;

	Game = UTGame(GetWorldInfo().Game);
	if (Game != None)
	{
		Game.ScriptedStartSpot = StartSpot;
		if (Game.SinglePlayerMissionID != INDEX_NONE)
		{
			if (Game.NumDivertedOpponents > 0 && bForceTeam && TeamIndex != 0)
			{
				Game.NumDivertedOpponents--;
			}
			else
			{
				SpawnedBot = Game.SinglePlayerAddBot(BotName, bForceTeam, TeamIndex);
			}
		}
		else
		{
			SpawnedBot = Game.AddBot(BotName, bForceTeam, TeamIndex);
		}
		if (SpawnedBot != None && SpawnedBot.Pawn == None)
		{
			Game.RestartPlayer(SpawnedBot);
		}
		Game.ScriptedStartSpot = None;
	}
}

defaultproperties
{
   VariableLinks(0)=(LinkDesc="Bot",PropertyName="SpawnedBot",bWriteable=True)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Spawn Point",PropertyName="StartSpot",MinVars=1,MaxVars=1)
   ObjClassVersion=2
   ObjName="Add Named Bot"
   ObjCategory="AI"
   Name="Default__UTSeqAct_AddNamedBot"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
