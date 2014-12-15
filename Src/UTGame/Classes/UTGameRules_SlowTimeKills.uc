// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.

class UTGameRules_SlowTimeKills extends GameRules;

var float SlowTime;
var float RampUpTime;
var float SlowSpeed;

function ScoreKill(Controller Killer, Controller Killed)
{
	if ( PlayerController(Killer) != None )
	{
		WorldInfo.Game.SetGameSpeed(SlowSpeed);
		SetTimer(SlowTime, false);
	}
	if ( NextGameRules != None )
	{
		NextGameRules.ScoreKill(Killer,Killed);
	}
}

function timer()
{
	GotoState('rampup');
}

state Rampup
{
	function Tick(float DeltaTime)
	{
		local float NewGameSpeed;

		NewGameSpeed = WorldInfo.Game.GameSpeed + DeltaTime/RampUpTime;
		if ( NewGameSpeed >= 1 )
		{
			WorldInfo.Game.SetGameSpeed(1.0);
			GotoState('');
		}
		else
		{
			WorldInfo.Game.SetGameSpeed(NewGameSpeed);
		}
	}
}

defaultproperties
{
   SlowTime=0.300000
   RampUpTime=0.100000
   SlowSpeed=0.250000
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__GameRules:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__GameRules:Sprite'
   End Object
   Components(0)=Sprite
   Name="Default__UTGameRules_SlowTimeKills"
   ObjectArchetype=GameRules'Engine.Default__GameRules'
}
