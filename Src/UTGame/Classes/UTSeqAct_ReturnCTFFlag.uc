/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTSeqAct_ReturnCTFFlag extends SequenceAction;

/** the team whose flag should be returned */
var() int TeamIndex;

event Activated()
{
	local UTCarriedObject Flag;
	local UTCTFGame Game;

	if (TeamIndex < ArrayCount(Game.Teams))
	{
		Game = UTCTFGame(GetWorldInfo().Game);
		Flag = Game.Teams[TeamIndex].TeamFlag;
		if (Flag != None)
		{
			Flag.KismetSendHome();
		}
	}
}

defaultproperties
{
   bCallHandler=False
   ObjName="Return CTF Flag"
   ObjCategory="Objective"
   Name="Default__UTSeqAct_ReturnCTFFlag"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
