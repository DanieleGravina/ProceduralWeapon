/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWarfareBarricadeMessage extends UTLocalMessage
	abstract;

var localized string CantAttackMessage;

static function string GetString(
	optional int Switch,
	optional bool bPRI1HUD,
	optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
	return Default.CantAttackMessage;
}

defaultproperties
{
   CantAttackMessage="La barricata non puo essere distrutta da armi convenzionali."
   MessageArea=2
   bIsPartiallyUnique=True
   FontSize=1
   Name="Default__UTWarfareBarricadeMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
