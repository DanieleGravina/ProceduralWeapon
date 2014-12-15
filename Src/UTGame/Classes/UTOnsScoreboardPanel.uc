/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTOnsScoreboardPanel extends UTCTFScoreboardPanel;

defaultproperties
{
   FlagTexture=Texture2D'UI_HUD.HUD.UI_HUD_BaseA'
   FlagCoords=(U=600.000000,V=237.000000,UL=23.000000,VL=23.000000)
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTCTFScoreboardPanel:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTCTFScoreboardPanel:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTOnsScoreboardPanel"
   ObjectArchetype=UTCTFScoreboardPanel'UTGame.Default__UTCTFScoreboardPanel'
}
