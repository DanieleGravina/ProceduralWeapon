/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SPMAShockBall extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_SPMAPassengerGun'
   DamageWeaponFireMode=1
   KillStatsName="KILLS_SPMATURRET"
   DeathStatsName="DEATHS_SPMATURRET"
   SuicideStatsName="SUICIDES_SPMATURRET"
   DeathString="`o ran into `k's skymine."
   FemaleSuicide="`o ran into her own skymine."
   MaleSuicide="`o ran into his own skymine."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   Name="Default__UTDmgType_SPMAShockBall"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
