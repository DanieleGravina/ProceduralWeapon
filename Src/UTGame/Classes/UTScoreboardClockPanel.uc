/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTScoreboardClockPanel extends UTDrawPanel;

var() Texture2D Background;
var() TextureCoordinates BackCoords;
var() LinearColor BackColor;

var() font ClockFont;
var() vector2d ClockPos;

/** Cached reference to the HUDSceneOwner */
var UTUIScene_Hud UTHudSceneOwner;

event PostInitialize()
{
	Super.PostInitialize();
	UTHudSceneOwner = UTUIScene_Hud( GetScene() );
}


event DrawPanel()
{
}

defaultproperties
{
   BackColor=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTDrawPanel:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTDrawPanel:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTScoreboardClockPanel"
   ObjectArchetype=UTDrawPanel'UTGame.Default__UTDrawPanel'
}
