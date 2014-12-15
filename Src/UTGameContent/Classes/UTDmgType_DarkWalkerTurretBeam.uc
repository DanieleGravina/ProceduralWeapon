/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_DarkWalkerTurretBeam extends UTDmgType_Burning
      abstract;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_DarkWalkerTurret'
   KillStatsName="KILLS_DARKWALKERTURRET"
   DeathStatsName="DEATHS_DARKWALKERTURRET"
   SuicideStatsName="SUICIDES_DARKWALKERTURRET"
   DeathString="`o è stato disintegrato dal raggio di `k."
   FemaleSuicide="`o si è disintegrata."
   MaleSuicide="`o si è disintegrato."
   bAlwaysGibs=True
   bKRadialImpulse=True
   KDamageImpulse=3000.000000
   KImpulseRadius=100.000000
   Name="Default__UTDmgType_DarkWalkerTurretBeam"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
