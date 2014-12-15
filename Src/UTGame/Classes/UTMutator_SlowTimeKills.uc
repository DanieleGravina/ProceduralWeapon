// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
class UTMutator_SlowTimeKills extends UTMutator;

var class<GameRules> GRClass;

function bool MutatorIsAllowed()
{
	return (WorldInfo.NetMode == NM_Standalone);
}

function InitMutator(string Options, out string ErrorMessage)
{
	WorldInfo.Game.AddGameRules(GRClass);

	Super.InitMutator(Options, ErrorMessage);
}

defaultproperties
{
   GRClass=Class'UTGame.UTGameRules_SlowTimeKills'
   GroupNames(0)="GAMESPEED"
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTMutator:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTMutator_SlowTimeKills"
   ObjectArchetype=UTMutator'UTGame.Default__UTMutator'
}
