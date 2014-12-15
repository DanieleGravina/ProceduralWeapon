/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleCantCarryFlagMessage extends UTLocalMessage;

var localized string FlagMessage;
var SoundNodeWave FlagAnnouncement;
var localized string OrbMessage;
var SoundNodeWave OrbAnnouncement;

static simulated function ClientReceive( PlayerController P, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1,
						optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
	Super.ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

	UTPlayerController(P).PlayAnnouncement(default.class, Switch);
}

static function SoundNodeWave AnnouncementSound(int MessageIndex, Object OptionalObject, PlayerController PC)
{
	if ( (PC.PlayerReplicationInfo != None) && !PC.PlayerReplicationInfo.bHasFlag )
	{
		return None;
	}
	return (MessageIndex == 0) ? default.FlagAnnouncement : default.OrbAnnouncement;
}

static function byte AnnouncementLevel(byte MessageIndex)
{
	return 2;
}

static function string GetString( optional int Switch, optional bool bPRI1HUD, optional PlayerReplicationInfo RelatedPRI_1,
					optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
	return (Switch == 0) ? default.FlagMessage : default.OrbMessage;
}

defaultproperties
{
   FlagMessage="Non puoi portare la bandiera su questo veicolo"
   FlagAnnouncement=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_YouCannotCarryTheFlagInThisVehicle'
   OrbMessage="Non puoi trasportare la Sfera con questo veicolo."
   OrbAnnouncement=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_YouCannotCarryTheOrbInThisVehicle'
   MessageArea=2
   DrawColor=(B=255,G=160,R=0,A=255)
   FontSize=1
   Name="Default__UTVehicleCantCarryFlagMessage"
   ObjectArchetype=UTLocalMessage'UTGame.Default__UTLocalMessage'
}
