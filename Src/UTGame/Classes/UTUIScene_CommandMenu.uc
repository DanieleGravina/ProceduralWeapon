/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTUIScene_CommandMenu extends UTUIScene_Hud;

event PostInitialize()
{
	Super.PostInitialize();
	bDisplayCursor = false;
	OnPreRenderCallback = PreRenderCallback;
}

function PreRenderCallback()
{
	bDisplayCursor = false;
}

defaultproperties
{
   bIgnoreAxisInput=True
   bDisplayCursor=True
   bRenderParentScenes=False
   bAlwaysRenderScene=True
   bFlushPlayerInput=False
   SceneInputMode=INPUTMODE_MatchingOnly
   Begin Object Class=UIComp_Event Name=SceneEventComponent ObjName=SceneEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
      DisabledEventAliases(0)="Clicked"
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIScene_Hud:SceneEventComponent'
   End Object
   EventProvider=SceneEventComponent
   Name="Default__UTUIScene_CommandMenu"
   ObjectArchetype=UTUIScene_Hud'UTGame.Default__UTUIScene_Hud'
}
