/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_VehicleShockBeam extends UTDamageType;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_ShockTurret'
   KillStatsName="KILLS_TURRETSHOCK"
   DeathStatsName="DEATHS_TURRETSHOCK"
   SuicideStatsName="SUICIDES_TURRETSHOCK"
   DeathString="Il laser di `k ha fulminato `o."
   FemaleSuicide="`o ha usato il suo laser su di sé."
   MaleSuicide="`o ha usato il suo laser su di sé."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   Name="Default__UTDmgType_VehicleShockBeam"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
