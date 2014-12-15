/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDuelMessage extends UTLocalMessage
	abstract;

var SoundNodeWave NextInLineSound;
var localized string NextInLineString;

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return default.NextInLineString;
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
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	return Default.NextInLineSound;
}

defaultproperties
{
   NextInLineSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_YouAreNextInLIne'
   NextInLineString="Sei il prossimo!"
   MessageArea=2
   AnnouncementPriority=8
   bIsUnique=True
   bIsConsoleMessage=True
   DrawColor=(B=0,G=0,R=255,A=255)
   FontSize=3
   Name="Default__UTDuelMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
