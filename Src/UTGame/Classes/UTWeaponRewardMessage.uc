/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWeaponRewardMessage extends UTLocalMessage;

var	localized string 	RewardString[11];
var SoundNodeWave RewardSounds[11];

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return Default.RewardString[Switch];
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
	UTPlayerController(P).PlayAnnouncement(default.class, Switch);
	UTPlayerController(P).ClientMusicEvent(6);
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return Default.RewardSounds[MessageIndex];
}

defaultproperties
{
   RewardString(1)="Maestro Flak!"
   RewardString(2)="Cacciatore di teste!"
   RewardString(3)="Re de combo!"
   RewardString(4)="Rischio Biologico!"
   RewardString(5)="Martello pneumatico!"
   RewardString(6)="Maestro di lance!"
   RewardString(7)="Pistolero!"
   RewardString(8)="Cacciatore di Animali di Grossa Taglia!"
   RewardString(9)="Raggio Blu!"
   RewardString(10)="Scienziato di Missilistica!"
   RewardSounds(1)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_FlakMaster'
   RewardSounds(2)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_HeadHunter'
   RewardSounds(3)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_ComboKing'
   RewardSounds(4)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Biohazard'
   RewardSounds(5)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_JackHammer'
   RewardSounds(6)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_ShaftMaster'
   RewardSounds(7)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Gunslinger'
   RewardSounds(8)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_BigGameHunter'
   RewardSounds(9)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_BlueStreak'
   RewardSounds(10)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_RocketScientist'
   MessageArea=3
   AnnouncementPriority=6
   bIsUnique=True
   DrawColor=(B=128,G=255,R=255,A=255)
   FontSize=2
   Name="Default__UTWeaponRewardMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
