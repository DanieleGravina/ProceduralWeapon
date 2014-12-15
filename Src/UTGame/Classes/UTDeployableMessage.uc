/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDeployableMessage extends UTLocalMessage;

/** message given to player when deploying fails, etc */
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

defaultproperties
{
   MessageText(0)="Non puoi piazzare qui questo schieramento."
   MessageArea=2
   bIsPartiallyUnique=True
   DrawColor=(B=128,G=255,R=255,A=255)
   FontSize=2
   Name="Default__UTDeployableMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
