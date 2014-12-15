/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleMessage extends UTLocalMessage;

var localized array<string> MessageText;

var array<Color> DrawColors;

var array<SoundNodeWave> MessageAnnouncements;

var array<int> CustomMessageArea;



static simulated function ClientReceive(
										PlayerController P,
										optional int Switch,
										optional PlayerReplicationInfo RelatedPRI_1,
										optional PlayerReplicationInfo RelatedPRI_2,
										optional Object OptionalObject
										)
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

	if (default.MessageAnnouncements[Switch] != None)
	{
		UTPlayerController(P).PlayAnnouncement(default.class, Switch);
	}
}


static function byte AnnouncementLevel(byte MessageIndex)
{
	return 2;
}

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


static function color GetColor(
							   optional int Switch,
							   optional PlayerReplicationInfo RelatedPRI_1,
							   optional PlayerReplicationInfo RelatedPRI_2,
								optional Object OptionalObject
							   )
{
	return Default.DrawColors[Switch];
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return default.MessageAnnouncements[MessageIndex];
}

defaultproperties
{
   MessageText(0)="Sistema autodistruzione Viper non ancora attivato."
   MessageText(1)="Il veicolo è Chiuso."
   MessageText(2)="Stai intralciando una rinascita veicolo!"
   MessageText(3)="Leviathan è online."
   MessageText(4)="Dirottato!"
   MessageText(5)="Dirottamento d'auto!"
   DrawColors(0)=(B=128,G=255,R=255,A=255)
   DrawColors(1)=(B=255,G=160,R=0,A=255)
   DrawColors(2)=(B=0,G=0,R=255,A=255)
   DrawColors(3)=(B=0,G=0,R=255,A=255)
   DrawColors(4)=(B=255,G=255,R=255,A=255)
   DrawColors(5)=(B=255,G=255,R=255,A=255)
   MessageAnnouncements(0)=None
   MessageAnnouncements(1)=None
   MessageAnnouncements(2)=None
   MessageAnnouncements(3)=None
   MessageAnnouncements(4)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Hijacked'
   MessageAnnouncements(5)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_CarJacked'
   MessageArea=2
   AnnouncementPriority=5
   bIsPartiallyUnique=True
   FontSize=2
   Name="Default__UTVehicleMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
