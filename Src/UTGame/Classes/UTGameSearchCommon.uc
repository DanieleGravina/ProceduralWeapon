/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Holds the search items common to all game types.
 */
class UTGameSearchCommon extends OnlineGameSearch
	abstract;










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

#linenumber 11

defaultproperties
{
   MaxSearchResults=1000
   FilterQuery=(OrClauses=((OrParams=((EntryId=32779,EntryType=OGSET_LocalizedSetting))),(OrParams=((EntryId=6,EntryType=OGSET_LocalizedSetting))),(OrParams=((EntryId=7,EntryType=OGSET_LocalizedSetting))),(OrParams=((EntryId=11,EntryType=OGSET_LocalizedSetting))),(OrParams=((EntryId=12,EntryType=OGSET_LocalizedSetting))),(OrParams=((EntryId=13,EntryType=OGSET_LocalizedSetting))),(OrParams=((EntryId=14,EntryType=OGSET_LocalizedSetting)))))
   LocalizedSettings(0)=(Id=32779,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(1)=(Id=6,ValueIndex=2,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(2)=(Id=7,ValueIndex=1,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(3)=(Id=9,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(4)=(Id=11,ValueIndex=2,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(5)=(Id=12,ValueIndex=1,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(6)=(Id=13,ValueIndex=1,AdvertisementType=ODAT_OnlineService)
   LocalizedSettings(7)=(Id=14,AdvertisementType=ODAT_OnlineService)
   LocalizedSettingsMappings(0)=
   LocalizedSettingsMappings(1)=(Id=6,Name="PureServer",ValueMappings=((Name="No"),(Id=1,Name="Sì"),(Id=2,Name="Qualsiasi",bIsWildcard=True)))
   LocalizedSettingsMappings(2)=(Id=7,Name="LockedServer",ValueMappings=((Name="No"),(Id=1,Name="Sì",bIsWildcard=True)))
   LocalizedSettingsMappings(3)=(Id=9,Name="Campaign",ValueMappings=((Name="No"),(Id=1,Name="Sì")))
   LocalizedSettingsMappings(4)=(Id=11,Name="AllowKeyboard",ValueMappings=((Name="No"),(Id=1,Name="Sì"),(Id=2,Name="Qualsiasi",bIsWildcard=True)))
   LocalizedSettingsMappings(5)=(Id=12,Name="ShowFullServers",ValueMappings=((Name="Nascondi"),(Id=1,Name="Mostra",bIsWildcard=True)))
   LocalizedSettingsMappings(6)=(Id=13,Name="ShowEmptyServers",ValueMappings=((Name="Nascondi"),(Id=1,Name="Mostra",bIsWildcard=True)))
   LocalizedSettingsMappings(7)=(Id=14,Name="IsDedicated",ValueMappings=((Name="No",bIsWildcard=True),(Id=1,Name="Sì")))
   Name="Default__UTGameSearchCommon"
   ObjectArchetype=OnlineGameSearch'Engine.Default__OnlineGameSearch'
}
