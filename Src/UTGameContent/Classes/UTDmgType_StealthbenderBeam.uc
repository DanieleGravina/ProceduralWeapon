/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_StealthbenderBeam extends UTDmgType_NightShadeBeam
	abstract;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_StealthbenderGun'
   KillStatsName="KILLS_STEALTHBENDERGUN"
   DeathStatsName="DEATHS_STEALTHBENDERGUN"
   SuicideStatsName="SUICIDES_STEALTHBENDERGUN"
   DeathString="`o è stato sfregiato dal raggio StealthBender di 'k."
   Name="Default__UTDmgType_StealthbenderBeam"
   ObjectArchetype=UTDmgType_NightshadeBeam'UTGameContent.Default__UTDmgType_NightshadeBeam'
}
