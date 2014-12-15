/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Specific version of the menu list that draws an icon in addition to the menu text for selecting maps.
 */
class UTUIMapSelectionMenuList extends UTUIIconMenuList;

// @todo: Set the current icon based on the current game mode.

defaultproperties
{
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIIconMenuList:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUIIconMenuList:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIMapSelectionMenuList"
   ObjectArchetype=UTUIIconMenuList'UTGame.Default__UTUIIconMenuList'
}
