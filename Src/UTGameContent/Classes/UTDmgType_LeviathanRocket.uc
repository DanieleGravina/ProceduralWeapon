/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LeviathanRocket extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_LeviathanTurretRocket'
   KillStatsName="KILLS_LEVIATHANTURRETROCKET"
   DeathStatsName="DEATHS_LEVIATHANTURRETROCKET"
   SuicideStatsName="SUICIDES_LEVIATHANTURRETROCKET"
   DeathString="`k ha fatto piovere fuoco su `o."
   FemaleSuicide="`o è esplosa."
   MaleSuicide="`o è esploso."
   VehicleDamageScaling=1.500000
   VehicleMomentumScaling=2.000000
   Name="Default__UTDmgType_LeviathanRocket"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
