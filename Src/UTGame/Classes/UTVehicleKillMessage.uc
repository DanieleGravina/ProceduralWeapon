/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleKillMessage extends UTLocalMessage;

var localized string KillString[8];
var SoundNodeWave KillSounds[8];

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return Default.KillString[Min(Switch,7)];
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
	UTPlayerController(P).PlayAnnouncement(default.class, Min(Switch,7));
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return Default.KillSounds[MessageIndex];
}

defaultproperties
{
   KillString(0)="Uccisione stradale!"
   KillString(1)="Colpisci e fuggi!"
   KillString(2)="Furia stradale!"
   KillString(3)="Killer della strada!"
   KillString(4)="Frittella!"
   KillString(5)="Vista Aquila!"
   KillString(6)="Top Gun!"
   KillString(7)="Infuriato!"
   KillSounds(0)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Roadkill'
   KillSounds(1)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_HitAndRun'
   KillSounds(2)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_RoadRage'
   KillSounds(3)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_VehicularManslaughter'
   KillSounds(4)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Pancake'
   KillSounds(5)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_EagleEye'
   KillSounds(6)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_TopGun'
   KillSounds(7)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_RoadRampage'
   MessageArea=3
   AnnouncementPriority=10
   bIsUnique=True
   DrawColor=(B=0,G=0,R=255,A=255)
   FontSize=2
   Name="Default__UTVehicleKillMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
