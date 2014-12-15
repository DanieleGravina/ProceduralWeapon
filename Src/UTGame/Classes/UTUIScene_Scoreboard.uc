/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_Scoreboard extends UTUIScene_Hud
	native(UI)
	abstract;

var UTPlayerController Host;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)


event PostInitialize()
{
	Super.PostInitialize();
	SceneClosedCue='';
}

/** Make sure we free up the reference to the host */
function NotifyGameSessionEnded()
{
	Super.NotifyGameSessionEnded();
	Host = none;
}

event TickScene(float DeltaTime)
{
}

defaultproperties
{
   SceneRenderMode=SPLITRENDER_Fullscreen
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_Scoreboard"
   ObjectArchetype=UTUIScene_Hud'UTGame.Default__UTUIScene_Hud'
}
