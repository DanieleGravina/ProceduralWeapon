/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SPMAShell extends UTDamageType;

defaultproperties
{
   bComplainFriendlyFire=False
   DamageWeaponClass=Class'UTGameContent.UTVWeap_SPMACannon_Content'
   KillStatsName="KILLS_SPMACANNON"
   DeathStatsName="DEATHS_SPMACANNON"
   SuicideStatsName="SUICIDES_SPMACANNON"
   DeathString="`o è rimasto schiacciato quando l'Hellfire di `k ha colpito in pieno!"
   FemaleSuicide="`o è stata uccisa da un attacco di artiglieria."
   MaleSuicide="`o è stato ucciso da un attacco di artiglieria."
   bKRadialImpulse=True
   Name="Default__UTDmgType_SPMAShell"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
