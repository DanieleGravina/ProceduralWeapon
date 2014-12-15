/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_ShockPrimary extends UTDamageType
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=40.000000,G=0.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.600000
   GibPerterbation=0.750000
   DamageWeaponClass=Class'UTGame.UTWeap_ShockRifle'
   DamageCameraAnim=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Hit_Shake'
   NodeDamageScaling=0.800000
   KillStatsName="KILLS_SHOCKRIFLE"
   DeathStatsName="DEATHS_SHOCKRIFLE"
   SuicideStatsName="SUICIDES_SHOCKRIFLE"
   CustomTauntIndex=4
   DeathString="`o è stato fatalmente illuminato dal raggio shock di `k."
   FemaleSuicide="`o in qualche modo è riuscita a spararsi col fucile shock."
   MaleSuicide="`o in qualche modo è riuscito a spararsi col fucile shock."
   KDamageImpulse=1500.000000
   VehicleDamageScaling=0.700000
   VehicleMomentumScaling=2.000000
   Name="Default__UTDmgType_ShockPrimary"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
