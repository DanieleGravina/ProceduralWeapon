/**
 * Provides information about the owning player.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class PlayerOwnerDataProvider extends PlayerDataProvider
	native(inherit);

/**
 * The player data provider registered with the GRI for this player.
 */
var	transient	PlayerDataProvider	PlayerData;


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

/**
 * Links the PlayerDataProvider for the local player to this data store.
 *
 * @param	NewPlayerData	the new PlayerDataProvider to use for presenting this player's data to the UI.
 */
function SetPlayerDataProvider( PlayerDataProvider NewPlayerData )
{
	local Object PRI;

	if ( NewPlayerData != None )
	{
		PRI = NewPlayerData.GetDataSource();
		if ( PRI != None )
		{
			BindProviderInstance(PRI);
		}
	}

	PlayerData = NewPlayerData;
}

/**
 * Allows the data provider to clear any references that would interfere with garbage collection.
 */
function bool CleanupDataProvider()
{
	if ( Super.CleanupDataProvider() )
	{
		PlayerData = None;
		return true;
	}

	return false;
}

defaultproperties
{
   Name="Default__PlayerOwnerDataProvider"
   ObjectArchetype=PlayerDataProvider'Engine.Default__PlayerDataProvider'
}
