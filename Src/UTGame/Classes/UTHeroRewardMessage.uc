/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTHeroRewardMessage extends UTLocalMessage;

var localized string JuggernautString;

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return Default.JuggernautString;
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

	UTPlayerController(P).PlayAnnouncement(default.class, 0);
	UTPlayerController(P).ClientMusicEvent(6);
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Juggernaut';
}

defaultproperties
{
   JuggernautString="JUGGERNAUT"
   MessageArea=3
   AnnouncementPriority=5
   DrawColor=(B=0,G=0,R=255,A=255)
   FontSize=2
   Name="Default__UTHeroRewardMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
