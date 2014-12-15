/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGreedMessage extends UTLocalMessage;

var localized array<string>	MessageText;
var SoundNodeWave AnnouncementSounds[2];

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return Default.MessageText[Switch];
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

	if ( Switch == 1 )
	{
	UTPlayerController(P).PlayAnnouncement(default.class,Switch );
	}

	if ( P.PlayerReplicationInfo == RelatedPRI_1 )
		UTPlayerController(P).ClientMusicEvent(2);
	else
		UTPlayerController(P).ClientMusicEvent(10);
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return Default.AnnouncementSounds[MessageIndex];
}

defaultproperties
{
   AnnouncementSounds(1)=SoundNodeWave'A_Announcer_UT3G.Rewards.A_RewardAnnouncer_Rejected'
   MessageArea=2
   AnnouncementPriority=12
   bIsUnique=True
   FontSize=2
   Name="Default__UTGreedMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
