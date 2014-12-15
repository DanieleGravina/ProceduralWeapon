/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_EradicatorCameraCrush extends UTDmgType_SPMACameraCrush;

static function int IncrementKills(UTPlayerReplicationInfo KillerPRI)
{
	local UTPlayerController PC;

	// Increment "Eradication" achievement
	PC = UTPlayerController(KillerPRI.Owner);
	if ( PC != None )
	{
		PC.ClientUpdateAchievement(EUTA_UT3GOLD_Eradication, 1);
	}

	return Super.IncrementKills(KillerPRI);
}

defaultproperties
{
   DamageWeaponClass=Class'UT3Gold.UTVWeap_EradicatorCannon_Content'
   Name="Default__UTDmgType_EradicatorCameraCrush"
   ObjectArchetype=UTDmgType_SPMACameraCrush'UTGameContent.Default__UTDmgType_SPMACameraCrush'
}
