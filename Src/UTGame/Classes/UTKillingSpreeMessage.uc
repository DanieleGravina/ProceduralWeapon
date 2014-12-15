/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//
// Switch is the note.
// RelatedPRI_1 is the player on the spree.
//
class UTKillingSpreeMessage extends UTLocalMessage;

var	localized string EndSpreeNote, EndSelfSpree, EndFemaleSpree, MultiKillString;
var	localized string SpreeNote[6];
var	localized string SelfSpreeNote[6];
var SoundNodeWave SpreeSound[6];
var	localized string EndSpreeNoteTrailer;

static function int GetFontSize( int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer )
{
	local Pawn ViewPawn;
	local int Size;

	if ( RelatedPRI2 == None )
	{
		Size = Default.FontSize;

		// If this is regarding the local player, then increase the size to make it more visible
		if ( LocalPlayer == RelatedPRI1 )
		{
			Size = (Switch > 3) ? 4 : 3;
		}
		else if ( (LocalPlayer != None) && LocalPlayer.bOnlySpectator )
		{
			ViewPawn = Pawn(PlayerController(LocalPlayer.Owner).ViewTarget);
			if ( (ViewPawn != None) && (ViewPawn.PlayerReplicationInfo == RelatedPRI1) )
			{
				Size = 3;
			}
		}
		return size;
	}
	return Default.FontSize;
}

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	if (RelatedPRI_2 == None)
	{
		if ( bPRI1HUD )
			return Default.SelfSpreeNote[Switch];
		if (RelatedPRI_1 == None)
			return "";

		if (RelatedPRI_1.GetPlayerAlias() != "")
			return RelatedPRI_1.GetPlayerAlias()@Default.SpreeNote[Switch];
	}
	else
	{
		if (RelatedPRI_1 == None)
		{
			if (RelatedPRI_2.GetPlayerAlias() != "")
			{
				if ( RelatedPRI_2.bIsFemale )
					return RelatedPRI_2.GetPlayerAlias()@Default.EndFemaleSpree;
				else
					return RelatedPRI_2.GetPlayerAlias()@Default.EndSelfSpree;
			}
		}
		else
		{
			return RelatedPRI_1.GetPlayerAlias()$Default.EndSpreeNote@RelatedPRI_2.GetPlayerAlias()@Default.EndSpreeNoteTrailer;
		}
	}
	return "";
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

	if (RelatedPRI_2 != None)
		return;

	if ( (RelatedPRI_1 == P.PlayerReplicationInfo)
		|| (P.PlayerReplicationInfo.bOnlySpectator && (Pawn(P.ViewTarget) != None) && (Pawn(P.ViewTarget).PlayerReplicationInfo == RelatedPRI_1)) )
	{
		UTPlayerController(P).PlayAnnouncement(default.class,Switch );
		if ( Switch == 0 )
			UTPlayerController(P).ClientMusicEvent(8);
		else
			UTPlayerController(P).ClientMusicEvent(10);
	}
	else
		P.PlayBeepSound();
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return Default.SpreeSound[MessageIndex];
}

defaultproperties
{
   EndSpreeNote=" ha terminato la sua furia omicida a causa di"
   EndSelfSpree="ha terminato il suo raptus."
   EndFemaleSpree="ha terminato il suo raptus."
   SpreeNote(0)="ha un raptus omicida!"
   SpreeNote(1)="è fuori di sé!"
   SpreeNote(2)="sta dominando!"
   SpreeNote(3)="è implacabile!"
   SpreeNote(4)="è divino!"
   SpreeNote(5)="sta facendo un MASSACRO!"
   SelfSpreeNote(0)="Raptus Omicida!"
   SelfSpreeNote(1)="Furia!"
   SelfSpreeNote(2)="Sto dominando!"
   SelfSpreeNote(3)="Implacabile!"
   SelfSpreeNote(4)="DIVINO!"
   SelfSpreeNote(5)="MASSACRO!"
   SpreeSound(0)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_KillingSpree'
   SpreeSound(1)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Rampage'
   SpreeSound(2)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Dominating'
   SpreeSound(3)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_UnStoppable'
   SpreeSound(4)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_GodLike'
   SpreeSound(5)=SoundNodeWave'A_Announcer_Reward.Rewards.A_RewardAnnouncer_Massacre'
   MessageArea=3
   AnnouncementPriority=7
   FontSize=1
   Name="Default__UTKillingSpreeMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
