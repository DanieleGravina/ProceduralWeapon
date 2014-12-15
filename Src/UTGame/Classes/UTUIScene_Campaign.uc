/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_Campaign extends UTUIScene
	native(UI)
	abstract;

defaultproperties
{
   bPauseGameWhileActive=False
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene:SceneEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_Campaign"
   ObjectArchetype=UTUIScene'UTGame.Default__UTUIScene'
}
