/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LeviathanShard extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_LeviathanTurretStinger'
   KillStatsName="KILLS_LEVIATHANTURRETSTINGER"
   DeathStatsName="DEATHS_LEVIATHANTURRETSTINGER"
   SuicideStatsName="SUICIDES_LEVIATHANTURRETSTINGER"
   DeathString="`k ha trafitto `o."
   FemaleSuicide="`o è morto."
   MaleSuicide="`o è morto."
   VehicleDamageScaling=0.500000
   VehicleMomentumScaling=0.500000
   Name="Default__UTDmgType_LeviathanShard"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
