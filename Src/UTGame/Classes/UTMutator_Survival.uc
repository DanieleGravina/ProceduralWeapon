/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTMutator_Survival extends UTMutator;

function PostBeginPlay()
{
	local UTDuelGame Game;

	Super.PostBeginPlay();

	Game = UTDuelGame(WorldInfo.Game);
	if (Game == None)
	{
		WarnInternal("Survival mutator only works in Duel");
		Destroy();
	}
	else
	{
		Game.bRotateQueueEachKill = true;
		Game.NumRounds = 1;
	}
}

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_Survival"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
