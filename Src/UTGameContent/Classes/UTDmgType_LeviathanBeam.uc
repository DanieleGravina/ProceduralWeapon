/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LeviathanBeam extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_LeviathanTurretBeam'
   KillStatsName="KILLS_LEVIATHANTURRETBEAM"
   DeathStatsName="DEATHS_LEVIATHANTURRETBEAM"
   SuicideStatsName="SUICIDES_LEVIATHANTURRETBEAM"
   DeathString="`k ha fatto `o a pezzi."
   FemaleSuicide="`o si è fatta esplodere in pezzi."
   MaleSuicide="`o si è fatto esplodere in pezzi."
   KDamageImpulse=1500.000000
   VehicleDamageScaling=2.000000
   VehicleMomentumScaling=2.000000
   Name="Default__UTDmgType_LeviathanBeam"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
