/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTFirstBloodMessage extends UTLocalMessage;

var localized string FirstBloodString;

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (RelatedPRI_1 == None)
		return "";
	if (RelatedPRI_1.GetPlayerAlias() == "")
		return "";
	return RelatedPRI_1.GetPlayerAlias()@Default.FirstBloodString;
}

static simulated function ClientReceive(
	PlayerController P,
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

	if (RelatedPRI_1 != P.PlayerReplicationInfo)
		return;

	UTPlayerController(P).PlayAnnouncement(default.class, 0);
	UTPlayerController(P).ClientMusicEvent(6);
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_FirstBlood';
}

defaultproperties
{
   FirstBloodString="ha ucciso per primo!"
   MessageArea=3
   AnnouncementPriority=9
   DrawColor=(B=0,G=0,R=255,A=255)
   FontSize=2
   Name="Default__UTFirstBloodMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
