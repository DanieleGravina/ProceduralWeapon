/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTSPMAMessage extends UTLocalMessage;

var localized array<string>	MessageText;


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

static function float GetLifeTime(int Switch)
{
	if ( Switch == 1 )
	{
		return 0.75;
	}
    return default.LifeTime;
}

defaultproperties
{
   MessageText(0)="Non posso piazzarla mentre mi muovo."
   MessageText(1)="Premi [FUOCO] per Avvinghiare"
   MessageText(2)="Deve essere piazzata"
   MessageText(3)="Non posso piazzarla con delle ruote instabili"
   MessageText(4)="Premi [FUOCO] per piazzare fotocamera!"
   MessageArea=2
   bIsPartiallyUnique=True
   DrawColor=(B=128,G=255,R=255,A=255)
   FontSize=2
   Name="Default__UTSPMAMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
