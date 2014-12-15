/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DemoGame extends GameInfo;

auto State PendingMatch
{
Begin:
	StartMatch();
}

defaultproperties
{
   DefaultPawnClass=Class'UTGame.DemoPawn'
   PlayerControllerClass=Class'UTGame.DemoPlayerController'
   Name="Default__DemoGame"
   ObjectArchetype=GameInfo'Engine.Default__GameInfo'
}
