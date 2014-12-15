/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_VehicleShockBall extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_ShockTurret'
   DamageWeaponFireMode=1
   KillStatsName="KILLS_TURRETSHOCK"
   DeathStatsName="DEATHS_TURRETSHOCK"
   SuicideStatsName="SUICIDES_TURRETSHOCK"
   DeathString="`o è finito nello skymine di `."
   FemaleSuicide="`o è finita nel suo stesso skymine."
   MaleSuicide="`o è finito nel suo stesso skymine."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   Name="Default__UTDmgType_VehicleShockBall"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
