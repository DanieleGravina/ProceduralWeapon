/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTKillerMessage extends UTWeaponKillMessage;

var(Message) localized string YouKilled, YouKilledTrailer, YouTeamKilled, YouTeamKilledTrailer;
var(Message) localized string OtherKilledPrefix, OtherKilled, OtherKilledTrailer;

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (RelatedPRI_1 == None || RelatedPRI_2.GetPlayerAlias() == "")
	{
		return "";
	}
	else if (bPRI1HUD)
	{
		return ((RelatedPRI_1.Team == None) || (RelatedPRI_1.Team != RelatedPRI_2.Team))
				? (default.YouKilled @ RelatedPRI_2.GetPlayerAlias() @ default.YouKilledTrailer)
				: (default.YouTeamKilled @ RelatedPRI_2.GetPlayerAlias() @ default.YouTeamKilledTrailer);
	}
	else
	{
		return (default.OtherKilledPrefix @ RelatedPRI_1.GetPlayerAlias() @ default.OtherKilled @ RelatedPRI_2.GetPlayerAlias() @ default.OtherKilledTrailer);
	}
}

defaultproperties
{
   YouKilled="Hai ucciso"
   YouTeamKilled="Hai ucciso una squadra"
   OtherKilled="ucciso"
   bIsUnique=True
   FontSize=2
   Name="Default__UTKillerMessage"
   ObjectArchetype=UTWeaponKillMessage'UTGame.Default__UTWeaponKillMessage'
}
