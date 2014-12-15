/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SPMASmallShell extends UTDamageType;

defaultproperties
{
   bComplainFriendlyFire=False
   DamageWeaponClass=Class'UTGameContent.UTVWeap_SPMACannon_Content'
   KillStatsName="KILLS_SPMACANNON"
   DeathStatsName="DEATHS_SPMACANNON"
   SuicideStatsName="SUICIDES_SPMACANNON"
   DeathString="`k ha fatto piovere sulla parata di `o."
   FemaleSuicide="`o è stata uccisa da un attacco di artiglieria."
   MaleSuicide="`o è stato ucciso da un attacco di artiglieria."
   bKRadialImpulse=True
   Name="Default__UTDmgType_SPMASmallShell"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
