/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LinkPlasma extends UTDamageType
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=50.000000,G=50.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.500000
   DeathOverlayTime=1.000000
   DamageWeaponClass=Class'UTGame.UTWeap_LinkGun'
   NodeDamageScaling=0.800000
   KillStatsName="KILLS_LINKGUN"
   DeathStatsName="DEATHS_LINKGUN"
   SuicideStatsName="SUICIDES_LINKGUN"
   DeathString="`o ha ricevuto un altro piatto di plasma di `k."
   FemaleSuicide="`o si è incenerita col suo fuoco al plasma."
   MaleSuicide="`o si è incenerito col suo fuoco al plasma."
   VehicleDamageScaling=0.600000
   VehicleMomentumScaling=0.250000
   Name="Default__UTDmgType_LinkPlasma"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
