/**
 * Dataprovider that returns a row for each available content package.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTUIDataProvider_AvailableContent extends UTUIDataProvider_SimpleElementProvider
	native(UI);

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

/** Struct that defines a content package */
struct native AvailableContentPackage
{
	var string ContentName;
	var string ContentFriendlyName;
	var string ContentDescription;
};
var transient array<AvailableContentPackage> Packages;

/** all of the achievements possible **/
struct native AchievementUIInfo
{
	var int ID;
	var bool bIsCollapsable; /** can this be expanded/collapsed **/
	var bool bIsExpanded;
	var string Name;
	var string HowTo;       /** markup for how to complete the award **/
	var string ProgressStr; /** markup for progress text **/
	var string IconStr;     /** markup for award icon **/
	var UIRoot.TextureCoordinates IconCoordinates;
};

struct native AchievementParent
{
	var AchievementUIInfo Achievement;
	var array<AchievementUIInfo> SubAchievements;
};

var transient array<AchievementParent> AllAchievements;
var transient array<Pointer> CurrentAchievementView {FAchievementUIInfo};

struct native GameModeMapping
{
	var int GameModeID;	 //ID from PBD for gamemode/achievement map
	var string GameModeClassName; //Classname of game mode
	var string MarkupStr; //Markup for new icons
};

var transient array<GameModeMapping> GameModeMappings;

struct native MutatorMapping
{
	var int MutatorBit;	//ID from PBD for mutator bit
	var string MutatorClassName;
};   

var transient array<MutatorMapping> MutatorMappings;

struct native VehicleMapping
{
	var int VehicleIndex;  //ID from PBD for vehicle index
	var string VehicleName;
};	

var transient array<VehicleMapping> VehicleMappings;

/** @return Returns the number of elements(rows) provided. */
native function int GetElementCount();

/** Parses a string for downloadable content. */
native function ParseContentString(string ContentStr);

/** Recreate the data store given an index to collapse */
native function ToggleCollapse(int CurrentIndex);

/**
* GetMatchingProfileId
*/
function int GetMatchingProfileId( UTProfileSettings Profile, int MatchingId )
{
	local int Index;

	for (Index=0; Index<Profile.AchievementsArray.Length; Index++)
	{
		if (Profile.AchievementsArray[Index].Id == MatchingId)
		{
			return Index;
		}
	}

	return 0;
}

/** Return the byte value within a dword **/
function int GetByteValue( int value, int index )
{
	local int ByteMask;
	local int MaskedValue;

	ByteMask = 255 << (index * 8);

	MaskedValue = value & ByteMask;
	MaskedValue = MaskedValue >> (index * 8);

	return MaskedValue;
}

/** Count the number of bits on a value **/
function int CountBits( int value )
{
	local int CheckValue;
	local int BitCount;

	CheckValue = value;

	BitCount = 0;

	while (CheckValue > 0)
	{
		if ( (CheckValue & 1) > 0 )
		{
			++BitCount;
		}
		CheckValue = CheckValue >> 1;
	}

	return BitCount;
}

function string ConvertSecondsToString(int NumSeconds) 
{
	local int NumMinutes;
	local string TimeString;

	NumSeconds = Clamp(NumSeconds, 0, 59 * 60 + 59); //Clamp to 59:59

	if (NumSeconds > 0)
	{
		//Slice up the seconds
		NumMinutes = NumSeconds / 60;
		NumSeconds = NumSeconds % 60;
	}

	if (NumMinutes < 10)
	{
	   TimeString = "0" $ NumMinutes;
	}
	else
	{
		TimeString = string(NumMinutes);
	}

	TimeString $= ":";

	if (NumSeconds < 10)
	{
		TimeString $= "0" $ NumSeconds;
	}
	else
	{
		TimeString $= string(NumSeconds);
	}

	return TimeString;
}

/**
* Setup the Achievement list that details the player's progress
*
* @param PC Current scene player controller
*/
function SetupAchievementList( UTPlayerController PC )
{
	local int i, j;
	local UTProfileSettings Profile;
	local OnlineSubsystem OnlineSub;
	local MapContextMapping AMapContext;
	local OnlinePlayerInterfaceEx PlayerIntEx;
	local int CurrentValue;
	local int UnlockType;
	local int UnlockCriteria;
	local int AchievementID;
	local AchievementUIInfo SubAchievement;
	local string ProgressText;
	local int ByteCurrentValue;
	local int ByteCriteriaValue;
	local int ByteIndex;
	local int ProfileArrayIndex;
	local int MixItUpIndex;

	//Stores of game and map info (expensive to get, so cache here)
	local array<UTUIResourceDataProvider> GameTypeProviderList;
	local array<UTUIResourceDataProvider> MapNameProviderList;
	local array<UTUIResourceDataProvider> MutatorProviderList;

	// Check the profile for the "uncleared" achievements and build a list
	// that displays the progress
	Profile = UTProfileSettings(PC.OnlinePlayerData.ProfileProvider.Profile);
	if ( Profile != none )
	{
		// Get the player interface
		OnlineSub = class'GameEngine'.static.GetOnlineSubsystem();
		if (OnlineSub != None)
		{
			PlayerIntEx = OnlineSub.PlayerInterfaceEx;
		}

		//Get a listing of all the gametypes
		class'UTUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_GameModeInfo', GameTypeProviderList);

		//Get a listing of all maps
		class'UTUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_MapInfo', MapNameProviderList);

		//Get a listing of all mutators
		class'UTUIDataStore_MenuItems'.static.GetAllResourceDataProviders(class'UTUIDataProvider_Mutator', MutatorProviderList);

		// Fill in the progress text for each achievement for this player
		for (i = 0; i < AllAchievements.length; i++)
		{
			AchievementID = AllAchievements[i].Achievement.ID;
			AllAchievements[i].Achievement.IconStr = "<Images:UI_Frontend_Art3.Icons.Achievements;";

			//Clear the dynamic elements of the list
			AllAchievements[i].Achievement.ProgressStr = "";
			AllAchievements[i].SubAchievements.length = 0;

			SubAchievement.IconCoordinates.U = 0;
			SubAchievement.IconCoordinates.UL = 0;
			SubAchievement.IconCoordinates.V = 0;
			SubAchievement.IconCoordinates.VL = 0;
			
			if (PlayerIntEx != None && PlayerIntEx.IsAchievementUnlocked(AchievementId) == true)
			{
				ProgressText = Localize( "MidGameMenu", "Completed", "UTGameUI" );
				AllAchievements[i].Achievement.bIsCollapsable = false;
			}
			else
			{
				ProfileArrayIndex = GetMatchingProfileId( Profile, AchievementId );

				UnlockType = Profile.AchievementsArray[ProfileArrayIndex].UnlockType;
				UnlockCriteria = Profile.AchievementsArray[ProfileArrayIndex].UnlockCriteria;

				if ( UnlockType == EUnlockType_Count )
				{
					// Get the current achievement value
					if (Profile.GetAchievementValue(AchievementID, CurrentValue) == FALSE)
					{
						// Failed... so just set it 0
						LogInternal("Achievement"@AchievementID@"failed to find a value");
						CurrentValue = 0;
					}

					// These achievements are in seconds, so just convert the values to minutes
					if ( AchievementID == EUTA_POWERUP_SeeingRed ||
						AchievementID == EUTA_POWERUP_NeverSawItComing ||
						AchievementID == EUTA_POWERUP_SurvivalFittest ||
						AchievementID == EUTA_POWERUP_DeliveringTheHurt ||
						AchievementID == EUTA_UT3GOLD_TheSlowLane)
					{
						ProgressText = ConvertSecondsToString(Clamp(CurrentValue,0,UnlockCriteria)) $ " / " $ ConvertSecondsToString(UnlockCriteria);
					}
					else
					{
						// Build a string and add it the progress string array 
						if (UnlockCriteria == 1)
						{
							if (CurrentValue == 0)
							{
								ProgressText = Localize( "MidGameMenu", "Incomplete", "UTGameUI" );
							}
							else
							{
								ProgressText = Localize( "MidGameMenu", "Completed", "UTGameUI" );
							}
						}
						else
						{
							ProgressText = Clamp(CurrentValue,0,UnlockCriteria) $ " / " $ UnlockCriteria;
						}
					}
				}
				else if ( UnlockType == EUnlockType_Bitmask )
				{
					// These have to be handled specially because they are 64 bit fields.
					if ( AchievementID == EUTA_VERSUS_AroundTheWorld ||
						AchievementID == EUTA_EXPLORE_AllPowerups )
					{
						//Count up the maps (safer)
						UnlockCriteria = 0;
					    AllAchievements[i].Achievement.bIsCollapsable = true;

						for (j=0; j<class'UTGame'.default.MapContexts.length; j++)
						{
							AMapContext = class'UTGame'.default.MapContexts[j];
							if (AMapContext.bIsValidAchievementMap)
							{
								UnlockCriteria++;
								if (!GetMapNameAndMarkup(MapNameProviderList, AMapContext.MapName, SubAchievement.Name, SubAchievement.IconStr))
								{
									SubAchievement.Name = "[" $ Localize("Extras", "HiddenAchievement2", "UTGameUI") $ "]";
									SubAchievement.HowTo = Localize("Extras", "HiddenAchievement2Desc", "UTGameUI");
									// use the generic icon
									SubAchievement.IconStr = AllAchievements[i].Achievement.IconStr;
									SubAchievement.IconCoordinates = AllAchievements[i].Achievement.IconCoordinates;
								}
								else
								{
									SubAchievement.HowTo = AllAchievements[i].Achievement.HowTo;
								}

								SubAchievement.Name = "    " $ SubAchievement.Name;

								if (AchievementID == EUTA_EXPLORE_AllPowerups)
								{
									if (Profile.CheckLikeTheBackOfMyHandMap(AMapContext.MapContextId))
									{
										SubAchievement.ProgressStr = Localize( "MidGameMenu", "Completed", "UTGameUI" );
									}
									else
									{
										SubAchievement.ProgressStr = Localize( "MidGameMenu", "Incomplete", "UTGameUI" );
									}
								}
								else if (AchievementID == EUTA_VERSUS_AroundTheWorld)
								{
									if (Profile.CheckAroundTheWorldMap(AMapContext.MapContextId))
									{
										SubAchievement.ProgressStr = Localize( "MidGameMenu", "Completed", "UTGameUI" );
									}
									else
									{
										SubAchievement.ProgressStr = Localize( "MidGameMenu", "Incomplete", "UTGameUI" );
									}
								}

								AllAchievements[i].SubAchievements.AddItem(SubAchievement);
							}
						}

						ProgressText = Profile.CountBits64InAchivementValue(AchievementID)@"/"@UnlockCriteria;
					}
					else
					{
						// Get the current achievement value
						if ( Profile.GetAchievementValue(AchievementID, CurrentValue) == FALSE )
						{
							// Failed... so just set it 0
							CurrentValue = 0;
						}

						//Mask the current value against the unlock criteria so we don't count too much
						ProgressText = CountBits(CurrentValue & UnlockCriteria) $ " / " $ CountBits(UnlockCriteria);

						if (AchievementID == EUTA_IA_EveryGameMode || AchievementID == EUTA_VERSUS_GetItOn)
						{
							 AllAchievements[i].Achievement.bIsCollapsable = true;
							for (j=0; j<GameModeMappings.length; j++)
							{
								if (!GetGameModeName(GameTypeProviderList, GameModeMappings[j].GameModeClassName, SubAchievement.Name))
								{
									// if the game wasn't found, then it's a bonus pack map
									SubAchievement.Name = "[" $ Localize("Extras", "HiddenAchievement2", "UTGameUI") $ "]";
									SubAchievement.HowTo = Localize("Extras", "HiddenAchievement2Desc", "UTGameUI");

									// use the generic icon
									SubAchievement.IconStr = AllAchievements[i].Achievement.IconStr;
									SubAchievement.IconCoordinates = AllAchievements[i].Achievement.IconCoordinates;
								}
								else
								{
									SubAchievement.IconStr = GameModeMappings[j].MarkupStr;
									SubAchievement.HowTo = AllAchievements[i].Achievement.HowTo;
								}

								SubAchievement.Name = "    " $ SubAchievement.Name;

								//From PBD index in code
								if (AchievementID == EUTA_IA_EveryGameMode)
									MixItUpIndex = 1;
								else if (AchievementID == EUTA_VERSUS_GetItOn)
									MixItUpIndex = 2;

								if (Profile.CheckMixItUp(GameModeMappings[j].GameModeID, MixItUpIndex))
								{
									SubAchievement.ProgressStr = Localize( "MidGameMenu", "Completed", "UTGameUI" );
								}
								else
								{
									SubAchievement.ProgressStr = Localize( "MidGameMenu", "Incomplete", "UTGameUI" );
								}

								AllAchievements[i].SubAchievements.AddItem(SubAchievement);
							}
						}
						else if (AchievementID == EUTA_EXPLORE_EveryMutator)
						{
							AllAchievements[i].Achievement.bIsCollapsable = true;
							for (j=0; j<MutatorMappings.length; j++)
							{
								if (!GetMutatorName(MutatorProviderList, MutatorMappings[j].MutatorClassName, SubAchievement.Name))
								{
									// if the mutator wasn't found, then it's a bonus pack map
									SubAchievement.Name = "[" $ Localize("Extras", "HiddenAchievement2", "UTGameUI") $ "]";
									SubAchievement.HowTo = Localize("Extras", "HiddenAchievement2Desc", "UTGameUI");

									// use the generic icon
									SubAchievement.IconStr = AllAchievements[i].Achievement.IconStr;
									SubAchievement.IconCoordinates = AllAchievements[i].Achievement.IconCoordinates;
								}
								else
								{
									SubAchievement.IconStr = AllAchievements[i].Achievement.IconStr; 
									SubAchievement.HowTo = AllAchievements[i].Achievement.HowTo;
									SubAchievement.IconCoordinates = AllAchievements[i].Achievement.IconCoordinates;
								}

								SubAchievement.Name = "    " $ SubAchievement.Name;

								if (Profile.CheckSpiceOfLifeBitmask(MutatorMappings[j].MutatorBit))
								{
									SubAchievement.ProgressStr = Localize( "MidGameMenu", "Completed", "UTGameUI" );
								}
								else
								{
									SubAchievement.ProgressStr = Localize( "MidGameMenu", "Incomplete", "UTGameUI" );
								}

								AllAchievements[i].SubAchievements.AddItem(SubAchievement);
							}
						}
						else if (AchievementID == EUTA_VEHICLE_JackOfAllTrades)
						{
							AllAchievements[i].Achievement.bIsCollapsable = true;
							for (j=0; j<VehicleMappings.length; j++)
							{
								GetVehicleName(VehicleMappings[j].VehicleName, SubAchievement.Name);

								SubAchievement.Name = "    " $ SubAchievement.Name;
								SubAchievement.IconStr = AllAchievements[i].Achievement.IconStr;
								SubAchievement.HowTo = AllAchievements[i].Achievement.HowTo;
								SubAchievement.IconCoordinates = AllAchievements[i].Achievement.IconCoordinates;

								if (Profile.CheckJackOfAllTradesBitmask(VehicleMappings[j].VehicleIndex))
								{
									SubAchievement.ProgressStr = Localize( "MidGameMenu", "Completed", "UTGameUI" );
								}
								else
								{
									SubAchievement.ProgressStr = Localize( "MidGameMenu", "Incomplete", "UTGameUI" );
								}

								AllAchievements[i].SubAchievements.AddItem(SubAchievement);
							}
						}
					}
				}
				else if ( UnlockType == EUnlockType_ByteCount )
				{
					// Get the current achievement value
					if (Profile.GetAchievementValue(AchievementID, CurrentValue) == FALSE)
					{
						// Failed... so just set it 0
						CurrentValue = 0;
					}

					// Only display the least significant for 'Get A Life' Achievement
					if ( AchievementID == EUTA_VERSUS_GetALife )
					{
						ByteCriteriaValue = GetByteValue( UnlockCriteria, 0 );
						ByteCurrentValue = GetByteValue( CurrentValue, 0 );
						ProgressText = Clamp(ByteCurrentValue, 0, ByteCriteriaValue) $ " / " $ ByteCriteriaValue;					
					}
					// Run through the bytes and display any that are non-zero
					else
					{
						for (ByteIndex = 0; ByteIndex < 4; ByteIndex++)
						{
							ByteCriteriaValue = GetByteValue( UnlockCriteria, ByteIndex );

							if ( ByteCriteriaValue > 0 )
							{
								ByteCurrentValue = GetByteValue( CurrentValue, ByteIndex );
								if (ByteIndex == 0)
								{
									ProgressText = Clamp(ByteCurrentValue, 0, ByteCriteriaValue) $ " / " $ ByteCriteriaValue;
								}
								else
								{
									ProgressText = ProgressText $ ", ";
									ProgressText = ProgressText $ Clamp(ByteCurrentValue, 0, ByteCriteriaValue) $ " / " $ ByteCriteriaValue;
								}
							}
						}
					}
				}
			}

			AllAchievements[i].Achievement.ProgressStr = ProgressText;
		}

		//Populate the list the first time
		ToggleCollapse(-1);
	}
}

function bool GetMapNameAndMarkup(out array<UTUIResourceDataProvider> ProviderList, string MapName, out string NewMapName, out string Markup)
{
	local int i;
	local UTUIDataProvider_MapInfo MapProvider;

	for (i = 0; i < ProviderList.length; i++)
	{
		MapProvider = UTUIDataProvider_MapInfo(ProviderList[i]);
		if (MapName ~= MapProvider.MapName)
		{
			NewMapName = MapProvider.FriendlyName;
			Markup = MapProvider.PreviewImageMarkup;
			return true;
		}
	}   

	return false;
}

function bool GetGameModeName(out array<UTUIResourceDataProvider> ProviderList, string GameModeClassName, out string FriendlyName)
{
	local int i;
	local UTUIDataProvider_GameModeInfo GameProvider;

	FriendlyName = "";
	for (i = 0; i < ProviderList.length; i++)
	{						
		GameProvider = UTUIDataProvider_GameModeInfo(ProviderList[i]);
		if (InStr(GameProvider.GameMode, GameModeClassName) >= 0)
		{
			FriendlyName = GameProvider.FriendlyName;
			return true;
		}
	}

	return false;
}

function bool GetMutatorName(out array<UTUIResourceDataProvider> ProviderList, string MutatorClassName, out string FriendlyName)
{
	local int i;
	local UTUIDataProvider_Mutator MutProvider;

	for (i = 0; i < ProviderList.length; i++)
	{						
		MutProvider = UTUIDataProvider_Mutator(ProviderList[i]);
		if (InStr(MutProvider.ClassName, MutatorClassName) >= 0)
		{
			FriendlyName = MutProvider.FriendlyName;
			return true;
		}
	}

	return false;
}

function GetVehicleName(string VehicleClassName, out string FriendlyName)
{
	FriendlyName = Localize(VehicleClassName, "VehicleNameString", "UTGame");
}

defaultproperties
{
   Name="Default__UTUIDataProvider_AvailableContent"
   ObjectArchetype=UTUIDataProvider_SimpleElementProvider'UTGame.Default__UTUIDataProvider_SimpleElementProvider'
}
