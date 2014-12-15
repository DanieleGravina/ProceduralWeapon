/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_VehicleShockChain extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_ShockTurret'
   DamageWeaponFireMode=2
   KillStatsName="KILLS_TURRETSHOCK"
   DeathStatsName="DEATHS_TURRETSHOCK"
   SuicideStatsName="SUICIDES_TURRETSHOCK"
   DeathString="`o non ha potuto evitare l'incredibile potenza dello skymine combo di `k."
   FemaleSuicide="`o è stata un po' frettolosa nel detonare i suoi skymine."
   MaleSuicide="`o è stato un po' frettoloso nel detonare i suoi skymine."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   VehicleMomentumScaling=1.500000
   Name="Default__UTDmgType_VehicleShockChain"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
