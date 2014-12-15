/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_Pancake extends UTDmgType_RanOver
	abstract;


static function SmallReward(UTPlayerController Killer, int KillCount)
{
	Killer.ReceiveLocalizedMessage(class'UTVehicleKillMessage', 4);
}

defaultproperties
{
   GibPerterbation=1.000000
   DeathString="`o è rimasto schiacciato da `k."
   FemaleSuicide="`o è rimasta schiacciata."
   MaleSuicide="`o è rimasto schiacciato."
   bArmorStops=False
   bAlwaysGibs=True
   Name="Default__UTDmgType_Pancake"
   ObjectArchetype=UTDmgType_RanOver'UTGame.Default__UTDmgType_RanOver'
}
