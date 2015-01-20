/**
 * Provides information about a player.  There will be a data store for each player in the game.  The PlayerDataProvider
 * associated with the owning player will be accessible via the 'PlayerOwner' tag.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class PlayerDataProvider extends UIDynamicDataProvider
	native(inherit);

defaultproperties
{
   DataClass=Class'Engine.PlayerReplicationInfo'
   Name="Default__PlayerDataProvider"
   ObjectArchetype=UIDynamicDataProvider'Engine.Default__UIDynamicDataProvider'
}