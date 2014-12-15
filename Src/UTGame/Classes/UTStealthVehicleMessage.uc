/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTStealthVehicleMessage extends UTLocalMessage;

var localized array<string>	MessageText;
var SoundCue ErrorSound;

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

	P.ClientPlaySound(default.ErrorSound);
}

defaultproperties
{
   MessageText(0)="Ostacolo blocca piazzamento mina."
   MessageText(1)="Nessuna munizione schieramento disponibile."
   MessageText(2)="Vicinanze di altri mezzi, lo schieramento è impossibile."
   ErrorSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   MessageArea=2
   bIsPartiallyUnique=True
   DrawColor=(B=128,G=255,R=255,A=255)
   FontSize=2
   Name="Default__UTStealthVehicleMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
