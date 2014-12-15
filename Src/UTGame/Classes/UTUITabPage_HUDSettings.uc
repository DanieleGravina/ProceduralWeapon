/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Tab page for a user's HUD settings.
 */

class UTUITabPage_HUDSettings extends UTUITabPage_Options
	placeable;


/** Post initialization event - Setup widget delegates.*/
event PostInitialize()
{
	Super.PostInitialize();

	// Set the button tab caption.
	SetDataStoreBinding("<Strings:UTGameUI.Settings.HUD>");
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUITabPage_Options:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUITabPage_Options:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUITabPage_HUDSettings"
   ObjectArchetype=UTUITabPage_Options'UTGame.Default__UTUITabPage_Options'
}
