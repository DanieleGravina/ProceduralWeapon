/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_TurretShard extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_TurretStinger'
   KillStatsName="KILLS_TURRETSTINGER"
   DeathStatsName="DEATHS_TURRETSTINGER"
   SuicideStatsName="SUICIDES_TURRETSTINGER"
   DeathString="`o � stato inchiodato da 'k."
   FemaleSuicide="`o si � inchiodata da sola."
   MaleSuicide="`o si � inchiodato da solo."
   VehicleDamageScaling=0.250000
   VehicleMomentumScaling=0.250000
   Name="Default__UTDmgType_TurretShard"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
