/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * This class holds the game modes and leaderboard time line filters
 */
class UTLeaderboardSettings extends Settings
	native;

enum ELeaderboardFilters
{
	LF_GameMode,
	LF_MatchType,
	LF_PlayerFilterType
};

enum EMatchTypeSettings
{
	MTS_Ranked,
	MTS_Player
};

enum EPlayerFilterSettings
{
	PFS_Player,
	PFS_CenteredOnPlayer,
	PFS_Friends,
	PFS_TopRankings
};

/**
 * Moves to the next value index for the specified setting, wraps around to the first element if it hits zero.
 *
 * @param SettingId	SettingId to move to the next value.
 */
function MoveToNextSettingValue(int SettingId)
{
	local int CurrentValueIndex;
	local int TotalValues;

	if(GetStringSettingValue(SettingId, CurrentValueIndex))
	{
		TotalValues = LocalizedSettingsMappings[SettingId].ValueMappings.length;
		SetStringSettingValue(SettingId, (CurrentValueIndex+1)%TotalValues, false);
	}
}

defaultproperties
{
   LocalizedSettings(0)=
   LocalizedSettings(1)=(Id=1)
   LocalizedSettings(2)=(Id=2,ValueIndex=2)
   LocalizedSettingsMappings(0)=(Name="GameMode",ColumnHeaderText="GameModes",ValueMappings=((Name="Deathmatch"),(Id=4,Name="Deathmatch a squadre"),(Id=5,Name="Duello"),(Id=1,Name="Cattura La Bandiera"),(Id=3,Name="Veicolo CLB"),(Id=2,Name="Warfare"),(Name="Greed"),(Name="Betrayal")))
   LocalizedSettingsMappings(1)=(Id=1,Name="MatchType",ColumnHeaderText="MatchTypes",ValueMappings=((Name="Server Puro"),(Id=1,Name="Server Speciale")))
   LocalizedSettingsMappings(2)=(Id=2,Name="PlayerFilter",ColumnHeaderText="Filtri giocatore",ValueMappings=((Name="Giocatore"),(Id=1,Name="Centrato sul giocatore"),(Id=2,Name="Solo amici"),(Id=3,Name="Migliori classificati")))
   Name="Default__UTLeaderboardSettings"
   ObjectArchetype=Settings'Engine.Default__Settings'
}
