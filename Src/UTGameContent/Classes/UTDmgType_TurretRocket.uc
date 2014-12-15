/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_TurretRocket extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_RocketTurret'
   KillStatsName="KILLS_TURRETROCKET"
   DeathStatsName="DEATHS_TURRETROCKET"
   SuicideStatsName="SUICIDES_TURRETROCKET"
   DeathString="La torretta di 'k ha mandato `o in paradiso."
   FemaleSuicide="`o si è fatta saltare in aria."
   MaleSuicide="`o si è fatto saltare in aria."
   VehicleMomentumScaling=2.000000
   Name="Default__UTDmgType_TurretRocket"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
