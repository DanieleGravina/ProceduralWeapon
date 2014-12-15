/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** Holds the settings that are common to all match types */
class UTGameSettingsCommon extends OnlineGameSettings
	native;










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

#linenumber 9

/** The maximum number of players allowed on this server. */
var databinding int MaxPlayers;

/** The minumum number of players that must be present before the match starts. */
var databinding int MinNetPlayers;

/**
 * Converts a string to a hexified blob.
 *
 * @param InString	String to convert.
 * @param OutBlob	Resulting blob
 *
 * @return	Returns whether or not the string was converted.
 */
native static function bool StringToBlob(const out string InString, out string OutBlob);

/**
 * Converts a hexified blob to a normal string.
 *
 * @param InBlob	String to convert back.
 *
 * @return	Returns whether or not the string was converted.
 */
native static function string BlobToString(const out string InBlob);


/**
 * Sets the property that advertises the custom map name
 *
 * @param MapName the string to use
 */
function SetCustomMapName(string MapName)
{
	local SettingsData CustomMap;

	if (Properties[4].PropertyId == PROPERTY_CUSTOMMAPNAME)
	{
		SetSettingsDataString(CustomMap,MapName);
		Properties[4].Data = CustomMap;
	}
	else
	{
		LogInternal("Failed to set custom map name because property order changed!");
	}
}

/**
 * Sets the property that advertises the official mutators being used in the game.
 *
 * @param	MutatorBitmask	bitmask of epic mutators that are active for this game session (bits are derived
 *							by left-shifting by the mutator's index into the UTUIDataStore_MenuItems' list of
 *							UTUIDataProvider_Mutators
 */
function SetOfficialMutatorBitmask( int MutatorBitmask )
{
	SetIntProperty(PROPERTY_EPICMUTATORS, MutatorBitmask);
}

/**
 * Builds a URL string out of the properties/contexts and databindings of this object.
 */
function BuildURL(out string OutURL)
{
	local int SettingIdx;
	local int OutValue;
	local float Ratio;
	local name SettingName;
	local name PropertyName;
	local string Description;

	OutURL = "";

	// Append properties marked with the databinding keyword to the URL
	AppendDataBindingsToURL(OutURL);

	// Remove undesired URL options
	Class'UTGame'.static.RemoveOption(OutURL, "PingInMs");
	Class'UTGame'.static.RemoveOption(OutURL, "AverageSkillRating");
	Class'UTGame'.static.RemoveOption(OutURL, "EngineVersion");
	Class'UTGame'.static.RemoveOption(OutURL, "MinNetVersion");
	Class'UTGame'.static.RemoveOption(OutURL, "ServerIP");


	// Iterate through localized settings and append them
	for (SettingIdx = 0; SettingIdx < LocalizedSettings.length; SettingIdx++)
	{
		SettingName = GetStringSettingName(LocalizedSettings[SettingIdx].Id);
		if (SettingName != '')
		{
			// For certain context's, output their string value name instead of their value index.
			switch(LocalizedSettings[SettingIdx].Id)
			{
			case CONTEXT_BOTSKILL:
				//botskill is 0-7 in game CONTEXT_BOTSKILL_NOVICE starts at 1
				OutURL $= "?Difficulty=" $ Clamp(LocalizedSettings[SettingIdx].ValueIndex-1, 0, 7);
				break;

			case CONTEXT_VSBOTS:
				if(GetStringSettingValue(CONTEXT_VSBOTS, OutValue))
				{
					Ratio = -1.0f;

					// Convert the vs bot context value to a floating point ratio of bots to players.
					switch(OutValue)
					{
					case CONTEXT_VSBOTS_1_TO_2:
						Ratio = 0.5f;
						break;
					case CONTEXT_VSBOTS_1_TO_1:
						Ratio = 1.0f;
						break;
					case CONTEXT_VSBOTS_3_TO_2:
						Ratio = 1.5f;
						break;
					case CONTEXT_VSBOTS_2_TO_1:
						Ratio = 2.0f;
						break;
					case CONTEXT_VSBOTS_3_TO_1:
						Ratio = 3.0f;
						break;
					case CONTEXT_VSBOTS_4_TO_1:
						Ratio = 4.0f;
						break;
					default:
						break;
					}

					if(Ratio > 0)
					{
						OutURL $= "?VsBots=" $ Ratio;
					}
				}
				break;

			// these are the values that are handled in other ways (don't append the values here)
			case CONTEXT_MAPNAME:		// index of map - but we go by mapname
			case CONTEXT_FULLSERVER:	// calculated on the server as players login
			case CONTEXT_EMPTYSERVER:	// calculated on the server as players login
			case CONTEXT_DEDICATEDSERVER:	// calculated on server based on the databinding property bIsDedicated
				break;

				// GameInfo.UpdateGameSettingsCounts() won't be called until a player logs in, so pass IsEmptyServer=1
				// on the URL so that dedicated servers will start off with this set
			case CONTEXT_ALLOWKEYBOARD:
				if ( class'UIRoot'.static.IsConsole(CONSOLE_PS3) )	// Only set allow keyboard option on ps3.
				{
					OutURL $= "?" $ SettingName $ "=" $ LocalizedSettings[SettingIdx].ValueIndex;
				}
				break;
			default:
				OutURL $= "?" $ SettingName $ "=" $ LocalizedSettings[SettingIdx].ValueIndex;
				break;
			}
		}
	}

	// Now add all properties the same way
	for (SettingIdx = 0; SettingIdx < Properties.length; SettingIdx++)
	{
		PropertyName = GetPropertyName(Properties[SettingIdx].PropertyId);
		if (PropertyName != '')
		{
			switch(Properties[SettingIdx].PropertyId)
			{
			case PROPERTY_NUMBOTS:
			case PROPERTY_NUMBOTSIA:
			case PROPERTY_STEAMID:
			case PROPERTY_STEAMVAC:
				// Will be handled by game launching code.
				break;

			case PROPERTY_SERVERDESCRIPTION:
				Description=GetPropertyAsString(PROPERTY_SERVERDESCRIPTION);
				// encode the string so that we don't have to worry about parsing errors
				OutURL $= "?ServerDescription=" $ BlobToString(Description);
				break;

			// skip this property because we assemble the mask on the server side based on the mutator class names
			case PROPERTY_EPICMUTATORS:
			// skip this property because we assemble the list of friendly names/classnames based on the active mutators
			case PROPERTY_CUSTOMMUTATORS:
			case PROPERTY_CUSTOMMUTCLASSES:
			case PROPERTY_CUSTOMMAPNAME:
			case PROPERTY_CUSTOMGAMEMODE:
				break;

			default:
				OutURL $= "?" $ PropertyName $ "=" $ GetPropertyAsString(Properties[SettingIdx].PropertyId);
				break;
			}
		}
	}
}

/**
 * Updates the game settings object from parameters passed on the URL
 *
 * @param URL the URL to parse for settings
 */
function UpdateFromURL(const out string URL, GameInfo Game)
{
	local string Description;
	local string RealDescription;
	local string BotSkillString, BotCountString;

	Super.UpdateFromURL(URL, Game);

	// Put back the question marks in the server description
	Description = GetPropertyAsString(PROPERTY_SERVERDESCRIPTION);

	// Make sure that we don't exceed our max allowing player counts for this game type!  Usually this is 32.
	NumPublicConnections = Game.MaxPlayers;
	NumPrivateConnections = 0;

	// Unblob the string
	if(StringToBlob(Description, RealDescription))
	{
		SetStringProperty(PROPERTY_SERVERDESCRIPTION, RealDescription);
	}

	SetMutators(URL);

	BotSkillString = class'GameInfo'.static.ParseOption(URL, "Difficulty");
	if ( BotSkillString != "" )
	{
		SetStringSettingValueByName('BotSkill', int(BotSkillString), true);
	}

	BotCountString = class'GameInfo'.static.ParseOption(URL, "NumPlay");
	if ( BotCountString != "" )
	{
		SetIntProperty(PROPERTY_NUMBOTS, int(BotCountString) - 1);
	}

	if (Game.WorldInfo.NetMode == NM_DedicatedServer || class'GameInfo'.static.HasOption(URL, "Dedicated"))
	{
		bIsDedicated = true;
	}

	if ( bIsDedicated )
	{
		SetStringSettingValue(CONTEXT_DEDICATEDSERVER,CONTEXT_DEDICATEDSERVER_YES,true);
	}
	SetIntProperty(PROPERTY_GOALSCORE, Game.GoalScore);
	SetIntProperty(PROPERTY_TIMELIMIT, Game.TimeLimit);
}


function SetMutators( const out string URL )
{
	local DataStoreClient DSClient;
	local UTUIDataStore_MenuItems MenuDataStore;
	local string MutatorURLValue;
	local array<string> MutatorClassNames;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();
	if ( DSClient != None )
	{
		MenuDataStore = UTUIDataStore_MenuItems(DSClient.FindDataStore('UTMenuItems'));
		if ( MenuDataStore != None )
		{
			// get the comma-delimited string of mutator class names from the URL
			MutatorURLValue = class'GameInfo'.static.ParseOption(URL, "Mutator");
			if ( MutatorURLValue != "" )
			{
				// separate into an array of strings
				ParseStringIntoArray(MutatorURLValue, MutatorClassNames, ",", true);
			}
		}
	}

	SetOfficialMutatorBitmask(NewGenerateMutatorBitmaskFromURL(MenuDataStore, MutatorClassNames));

	// now do the custom mutators
	SetCustomMutators(MenuDataStore, MutatorClassNames);
}

/**
 * Generates a bitmask of active mutators which were created by epic.  The bits are derived by left-shifting by
 * the mutator's index into the UTUIDataStore_MenuItems' list of UTUIDataProvider_Mutators.
 *
 * @return	a bitmask which has bits on for any enabled official mutators.
 */
function int NewGenerateMutatorBitmaskFromURL( UTUIDataStore_MenuItems MenuDataStore, out array<string> MutatorClassNames )
{
	local int Idx, MutatorIdx, EnabledMutatorBitmask;
	local string GameModeString;
	local string BitIndexValue;

	// Some mutators are filtered out based on the currently selected gametype, so in order to guarantee
	// that our bitmasks always match up (i.e. between a client and server), clear the setting that mutators
	// use for filtering so that we always get the complete list.  We'll restore it once we're done.
	class'UIRoot'.static.GetDataStoreStringValue("<Registry:SelectedGameMode>", GameModeString);
	class'UIRoot'.static.SetDataStoreStringValue("<Registry:SelectedGameMode>", "");

	for ( Idx = 0; Idx < MutatorClassNames.Length; Idx++ )
	{
		MutatorIdx = MenuDataStore.FindValueInProviderSet('OfficialMutators', 'ClassName', MutatorClassNames[Idx]);
		if ( MutatorIdx != INDEX_NONE )
		{
			MenuDataStore.GetValueFromProviderSet('OfficialMutators', 'BitValue', MutatorIdx, BitIndexValue);
			EnabledMutatorBitmask += int(BitIndexValue);
			MutatorClassNames.Remove(Idx--, 1);
		}
	}

	class'UIRoot'.static.SetDataStoreStringValue("<Registry:SelectedGameMode>", GameModeString);

	return EnabledMutatorBitmask;
}

/** OBSOLETE - use NewGenerateMutatorBitmaskFromURL() */
function int GenerateMutatorBitmaskFromURL( const out string URL )
{
	local DataStoreClient DSClient;
	local UTUIDataStore_MenuItems MenuDataStore;
	local int Idx, MutatorIdx, EnabledMutatorBitmask;
	local string MutatorURLValue;
	local array<string> MutatorClassNames;

	local string GameModeString;

	DSClient = class'UIInteraction'.static.GetDataStoreClient();
	if ( DSClient != None )
	{
		MenuDataStore = UTUIDataStore_MenuItems(DSClient.FindDataStore('UTMenuItems'));
		if ( MenuDataStore != None )
		{
			// get the comma-delimited string of mutator class names from the URL
			MutatorURLValue = class'GameInfo'.static.ParseOption(URL, "Mutator");
			if ( MutatorURLValue != "" )
			{
				// Some mutators are filtered out based on the currently selected gametype, so in order to guarantee
				// that our bitmasks always match up (i.e. between a client and server), clear the setting that mutators
				// use for filtering so that we always get the complete list.  We'll restore it once we're done.
				class'UIRoot'.static.GetDataStoreStringValue("<Registry:SelectedGameMode>", GameModeString);
				class'UIRoot'.static.SetDataStoreStringValue("<Registry:SelectedGameMode>", "");

				// separate into an array of strings
				ParseStringIntoArray(MutatorURLValue, MutatorClassNames, ",", true);
				for ( Idx = 0; Idx < MutatorClassNames.Length; Idx++ )
				{
					MutatorIdx = MenuDataStore.FindValueInProviderSet('OfficialMutators', 'ClassName', MutatorClassNames[Idx]);
					if ( MutatorIdx != INDEX_NONE )
					{
						EnabledMutatorBitmask = EnabledMutatorBitmask | (1 << MutatorIdx);
					}
				}

				class'UIRoot'.static.SetDataStoreStringValue("<Registry:SelectedGameMode>", GameModeString);
			}
		}
	}

	return EnabledMutatorBitmask;
}

/**
 * Sets the custom mutators property with a delimited string containing the friendly names for all active custom (non-epic) mutators.
 *
 * @param	MenuDataStore		the data store which contains the UI data for all game resources (mutators, maps, gametypes, etc.)
 * @param	MutatorClassNames	the array of pathnames for all mutators currently active in the game
 */
function SetCustomMutators( UTUIDataStore_MenuItems MenuDataStore, const out array<string> MutatorClassNames )
{
	local int Idx, MutatorIdx, Pos;
	local string MutatorName, CustomMutators, CustomMutatorDelimiter, CustomMutClasses;

	// just cache the delimiter so we don't have to evaluate each time
	CustomMutatorDelimiter = Chr(28);
	for ( Idx = 0; Idx < MutatorClassNames.Length; Idx++ )
	{
		// find the index of the UTUIDataProvider_Mutator with the specified classname
		MutatorIdx = MenuDataStore.FindValueInProviderSet('Mutators', 'ClassName', MutatorClassNames[Idx]);
		if ( MutatorIdx != INDEX_NONE )
		{
			// get the value of the FriendlyName property for this UTUIDataProvider_Mutator
			if ( MenuDataStore.GetValueFromProviderSet('Mutators', 'FriendlyName', MutatorIdx, MutatorName) )
			{
				// append it to the string that will be set as the value for CustomMutators
				if ( CustomMutators != "" )
				{
					CustomMutators $= CustomMutatorDelimiter;
				}

				CustomMutators $= MutatorName;
			}
		}

		// Append the classname for the current mutator (only the classname, not the package name)
		Pos = InStr(MutatorClassNames[Idx], ".");

		// N.B. The delimiter must come before and after every mutator class entry
		CustomMutClasses $= CustomMutatorDelimiter;

		if (Pos == INDEX_None)
			CustomMutClasses $= MutatorClassNames[Idx];
		else
			CustomMutClasses $= Mid(MutatorClassNames[Idx], Pos+1);
	}

	if (CustomMutClasses != "")
		CustomMutClasses $= CustomMutatorDelimiter;

	//@note - CustomMutators/CustomMutClasses might be blank
	SetStringProperty(PROPERTY_CUSTOMMUTATORS, CustomMutators);
	SetStringProperty(PROPERTY_CUSTOMMUTCLASSES, CustomMutClasses);
}


/**
 * If a property setting wont fit into the server details results, give the script a chance to trim the data
 * NOTE: Value will be in the format: ",Property=Value"
 *
 * @param PropertyId The id of the property setting to be trimmed
 * @param MaxLen The maximum length of the string
 * @param Value The modified string value
 *
 * @return Whether or not the value was successfully trimmed
 */
function bool TrimPropertyValue(int PropertyID, int MaxLen, out string Value)
{
	local int DelimiterPos;

	if (PropertyID == PROPERTY_CUSTOMMUTATORS || PropertyID == PROPERTY_CUSTOMMUTCLASSES)
	{
		Value = Left(Value, MaxLen+1);
		DelimiterPos = InStr(Value, Chr(28), True);

		if (DelimiterPos != INDEX_None)
		{
			Value = Left(Value, DelimiterPos);
			return True;
		}
	}


	return False;
}

defaultproperties
{
   MaxPlayers=16
   NumPublicConnections=16
   OptionalDataBindingSettings(0)="AverageSkillRating"
   OptionalLocalizedSettings(0)=0
   OptionalLocalizedSettings(1)=8
   OptionalLocalizedSettings(2)=10
   OptionalPropertySettings(0)=268435704
   OptionalPropertySettings(1)=268435705
   OptionalPropertySettings(2)=1073741828
   OptionalPropertySettings(3)=1073741829
   LocalizedSettings(0)=(Id=32779,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(1)=(ValueIndex=2,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(2)=(Id=1,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(3)=(Id=6,ValueIndex=1,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(4)=(Id=7,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(5)=(Id=8,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(6)=(Id=9,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(7)=(Id=10,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(8)=(Id=11,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(9)=(Id=12,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(10)=(Id=13,ValueIndex=1,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(11)=(Id=14,AdvertisementType=ODAT_OnlineService)
   Properties(0)=(PropertyId=1073741825,Data=(Type=SDT_String),AdvertisementType=ODAT_QoS)
   Properties(1)=(PropertyId=1073741826,Data=(Type=SDT_String),AdvertisementType=ODAT_QoS)
   Properties(2)=(PropertyId=268435704,Data=(Type=SDT_Int32,Value1=20),AdvertisementType=ODAT_OnlineService)
   Properties(3)=(PropertyId=268435705,Data=(Type=SDT_Int32,Value1=20),AdvertisementType=ODAT_OnlineService)
   Properties(4)=(PropertyId=268435703,Data=(Type=SDT_Int32,Value1=6),AdvertisementType=ODAT_OnlineService)
   Properties(5)=(PropertyId=1073741827,Data=(Type=SDT_String),AdvertisementType=ODAT_QoS)
   Properties(6)=(PropertyId=268435717,Data=(Type=SDT_Int32),AdvertisementType=ODAT_OnlineService)
   Properties(7)=(PropertyId=1073741828,Data=(Type=SDT_String),AdvertisementType=ODAT_QoS)
   Properties(8)=(PropertyId=1073741829,Data=(Type=SDT_String),AdvertisementType=ODAT_QoS)
   Properties(9)=(PropertyId=268435706,Data=(Type=SDT_Int32,Value1=6))
   Properties(10)=(PropertyId=268435968,Data=(Type=SDT_Int64))
   Properties(11)=(PropertyId=268435969,Data=(Type=SDT_Int32))
   LocalizedSettingsMappings(0)=(Id=32779,Name="GameMode",ColumnHeaderText="Partita",ValueMappings=((Name="Deathmatch"),(Id=4,Name="Deathmatch a squadre"),(Id=1,Name="Cattura La Bandiera"),(Id=3,Name="Veicolo CLB"),(Id=2,Name="Warfare"),(Id=5,Name="Duello"),(Id=7,Name="Campagna"),(Id=8,Name="Avidita'"),(Id=9,Name="Tradimento"),(Id=6,Name="Personalizzazione")))
   LocalizedSettingsMappings(1)=(Name="BotSkill",ColumnHeaderText="Abilità bot",ValueMappings=((Id=1,Name="Novizio"),(Id=2,Name="Normale"),(Id=3,Name="Pratico"),(Id=4,Name="Specialista"),(Id=5,Name="Esperto"),(Id=6,Name="Magistrale"),(Id=7,Name="Inumano"),(Id=8,Name="Divino")))
   LocalizedSettingsMappings(2)=(Id=1,Name="MapName",ColumnHeaderText="Mappa",ValueMappings=((Name="Personalizzazione")))
   LocalizedSettingsMappings(3)=(Id=6,Name="PureServer",ColumnHeaderText="Puro",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(4)=(Id=7,Name="LockedServer",ColumnHeaderText="Bloccato",ValueMappings=((Name="0"),(Id=1,Name="1")))
   LocalizedSettingsMappings(5)=(Id=8,Name="VsBots",ColumnHeaderText="Contro i Bot",ValueMappings=((Name="Disabilitato"),(Id=2,Name="1:1"),(Id=3,Name="3:2"),(Id=4,Name="2:1")))
   LocalizedSettingsMappings(6)=(Id=9,Name="Campaign",ColumnHeaderText="Campagna",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(7)=(Id=10,Name="ForceRespawn",ColumnHeaderText="Rigenerazione forzata",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(8)=(Id=11,Name="AllowKeyboard",ColumnHeaderText="M/KB",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(9)=(Id=12,Name="IsFullServer",ColumnHeaderText="Intero",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(10)=(Id=13,Name="IsEmptyServer",ColumnHeaderText="Vuoto",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(11)=(Id=14,Name="IsDedicated",ColumnHeaderText="Specializzato",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   PropertyMappings(0)=(Id=1073741825,Name="CustomMapName",ColumnHeaderText="Mappa")
   PropertyMappings(1)=(Id=1073741826,Name="CustomGameMode",ColumnHeaderText="Partita")
   PropertyMappings(2)=(Id=268435704,Name="GoalScore",ColumnHeaderText="Punteggio",MappingType=PVMT_PredefinedValues,PredefinedValues=((Type=SDT_Int32),(Type=SDT_Int32,Value1=5),(Type=SDT_Int32,Value1=10),(Type=SDT_Int32,Value1=15),(Type=SDT_Int32,Value1=20),(Type=SDT_Int32,Value1=25),(Type=SDT_Int32,Value1=30),(Type=SDT_Int32,Value1=35),(Type=SDT_Int32,Value1=40),(Type=SDT_Int32,Value1=45),(Type=SDT_Int32,Value1=50),(Type=SDT_Int32,Value1=55),(Type=SDT_Int32,Value1=60),(Type=SDT_Int32,Value1=70),(Type=SDT_Int32,Value1=80),(Type=SDT_Int32,Value1=90),(Type=SDT_Int32,Value1=100),(Type=SDT_Int32,Value1=125),(Type=SDT_Int32,Value1=150)))
   PropertyMappings(3)=(Id=268435705,Name="TimeLimit",ColumnHeaderText="Tempo Limite",MappingType=PVMT_PredefinedValues,PredefinedValues=((Type=SDT_Int32),(Type=SDT_Int32,Value1=5),(Type=SDT_Int32,Value1=10),(Type=SDT_Int32,Value1=15),(Type=SDT_Int32,Value1=20),(Type=SDT_Int32,Value1=30),(Type=SDT_Int32,Value1=45),(Type=SDT_Int32,Value1=60)))
   PropertyMappings(4)=(Id=268435703,Name="NumBots",ColumnHeaderText="Bots",MappingType=PVMT_PredefinedValues,PredefinedValues=((Type=SDT_Int32),(Type=SDT_Int32,Value1=1),(Type=SDT_Int32,Value1=2),(Type=SDT_Int32,Value1=3),(Type=SDT_Int32,Value1=4),(Type=SDT_Int32,Value1=5),(Type=SDT_Int32,Value1=6),(Type=SDT_Int32,Value1=7),(Type=SDT_Int32,Value1=8),(Type=SDT_Int32,Value1=9),(Type=SDT_Int32,Value1=10),(Type=SDT_Int32,Value1=11),(Type=SDT_Int32,Value1=12),(Type=SDT_Int32,Value1=13),(Type=SDT_Int32,Value1=14),(Type=SDT_Int32,Value1=15),(Type=SDT_Int32,Value1=16)))
   PropertyMappings(5)=(Id=1073741827,Name="ServerDescription",ColumnHeaderText="Descrizione server")
   PropertyMappings(6)=(Id=268435717,Name="OfficialMutators",ColumnHeaderText="Mutatori")
   PropertyMappings(7)=(Id=1073741828,Name="CustomMutators")
   PropertyMappings(8)=(Id=1073741829,Name="CustomMutClasses")
   PropertyMappings(9)=(Id=268435706,Name="NumBotsIA",ColumnHeaderText="Bots",MappingType=PVMT_PredefinedValues,PredefinedValues=((Type=SDT_Int32),(Type=SDT_Int32,Value1=1),(Type=SDT_Int32,Value1=2),(Type=SDT_Int32,Value1=3),(Type=SDT_Int32,Value1=4),(Type=SDT_Int32,Value1=5),(Type=SDT_Int32,Value1=6),(Type=SDT_Int32,Value1=7),(Type=SDT_Int32,Value1=8),(Type=SDT_Int32,Value1=9),(Type=SDT_Int32,Value1=10),(Type=SDT_Int32,Value1=11),(Type=SDT_Int32,Value1=12),(Type=SDT_Int32,Value1=13),(Type=SDT_Int32,Value1=14),(Type=SDT_Int32,Value1=15),(Type=SDT_Int32,Value1=16)))
   PropertyMappings(10)=(Id=268435968,Name="SteamID")
   PropertyMappings(11)=(Id=268435969,Name="SteamVAC")
   Name="Default__UTGameSettingsCommon"
   ObjectArchetype=OnlineGameSettings'Engine.Default__OnlineGameSettings'
}
