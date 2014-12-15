/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Redeemer extends UTDamageType
	abstract;

defaultproperties
{
   bDestroysBarricades=True
   bComplainFriendlyFire=False
   DamageWeaponClass=Class'UTGameContent.UTWeap_Redeemer_Content'
   DamageWeaponFireMode=2
   NodeDamageScaling=1.500000
   KillStatsName="KILLS_REDEEMER"
   DeathStatsName="DEATHS_REDEEMER"
   SuicideStatsName="SUICIDES_REDEEMER"
   DeathString="`o è stato POLVERIZZATO da `k!"
   FemaleSuicide="`o è stato POLVERIZZATO!"
   MaleSuicide="`o è stato POLVERIZZATO!"
   bKUseOwnDeathVel=True
   KDamageImpulse=20000.000000
   KDeathUpKick=700.000000
   KImpulseRadius=5000.000000
   VehicleDamageScaling=1.500000
   Name="Default__UTDmgType_Redeemer"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
