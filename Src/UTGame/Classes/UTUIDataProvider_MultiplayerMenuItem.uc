/**
 * Provides menu items for the multiplayer menu.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTUIDataProvider_MultiplayerMenuItem extends UTUIResourceDataProvider
	native(UI)
	PerObjectConfig;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Friendly displayable name to the player. */
var config localized string FriendlyName;

/** Localized description of the map */
var config localized string Description;

/** Indicates that this menu item should only be shown if the user is online, signed in, and has the required priveleges */
var	config	bool	bRequiresOnlineAccess;

defaultproperties
{
   Name="Default__UTUIDataProvider_MultiplayerMenuItem"
   ObjectArchetype=UTUIResourceDataProvider'UTGame.Default__UTUIResourceDataProvider'
}
