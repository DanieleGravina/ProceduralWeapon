/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_TurretShockBall extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_TurretShock'
   KillStatsName="KILLS_TURRETSHOCK"
   DeathStatsName="DEATHS_TURRETSHOCK"
   SuicideStatsName="SUICIDES_TURRETSHOCK"
   DeathString="`o è stato decimato dalla torretta di `k."
   VehicleDamageScaling=0.250000
   VehicleMomentumScaling=0.250000
   Name="Default__UTDmgType_TurretShockBall"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
