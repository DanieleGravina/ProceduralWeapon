/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_FuryBeam extends UTDmgType_Burning;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_FuryGun'
   DamageWeaponFireMode=1
   KillStatsName="KILLS_FURYGUN"
   DeathStatsName="DEATHS_FURYGUN"
   SuicideStatsName="SUICIDES_FURYGUN"
   DeathString="`o è stato disintegrato dal raggio di `k."
   FemaleSuicide="`o si è disintegrata."
   MaleSuicide="`o si è disintegrato."
   bAlwaysGibs=True
   bKRadialImpulse=True
   KDamageImpulse=12000.000000
   Name="Default__UTDmgType_FuryBeam"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
