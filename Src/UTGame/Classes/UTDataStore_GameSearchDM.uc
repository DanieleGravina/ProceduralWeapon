/**
 * This game search data store handles generating and receiving results for internet queries of all gametypes.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDataStore_GameSearchDM extends UTDataStore_GameSearchBase
	dependson(UTUIFrontEnd_BrowserMutatorFilters)
	config(UI);










const GS_USERNAME_MAXLENGTH					 = 15;
const GS_PASSWORD_MAXLENGTH					 = 30;
const GS_MESSAGE_MAXLENGTH					 = 255;
const GS_EMAIL_MAXLENGTH					 = 50;
const GS_CDKEY_PART_MAXLENGTH				 = 4;


const CONTEXT_PRESENCE_MENUPRESENCE              = 0;

const CONTEXT_GAME_MODE							 = 0x0000800B;


const CONTEXT_GAME_MODE_DM                       = 0;
const CONTEXT_GAME_MODE_CTF                      = 1;
const CONTEXT_GAME_MODE_WAR                      = 2;
const CONTEXT_GAME_MODE_VCTF					 = 3;
const CONTEXT_GAME_MODE_TDM                      = 4;
const CONTEXT_GAME_MODE_DUEL                     = 5;
const CONTEXT_GAME_MODE_CUSTOM                   = 6;
const CONTEXT_GAME_MODE_CAMPAIGN                 = 7;
const CONTEXT_GAME_MODE_GREED					 = 8;
const CONTEXT_GAME_MODE_BETRAYAL				 = 9;

const CONTEXT_BOTSKILL                           = 0;
const CONTEXT_MAPNAME                            = 1;
const CONTEXT_PURESERVER                         = 6;
const CONTEXT_LOCKEDSERVER                       = 7;
const CONTEXT_VSBOTS                             = 8;
const CONTEXT_CAMPAIGN                           = 9;
const CONTEXT_FORCERESPAWN                       = 10;
const CONTEXT_ALLOWKEYBOARD                      = 11;
const CONTEXT_FULLSERVER                         = 12;
const CONTEXT_EMPTYSERVER                        = 13;
const CONTEXT_DEDICATEDSERVER                    = 14;


const CONTEXT_BOTSKILL_AUTOADJUSTSKILL                     = 0;
const CONTEXT_BOTSKILL_NOVICE                              = 1;
const CONTEXT_BOTSKILL_AVERAGE                             = 2;
const CONTEXT_BOTSKILL_EXPERIENCED                         = 3;
const CONTEXT_BOTSKILL_SKILLED                             = 4;
const CONTEXT_BOTSKILL_ADEPT                               = 5;
const CONTEXT_BOTSKILL_MASTERFUL                           = 6;
const CONTEXT_BOTSKILL_INHUMAN                             = 7;
const CONTEXT_BOTSKILL_GODLIKE                             = 8;




const CONTEXT_MAPNAME_CUSTOM                     = 0;
const CONTEXT_MAPNAME_CORET                      = 1;
const CONTEXT_MAPNAME_HYDROSIS                   = 2;
const CONTEXT_MAPNAME_OMICRON_DAWN               = 3;
const CONTEXT_MAPNAME_REFLECTION                 = 4;
const CONTEXT_MAPNAME_STRIDENT                   = 5;
const CONTEXT_MAPNAME_VERTEBRAE                  = 6;
const CONTEXT_MAPNAME_ARSENAL                    = 7;
const CONTEXT_MAPNAME_BIOHAZARD                  = 8;
const CONTEXT_MAPNAME_CARBON_FIRE                = 9;
const CONTEXT_MAPNAME_DECK                       = 10;
const CONTEXT_MAPNAME_DEFIANCE                   = 11;
const CONTEXT_MAPNAME_DEIMOS                     = 12;
const CONTEXT_MAPNAME_DIESEL                     = 13;
const CONTEXT_MAPNAME_FEARLESS                   = 14;
const CONTEXT_MAPNAME_GATEWAY                    = 15;
const CONTEXT_MAPNAME_HEAT_RAY                   = 16;
const CONTEXT_MAPNAME_RISING_SUN                 = 17;
const CONTEXT_MAPNAME_SANCTUARY                  = 18;
const CONTEXT_MAPNAME_SENTINEL                   = 19;
const CONTEXT_MAPNAME_SHANGRILA                  = 20;
const CONTEXT_MAPNAME_CONTAINMENT                = 21;
const CONTEXT_MAPNAME_CONTAINMENTSP              = 22;
const CONTEXT_MAPNAME_CORRUPTION                 = 23;
const CONTEXT_MAPNAME_KARGO                      = 24;
const CONTEXT_MAPNAME_NECROPOLIS                 = 25;
const CONTEXT_MAPNAME_SANDSTORM                  = 26;
const CONTEXT_MAPNAME_SUSPENSE                   = 27;
const CONTEXT_MAPNAME_AVALANCHE                  = 28;
const CONTEXT_MAPNAME_DOWNTOWN                   = 29;
const CONTEXT_MAPNAME_DUSK                       = 30;
const CONTEXT_MAPNAME_FLOODGATE                  = 31;
const CONTEXT_MAPNAME_ISLANDER                   = 32;
const CONTEXT_MAPNAME_ISLANDERNECRIS             = 33;
const CONTEXT_MAPNAME_MARKET_DISTRICT            = 34;
const CONTEXT_MAPNAME_ONYX_COAST                 = 35;
const CONTEXT_MAPNAME_POWER_SURGE                = 36;
const CONTEXT_MAPNAME_SERENITY                   = 37;
const CONTEXT_MAPNAME_SERENITYNECRIS             = 38;
const CONTEXT_MAPNAME_SINKHOLE                   = 39;
const CONTEXT_MAPNAME_TANK_CROSSING              = 40;
const CONTEXT_MAPNAME_TORLAN                     = 41;
const CONTEXT_MAPNAME_TORLANLEVIATHAN            = 42;
const CONTEXT_MAPNAME_TORLANNECRIS               = 43;
const CONTEXT_MAPNAME_MISSION_SELECTION          = 44;
const CONTEXT_MAPNAME_KBARGE					 = 45;
const CONTEXT_MAPNAME_MORBIAS					 = 46;
const CONTEXT_MAPNAME_FACINGWORLDS				 = 47;
const CONTEXT_MAPNAME_SEARCHLIGHT				 = 48;
const CONTEXT_MAPNAME_RAILS						 = 49;
const CONTEXT_MAPNAME_SUSPENSE_NECRIS			 = 50;
const CONTEXT_MAPNAME_COLDHARBOR				 = 51;
const CONTEXT_MAPNAME_DOWNTOWNNECRIS			 = 52;

const CONTEXT_MAPNAME_LOSTCAUSE					 = 53;
const CONTEXT_MAPNAME_MORBID					 = 54;
const CONTEXT_MAPNAME_NANOBLACK					 = 55;
const CONTEXT_MAPNAME_SHAFT						 = 56;
const CONTEXT_MAPNAME_DARKMATCH					 = 57;
const CONTEXT_MAPNAME_OCEANRELIC				 = 58;
const CONTEXT_MAPNAME_EDENINC					 = 59;
const CONTEXT_MAPNAME_TURBINE					 = 60;
const CONTEXT_MAPNAME_STRANDED					 = 61;
const CONTEXT_MAPNAME_CONFRONTATION				 = 62;
const CONTEXT_MAPNAME_HOSTILE					 = 63;



const CONTEXT_GOALSCORE_5                        = 0;
const CONTEXT_GOALSCORE_10                       = 1;
const CONTEXT_GOALSCORE_15                       = 2;
const CONTEXT_GOALSCORE_20                       = 3;
const CONTEXT_GOALSCORE_30                       = 4;



const CONTEXT_NUMBOTS_0                          = 0;
const CONTEXT_NUMBOTS_1                          = 1;
const CONTEXT_NUMBOTS_2                          = 2;
const CONTEXT_NUMBOTS_3                          = 3;
const CONTEXT_NUMBOTS_4                          = 4;
const CONTEXT_NUMBOTS_5                          = 5;
const CONTEXT_NUMBOTS_6                          = 6;
const CONTEXT_NUMBOTS_7                          = 7;
const CONTEXT_NUMBOTS_8                          = 8;



const CONTEXT_TIMELIMIT_5                        = 0;
const CONTEXT_TIMELIMIT_10                       = 1;
const CONTEXT_TIMELIMIT_15                       = 2;
const CONTEXT_TIMELIMIT_20                       = 3;
const CONTEXT_TIMELIMIT_30                       = 4;



const CONTEXT_PURESERVER_NO                                = 0;
const CONTEXT_PURESERVER_YES                               = 1;
const CONTEXT_PURESERVER_ANY                               = 2;



const CONTEXT_LOCKEDSERVER_NO                              = 0;
const CONTEXT_LOCKEDSERVER_YES                             = 1;



const CONTEXT_CAMPAIGN_NO                                  = 0;
const CONTEXT_CAMPAIGN_YES                                 = 1;



const CONTEXT_FORCERESPAWN_NO                              = 0;
const CONTEXT_FORCERESPAWN_YES                             = 1;



const CONTEXT_ALLOWKEYBOARD_NO                             = 0;
const CONTEXT_ALLOWKEYBOARD_YES                            = 1;
const CONTEXT_ALLOWKEYBOARD_ANY                            = 2;


const CONTEXT_FULLSERVER_NO                                = 0;
const CONTEXT_FULLSERVER_YES                               = 1;


const CONTEXT_EMPTYSERVER_NO					= 0;
const CONTEXT_EMPTYSERVER_YES					= 1;


const CONTEXT_DEDICATEDSERVER_NO                = 0;
const CONTEXT_DEDICATEDSERVER_YES               = 1;



const  CONTEXT_VSBOTS_NONE                       = 0;
const  CONTEXT_VSBOTS_1_TO_2                     = 1;
const  CONTEXT_VSBOTS_1_TO_1                     = 2;
const  CONTEXT_VSBOTS_3_TO_2					 = 3;
const  CONTEXT_VSBOTS_2_TO_1                     = 4;
const  CONTEXT_VSBOTS_3_TO_1                     = 5;
const  CONTEXT_VSBOTS_4_TO_1                     = 6;

const PROPERTY_NUMBOTS							 = 0x100000F7;
const PROPERTY_GOALSCORE						 = 0x100000F8;
const PROPERTY_TIMELIMIT				         = 0x100000F9;
const PROPERTY_NUMBOTSIA				         = 0x100000FA;
const PROPERTY_LEADERBOARDRATING	             = 0x20000004;
const PROPERTY_EPICMUTATORS                      = 0x10000105;
const PROPERTY_STEAMID					         = 0x10000200;
const PROPERTY_STEAMVAC					         = 0x10000201;


const PROPERTY_CUSTOMMAPNAME                     = 0x40000001;
const PROPERTY_CUSTOMGAMEMODE                    = 0x40000002;
const PROPERTY_SERVERDESCRIPTION                 = 0x40000003;
const PROPERTY_CUSTOMMUTATORS                    = 0x40000004;
const PROPERTY_CUSTOMMUTCLASSES                  = 0x40000005;


const QUERY_DM									 = 0;
const QUERY_TDM									 = 1;
const QUERY_CTF									 = 2;
const QUERY_VCTF								 = 3;
const QUERY_WAR									 = 4;
const QUERY_DUEL								 = 5;
const QUERY_CAMPAIGN							 = 6;
const QUERY_GREED								 = 7;
const QUERY_BETRAYAL							 = 8;



const STATS_VIEW_DM_PLAYER_ALLTIME                         = 1;
const STATS_VIEW_DM_RANKED_ALLTIME                         = 2;
const STATS_VIEW_DM_WEAPONS_ALLTIME                        = 3;
const STATS_VIEW_DM_VEHICLES_ALLTIME                       = 4;
const STATS_VIEW_DM_VEHICLEWEAPONS_ALLTIME                 = 5;
const STATS_VIEW_DM_VEHICLES_RANKED_ALLTIME                = 6;
const STATS_VIEW_DM_VEHICLEWEAPONS_RANKED_ALLTIME          = 7;
const STATS_VIEW_DM_WEAPONS_RANKED_ALLTIME                 = 8;

#linenumber 10

/** Struct for defining a mutator filter setting */
struct MutatorFilter
{
	var string MutatorClass;	// Classname of the mutator (must not include package name)
	var bool bMutatorName;		// If true, MutatorClass represents a mutator name instead of class
	var int OfficialMutValue;	// If this is non-zero, then MutatorClass is ignored and this is treated as an official mutator

	var bool bMustBeOn;		// If true, the mutator must be enabled on the server, otherwise it must be disabled
};


var			class<UTDataStore_GameSearchHistory>	HistoryGameSearchDataStoreClass;

/** Reference to the search data store that handles the player's list of most recently visited servers */
var	transient	UTDataStore_GameSearchHistory		HistoryGameSearchDataStore;

/** Reference to the data store which handles the 'Find IP' and 'Add IP' IP search queries */
var transient UTDataStore_GameSearchFind FindGameSearchDataStore;


/** Can be set to ML_NoMutators (no mutators must be running), ML_AnyMutators (doesn't matter what mutators are running) and ML_Custom (checks MutatorFilters) */
var EMutatorList MutatorFilterSetting;

/** If 'MutatorFilterSetting' is set to ML_Custom, then servers must match the list of mutator filter settings defined here */
var array<MutatorFilter> MutatorFilters;


/** These lists are cached here for use by the mutator filter menu */
var array<EMutFilterList> InstalledMutFilters;
var array<EMutFilterList> AdditionalMutClassFilters;
var array<EMutFilterList> AdditionalMutNameFilters;
var bool bMutatorFilterSet;


/** When a custom gametype is selected in the server browser, this value is set to the gametypes class, and is used to properly filter that gametype */
var transient string CustomGameTypeClass;



/**
 * A simple mapping of localized setting ID to a localized setting value ID.
 */
struct PersistentLocalizedSettingValue
{
	/** the ID of the setting */
	var	config	int		SettingId;

	/** the id of the value */
	var	config	int		ValueId;
};

/**
 * Stores a list of values ids for a single game search configuration.
 */
struct GameSearchSettingsStorage
{
	/** the name of the game search configuration */
	var	config	name									GameSearchName;

	/** the list of stored values */
	var	config	array<PersistentLocalizedSettingValue>	StoredValues;
};

/** the list of search parameter values per game search configuration */
var	config	array<GameSearchSettingsStorage>	StoredGameSearchValues;


event Registered( LocalPlayer PlayerOwner )
{
	local DataStoreClient DSClient;

	Super.Registered(PlayerOwner);

	DSClient = GetDataStoreClient();
	if ( DSClient != None )
	{
		// now create the game history data store
		if ( HistoryGameSearchDataStoreClass == None )
		{
			HistoryGameSearchDataStoreClass = class'UTGame.UTDataStore_GameSearchHistory';
		}

		HistoryGameSearchDataStore = DSClient.CreateDataStore(HistoryGameSearchDataStoreClass);
		HistoryGameSearchDataStore.PrimaryGameSearchDataStore = Self;

		// and register it
		DSClient.RegisterDataStore(HistoryGameSearchDataStore, PlayerOwner);


		// Create the game find data store
		FindGameSearchDataStore = DSClient.CreateDataStore(Class'UTGame.UTDataStore_GameSearchFind');
		FindGameSearchDataStore.PrimaryGameSearchDataStore = Self;
		FindGameSearchDataStore.HistoryGameSearchDataStore = HistoryGameSearchDataStore;

		// Register it
		DSClient.RegisterDataStore(FindGameSearchDataStore, PlayerOwner);
	}

	LoadGameSearchParameters();
}

/**
 * Called to kick off an online game search and set up all of the delegates needed; this version saved the search parameters
 * to persistent storage and sets up extra filters.
 *
 * @param ControllerIndex the ControllerId for the player to perform the search for
 * @param bInvalidateExistingSearchResults	specify FALSE to keep previous searches (i.e. for other gametypes) in memory; default
 *											behavior is to clear all search results when switching to a different item in the game search list
 *
 * @return TRUE if the search call works, FALSE otherwise
 */
event bool SubmitGameSearch(byte ControllerIndex, optional bool bInvalidateExistingSearchResults=true)
{
	local int i, OfficialMutsOn, OfficialMutsOff;
	local OnlineGameSearch GS;
	local ClientOnlineGameSearchOrClause CurClientFilter;
	local RawOnlineGameSearchOrClause CurRawFilter;
	local array<string> CustomMutClassesOn, CustomMutClassesOff, CustomMutNamesOn, CustomMutNamesOff;

	// Setup the filters
	GS = GetCurrentGameSearch();
	GS.ResetFilters();

	if (MutatorFilterSetting == ML_NoMutators)
	{
		// Setup the clientside filter to remove all servers running any official mutators
		CurClientFilter.OrParams.Length = 1;
		CurClientFilter.OrParams[0].EntryId = PROPERTY_EPICMUTATORS;
		CurClientFilter.OrParams[0].EntryType = OGSET_Property;
		CurClientFilter.OrParams[0].ComparisonDelegate = NoOfficialMuts;
		CurClientFilter.OrParams[0].ComparedValue = "0";

		GS.ClientsideFilters.AddItem(CurClientFilter);


		// Setup the 'raw' master server query to removal all servers running custom mutators
		CurRawFilter.OrParams.Length = 1;
		CurRawFilter.OrParams[0].EntryId = PROPERTY_CUSTOMMUTCLASSES;
		CurRawFilter.OrParams[0].EntryType = OGSET_Property;
		CurRawFilter.OrParams[0].ComparisonOperator = "=";
		CurRawFilter.OrParams[0].ComparedValue = "''";

		GS.RawFilterQueries.AddItem(CurRawFilter);


		// Check the mutator names field as well as the mutator classes field
		CurRawFilter.OrParams[0].EntryId = PROPERTY_CUSTOMMUTATORS;
		GS.RawFilterQueries.AddItem(CurRawFilter);
	}
	else if (MutatorFilterSetting == ML_Custom)
	{
		// First generate the official mutator bitmasks and custom mutator lists
		for (i=0; i<MutatorFilters.Length; ++i)
		{
			if (MutatorFilters[i].OfficialMutValue != 0)
			{
				if (MutatorFilters[i].bMustBeOn)
					OfficialMutsOn = OfficialMutsOn | MutatorFilters[i].OfficialMutValue;
				else
					OfficialMutsOff = OfficialMutsOff | MutatorFilters[i].OfficialMutValue;
			}
			else if (MutatorFilters[i].MutatorClass != "")
			{
				if (MutatorFilters[i].bMutatorName)
				{
					if (MutatorFilters[i].bMustBeOn)
						CustomMutNamesOn.AddItem(MutatorFilters[i].MutatorClass);
					else
						CustomMutNamesOff.AddItem(MutatorFilters[i].MutatorClass);
				}
				else
				{
					if (MutatorFilters[i].bMustBeOn)
						CustomMutClassesOn.AddItem(MutatorFilters[i].MutatorClass);
					else
						CustomMutClassesOff.AddItem(MutatorFilters[i].MutatorClass);
				}
			}
		}


		// Now setup the clientside filters for the official mutator bitmask filters (must be done clientside since Gamespy can't do bitmask operations)
		CurClientFilter.OrParams.Length = 1;
		CurClientFilter.OrParams[0].EntryId = PROPERTY_EPICMUTATORS;
		CurClientFilter.OrParams[0].EntryType = OGSET_Property;

		if (OfficialMutsOn != 0)
		{
			CurClientFilter.OrParams[0].ComparisonDelegate = OfficialMutEnabled;
			CurClientFilter.OrParams[0].ComparedValue = string(OfficialMutsOn);

			GS.ClientsideFilters.AddItem(CurClientFilter);
		}

		if (OfficialMutsOff != 0)
		{
			CurClientFilter.OrParams[0].ComparisonDelegate = OfficialMutDisabled;
			CurClientFilter.OrParams[0].ComparedValue = string(OfficialMutsOff);

			GS.ClientsideFilters.AddItem(CurClientFilter);
		}


		// Setup the 'raw' master server filters for the custom mutator class filters
		CurRawFilter.OrParams.Length = 1;
		CurRawFilter.OrParams[0].EntryId = PROPERTY_CUSTOMMUTCLASSES;
		CurRawFilter.OrParams[0].EntryType = OGSET_Property;

		if (CustomMutClassesOn.Length != 0)
		{
			CurRawFilter.OrParams[0].ComparisonOperator = " LIKE";

			for (i=0; i<CustomMutClassesOn.Length; ++i)
			{
				// N.B. All mutator class entries are encased with a special character, Chr(28)
				CurRawFilter.OrParams[0].ComparedValue = "'%"$Chr(28)$CustomMutClassesOn[i]$Chr(28)$"%'";
				GS.RawFilterQueries.AddItem(CurRawFilter);
			}
		}

		if (CustomMutClassesOff.Length != 0)
		{
			CurRawFilter.OrParams[0].ComparisonOperator = " NOT LIKE";

			for (i=0; i<CustomMutClassesOff.Length; ++i)
			{
				CurRawFilter.OrParams[0].ComparedValue = "'%"$Chr(28)$CustomMutClassesOff[i]$Chr(28)$"%'";
				GS.RawFilterQueries.AddItem(CurRawFilter);
			}
		}


		// Finally, setup the raw filters for the custom mutator name filters
		CurRawFilter.OrParams[0].EntryId = PROPERTY_CUSTOMMUTATORS;

		if (CustomMutNamesOn.Length != 0)
		{
			CurRawFilter.OrParams[0].ComparisonOperator = " LIKE";

			for (i=0; i<CustomMutNamesOn.Length; ++i)
			{
				// N.B. It can't be guaranteed that the Chr(28) delimiter will be present in the names list, so don't include it in the query
				CurRawFilter.OrParams[0].ComparedValue = "'%"$CustomMutNamesOn[i]$"%'";
				GS.RawFilterQueries.AddItem(CurRawFilter);
			}
		}

		if (CustomMutNamesOff.Length != 0)
		{
			CurRawFilter.OrParams[0].ComparisonOperator = " NOT LIKE";

			for (i=0; i<CustomMutNamesOff.Length; ++i)
			{
				CurRawFilter.OrParams[0].ComparedValue = "'%"$CustomMutNamesOff[i]$"%'";
				GS.RawFilterQueries.AddItem(CurRawFilter);
			}
		}
	}

	// If the current search is a custom gametype search, then add a filter for that gametypes classname
	if (CustomGameTypeClass != "" && GameSearchCfgList[SelectedIndex].SearchName == 'UTGameSearchCustom')
	{
		CurRawFilter.OrParams.Length = 1;
		CurRawFilter.OrParams[0].EntryId = PROPERTY_CUSTOMGAMEMODE;
		CurRawFilter.OrParams[0].EntryType = OGSET_Property;
		CurRawFilter.OrParams[0].ComparisonOperator = "=";
		CurRawFilter.OrParams[0].ComparedValue = "'"$CustomGameTypeClass$"'";

		GS.RawFilterQueries.AddItem(CurRawFilter);
	}


	if ( bInvalidateExistingSearchResults || !HasExistingSearchResults() )
	{
		SaveGameSearchParameters();
	}

	return Super.SubmitGameSearch(ControllerIndex, bInvalidateExistingSearchResults);
}


// Clientside mutator filter operators

// For official mutators which must be on
final function bool OfficialMutEnabled(string PropertyValue, string ComparedValue)
{
	return !bool(~int(PropertyValue) & int(ComparedValue));
}

// For official muts which must be off
final function bool OfficialMutDisabled(string PropertyValue, string ComparedValue)
{
	return !bool(int(PropertyValue) & int(ComparedValue));
}

// No official muts at all
final function bool NoOfficialMuts(string PropertyValue, string ComparedValue)
{
	return int(PropertyValue) == 0;
}


/**
 * @param	bRestrictCheckToSelf	if TRUE, will not check related game search data stores for outstanding queries.
 *
 * @return	TRUE if a server list query was started but has not completed yet.
 */
function bool HasOutstandingQueries( optional bool bRestrictCheckToSelf )
{
	local bool bResult;

	bResult = Super.HasOutstandingQueries(bRestrictCheckToSelf);
	if ( !bResult && !bRestrictCheckToSelf && HistoryGameSearchDataStore != None )
	{
		bResult = HistoryGameSearchDataStore.HasOutstandingQueries(true);
		if ( !bResult && HistoryGameSearchDataStore.FavoritesGameSearchDataStore != None )
		{
			bResult = HistoryGameSearchDataStore.FavoritesGameSearchDataStore.HasOutstandingQueries(true);
		}
	}

	return bResult;
}

/** these have been moved up a class and are left like this for binary compatibility */
function bool GetEnabledMutators(out array<int> MutatorIndices)
{
	return Super.GetEnabledMutators(MutatorIndices);
}
function bool HasExistingSearchResults()
{
	return Super.HasExistingSearchResults();
}



/**
 * Finds the index of the saved parameters for the specified game search.
 *
 * @param	GameSearchName	the name of the game search to find saved parameters for
 *
 * @return	the index for the saved parameters associated with the specified gametype, or INDEX_NONE if not found.
 */
function int FindStoredSearchIndex( name GameSearchName )
{
	local int i, Result;

	Result = INDEX_NONE;
	for ( i = 0; i < StoredGameSearchValues.Length; i++ )
	{
		if ( StoredGameSearchValues[i].GameSearchName == GameSearchName )
		{
			Result = i;
			break;
		}
	}

	return Result;
}

/**
 * Find the index for the specified setting in a game search configuration's saved parameters.
 *
 * @param	StoredGameSearchIndex	the index of the game search configuration to lookup
 * @param	LocalizedSettingId		the id of the setting to find the value for
 * @param	bAddIfNecessary			if the specified setting Id is not found in the saved parameters for the game search config,
 *									automatically creates an entry for that setting if this value is TRUE
 *
 * @return	the index of the setting in the game search configuration's saved parameters list of settings, or INDEX_NONE if
 *			it doesn't exist.
 */
function int FindStoredSettingValueIndex( int StoredGameSearchIndex, int LocalizedSettingId, optional bool bAddIfNecessary )
{
	local int i, Result;

	Result = INDEX_NONE;
	if ( StoredGameSearchIndex >= 0 && StoredGameSearchIndex < StoredGameSearchValues.Length )
	{
		for ( i = 0; i < StoredGameSearchValues[StoredGameSearchIndex].StoredValues.Length; i++ )
		{
			if ( StoredGameSearchValues[StoredGameSearchIndex].StoredValues[i].SettingId == LocalizedSettingId )
			{
				Result = i;
				break;
			}
		}

		if ( Result == INDEX_NONE && bAddIfNecessary )
		{
			Result = StoredGameSearchValues[StoredGameSearchIndex].StoredValues.Length;

			StoredGameSearchValues[StoredGameSearchIndex].StoredValues.Length = Result + 1;
			StoredGameSearchValues[StoredGameSearchIndex].StoredValues[Result].SettingId = LocalizedSettingId;
		}
	}

	return Result;
}

/**
 * Loads the saved game search parameters from disk and initializes the game search objects with the previously
 * selected values.
 */
function LoadGameSearchParameters()
{
	local OnlineGameSearch Search;
	local int GameIndex, SettingIndex, SettingId,
		StoredSearchIndex, SettingValueIndex, SettingValueId;

	// for each game configuration
	for ( GameIndex = 0; GameIndex < GameSearchCfgList.Length; GameIndex++ )
	{
		Search = GameSearchCfgList[GameIndex].Search;
		if ( Search != None )
		{
			// find the index of the persistent settings for this gametype
			StoredSearchIndex = FindStoredSearchIndex(GameSearchCfgList[GameIndex].SearchName);
			if ( StoredSearchIndex != INDEX_NONE )
			{
				// for each localized setting in this game search object, copy the stored value into the search object for this game search configuration.
				for ( SettingIndex = 0; SettingIndex < Search.LocalizedSettings.Length; SettingIndex++ )
				{
					SettingId = Search.LocalizedSettings[SettingIndex].Id;

					// skip the gametype property
					if ( SettingId != class'UTGameSearchCommon'.const.CONTEXT_GAME_MODE )
					{
						SettingValueIndex = FindStoredSettingValueIndex(StoredSearchIndex, SettingId);
						if (SettingValueIndex >= 0
						&&	SettingValueIndex < StoredGameSearchValues[StoredSearchIndex].StoredValues.Length)
						{
							SettingValueId = StoredGameSearchValues[StoredSearchIndex].StoredValues[SettingValueIndex].ValueId;

							// apply it to the settings object
							Search.SetStringSettingValue(SettingId, SettingValueId, false);
						}
					}
				}
			}
		}
	}
}

/**
 * Saves the user selected game search options to disk.
 */
function SaveGameSearchParameters()
{
	local OnlineGameSearch Search;
	local int GameIndex, SettingIndex, SettingId,
		StoredSearchIndex, SettingValueIndex;
	local bool bDirty;

	// for each game configuration
	for ( GameIndex = 0; GameIndex < GameSearchCfgList.Length; GameIndex++ )
	{
		Search = GameSearchCfgList[GameIndex].Search;
		if ( Search != None )
		{
			// find the index of the persistent settings for this gametype
			StoredSearchIndex = FindStoredSearchIndex(GameSearchCfgList[GameIndex].SearchName);
			if ( StoredSearchIndex == INDEX_NONE )
			{
				// if not found, add a new entry to hold this game configuration's search params
				StoredSearchIndex = StoredGameSearchValues.Length;
				StoredGameSearchValues.Length = StoredSearchIndex + 1;
				StoredGameSearchvalues[StoredSearchIndex].GameSearchName = GameSearchCfgList[GameIndex].SearchName;
				bDirty = true;
			}

			// for each localized setting in this game search object, copy the current value into our persistent storage
			for ( SettingIndex = 0; SettingIndex < Search.LocalizedSettings.Length; SettingIndex++ )
			{
				SettingId = Search.LocalizedSettings[SettingIndex].Id;

				// skip the gametype property
				if ( SettingId != class'UTGameSearchCommon'.const.CONTEXT_GAME_MODE )
				{
					SettingValueIndex = FindStoredSettingValueIndex(StoredSearchIndex, SettingId, true);
					bDirty = bDirty || StoredGameSearchValues[StoredSearchIndex].StoredValues[SettingValueIndex].ValueId != Search.LocalizedSettings[SettingIndex].ValueIndex;
					StoredGameSearchValues[StoredSearchIndex].StoredValues[SettingValueIndex].ValueId = Search.LocalizedSettings[SettingIndex].ValueIndex;
				}
			}
		}
	}

	if ( bDirty )
	{
		SaveConfig();
	}
}

function SetCurrentByIndex(int NewIndex, optional bool bInvalidateExistingSearchResults=True)
{
	// Reset 'CustomGameTypeClass' if the current search index isn't set to the custom search index
	if (NewIndex == INDEX_None || NewIndex >= GameSearchCfgList.Length || GameSearchCfgList[NewIndex].SearchName != 'UTGameSearchCustom')
		CustomGameTypeClass = "";

	Super.SetCurrentByIndex(NewIndex, bInvalidateExistingSearchResults);
}

function SetCurrentByName(name SearchName, optional bool bInvalidateExistingSearchResults=True)
{
	if (SearchName != 'UTGameSearchCustom')
		CustomGameTypeClass = "";

	Super.SetCurrentByName(SearchName, bInvalidateExistingSearchResults);
}

defaultproperties
{
   HistoryGameSearchDataStoreClass=Class'UTGame.UTDataStore_GameSearchHistory'
   MutatorFilterSetting=ML_AnyMutators
   GameSearchCfgList(0)=(GameSearchClass=Class'UTGame.UTGameSearchDM',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsDM',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchDM")
   GameSearchCfgList(1)=(GameSearchClass=Class'UTGame.UTGameSearchTDM',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsTDM',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchTDM")
   GameSearchCfgList(2)=(GameSearchClass=Class'UTGame.UTGameSearchCTF',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsCTF',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchCTF")
   GameSearchCfgList(3)=(GameSearchClass=Class'UTGame.UTGameSearchVCTF',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsVCTF',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchVCTF")
   GameSearchCfgList(4)=(GameSearchClass=Class'UTGame.UTGameSearchWAR',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsWAR',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchWAR")
   GameSearchCfgList(5)=(GameSearchClass=Class'UTGame.UTGameSearchDUEL',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsDUEL',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchDUEL")
   GameSearchCfgList(6)=(GameSearchClass=Class'UTGame.UTGameSearchCampaign',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsCampaign',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchCampaign")
   GameSearchCfgList(7)=(GameSearchClass=Class'UTGame.UTGameSearchCustom',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsDM',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchCustom")
   GameSearchCfgList(8)=(GameSearchClass=Class'UTGame.UTGameSearchGreed',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsGreed',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchGreed")
   GameSearchCfgList(9)=(GameSearchClass=Class'UTGame.UTGameSearchBetrayal',DefaultGameSettingsClass=Class'UTGame.UTGameSettingsBetrayal',SearchResultsProviderClass=Class'UTGame.UTUIDataProvider_SearchResult',SearchName="UTGameSearchBetrayal")
   Tag="UTGameSearch"
   Name="Default__UTDataStore_GameSearchDM"
   ObjectArchetype=UTDataStore_GameSearchBase'UTGame.Default__UTDataStore_GameSearchBase'
}
