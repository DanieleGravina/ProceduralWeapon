/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SPMAShockChain extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_SPMAPassengerGun'
   DamageWeaponFireMode=2
   KillStatsName="KILLS_SPMATURRET"
   DeathStatsName="DEATHS_SPMATURRET"
   SuicideStatsName="SUICIDES_SPMATURRET"
   DeathString="`o non ha potuto evitare l'incredibile potenza dello skymine combo di `k."
   FemaleSuicide="`o è stata un po' frettolosa nel detonare i suoi skymine."
   MaleSuicide="`o è stato un po' frettoloso nel detonare i suoi skymine."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   VehicleMomentumScaling=1.500000
   Name="Default__UTDmgType_SPMAShockChain"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
