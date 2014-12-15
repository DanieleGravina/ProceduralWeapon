/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtHUDMessage extends UTLocalMessage;

// Switch 0: You have the flag message.

var(Message) localized string OnslaughtHUDString[3];

var(Message) color RedColor, YellowColor;

static function color GetColor(
	optional int Switch,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return (Switch == 1) ? default.RedColor : default.YellowColor;
}

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	Return Default.OnslaughtHUDString[Switch];
}

static function bool AddAnnouncement(UTAnnouncer Announcer, int MessageIndex, optional PlayerReplicationInfo PRI, optional Object OptionalObject) {}

defaultproperties
{
   OnslaughtHUDString(0)="Hai la sfera, portala a un Nodo!"
   OnslaughtHUDString(1)="Portatore sfera nemico vicino a Nodo!"
   OnslaughtHUDString(2)="La tua sfera sta chiudendo il Nodo!"
   RedColor=(B=0,G=0,R=255,A=255)
   YellowColor=(B=0,G=255,R=255,A=255)
   MessageArea=0
   bIsPartiallyUnique=True
   Lifetime=1.000000
   DrawColor=(B=255,G=160,R=0,A=255)
   FontSize=1
   Name="Default__UTOnslaughtHUDMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
