/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_Hud extends UTUIScene
	native(UI);


/****************************************************************************************
								 Support Functions
****************************************************************************************/

/**
 * Returns the UTHUD associated with this scene
 */
native function UTHUD GetPlayerHud();


/*
Things to be ported

- Progress Messages

*/

defaultproperties
{
   bDisplayCursor=False
   bRenderParentScenes=True
   bPauseGameWhileActive=False
   bExemptFromAutoClose=True
   SceneInputMode=INPUTMODE_None
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_Hud"
   ObjectArchetype=UTUIScene'UTGame.Default__UTUIScene'
}
