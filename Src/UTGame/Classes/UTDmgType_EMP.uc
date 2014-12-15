/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_EMP extends UTDamageType
	abstract;

defaultproperties
{
   DamageWeaponClass=Class'UTGame.UTWeap_ImpactHammer'
   DamageWeaponFireMode=2
   KillStatsName="KILLS_EMP"
   DeathStatsName="DEATHS_EMP"
   SuicideStatsName="SUICIDES_EMP"
   KDamageImpulse=7000.000000
   Name="Default__UTDmgType_EMP"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
