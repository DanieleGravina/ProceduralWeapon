/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_ShockBall extends UTDamageType
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=40.000000,G=0.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.600000
   DamageWeaponClass=Class'UTGame.UTWeap_ShockRifle'
   DamageWeaponFireMode=1
   KillStatsName="KILLS_SHOCKRIFLE"
   DeathStatsName="DEATHS_SHOCKRIFLE"
   SuicideStatsName="SUICIDES_SHOCKRIFLE"
   DeathString="`o è stato annientato dalla bolla di energia di `k."
   FemaleSuicide="`o si è ammazzata con la bolla di energia."
   MaleSuicide="`o si è ammazzato con la bolla di energia."
   KDamageImpulse=1500.000000
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=2.750000
   Name="Default__UTDmgType_ShockBall"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
