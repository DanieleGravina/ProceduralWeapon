/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Tab page for a user's general stats.
 */
class UTUITabPage_StatsGeneral extends UTUITabPage_StatsPage
	placeable;

/** Post initialization event - Setup widget delegates.*/
event PostInitialize()
{
	Super.PostInitialize();

	// Set the button tab caption.
	SetDataStoreBinding("<Strings:UTGameUI.Stats.General>");

	RefreshingLabel.SetVisibility(false);
}

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUITabPage_StatsPage:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUITabPage_StatsPage:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUITabPage_StatsGeneral"
   ObjectArchetype=UTUITabPage_StatsPage'UTGame.Default__UTUITabPage_StatsPage'
}
