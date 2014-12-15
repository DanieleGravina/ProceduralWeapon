/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LeviathanShockBall extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_LeviathanTurretShock'
   KillStatsName="KILLS_LEVIATHANTURRETSHOCK"
   DeathStatsName="DEATHS_LEVIATHANTURRETSHOCK"
   SuicideStatsName="SUICIDES_LEVIATHANTURRETSHOCK"
   DeathString="`k ha elettrizzato `o."
   FemaleSuicide="`o ha subito uno shock troppo grande."
   MaleSuicide="`o ha subito uno shock troppo grande."
   VehicleDamageScaling=0.250000
   VehicleMomentumScaling=0.250000
   Name="Default__UTDmgType_LeviathanShockBall"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
