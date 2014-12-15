/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SPMAShockBeam extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_SPMAPassengerGun'
   KillStatsName="KILLS_SPMATURRET"
   DeathStatsName="DEATHS_SPMATURRET"
   SuicideStatsName="SUICIDES_SPMATURRET"
   DeathString="`o è stato disintegrato dal raggio di `k."
   FemaleSuicide="`o si è disintegrata."
   MaleSuicide="`o si è disintegrato."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   Name="Default__UTDmgType_SPMAShockBeam"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
