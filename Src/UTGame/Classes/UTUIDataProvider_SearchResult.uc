/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * UT specific search result that exposes some extra fields to the server browser.
 */
class UTUIDataProvider_SearchResult extends UIDataProvider_Settings
	native(UI);

/** data field tags - cached for faster lookup */
var	const	name	PlayerRatioTag;
var	const	name	GameModeFriendlyNameTag;
var	const	name	ServerFlagsTag;
var	const	name	MapNameTag;

/** the path name to the font containing the icons used to display the server flags */
var	const	string	IconFontPathName;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   PlayerRatioTag="PlayerRatio"
   GameModeFriendlyNameTag="GameModeFriendlyName"
   ServerFlagsTag="ServerFlags"
   MapNameTag="CustomMapName"
   IconFontPathName="UI_Fonts_Final.Menus.UI_Fonts_Icons"
   Name="Default__UTUIDataProvider_SearchResult"
   ObjectArchetype=UIDataProvider_Settings'Engine.Default__UIDataProvider_Settings'
}
