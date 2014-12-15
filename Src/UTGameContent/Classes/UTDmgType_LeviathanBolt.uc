/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LeviathanBolt extends UTDamageType
	abstract;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_LeviathanPrimary'
   DamageWeaponFireMode=2
   NodeDamageScaling=0.500000
   KillStatsName="KILLS_LEVIATHANPRIMARY"
   DeathStatsName="DEATHS_LEVIATHANPRIMARY"
   SuicideStatsName="SUICIDES_LEVIATHANPRIMARY"
   DeathString="Il Leviathan di `k ha riempito `o di plasma."
   FemaleSuicide="`o si è incenerita col suo fuoco al plasma."
   MaleSuicide="`o si è incenerito col suo fuoco al plasma."
   KDamageImpulse=1000.000000
   VehicleDamageScaling=0.500000
   VehicleMomentumScaling=1.500000
   Name="Default__UTDmgType_LeviathanBolt"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
