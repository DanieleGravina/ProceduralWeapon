/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SPMACameraCrush extends UTDamageType;

defaultproperties
{
   bComplainFriendlyFire=False
   DamageWeaponClass=Class'UTGameContent.UTVWeap_SPMACannon_Content'
   KillStatsName="KILLS_SPMACAMERACRUSH"
   DeathStatsName="DEATHS_SPMACAMERACRUSH"
   SuicideStatsName="SUICIDES_SPMACAMERACRUSH"
   DeathString="`o è rimasto schiacciato quando la fotocamera di `k è caduta da cielo!  "
   FemaleSuicide="Il cielo sta cascando... su di TE!"
   MaleSuicide="Il cielo sta cascando... su di TE!"
   bKRadialImpulse=True
   Name="Default__UTDmgType_SPMACameraCrush"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
