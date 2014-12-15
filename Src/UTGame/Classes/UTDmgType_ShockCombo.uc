/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_ShockCombo extends UTDamageType
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=40.000000,G=0.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.900000
   bThrowRagdoll=True
   bHeadGibCamera=False
   DamageWeaponClass=Class'UTGame.UTWeap_ShockRifle'
   DamageWeaponFireMode=2
   DamageCameraAnim=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Combo_Shake'
   KillStatsName="KILLS_SHOCKCOMBO"
   DeathStatsName="DEATHS_SHOCKCOMBO"
   SuicideStatsName="SUICIDES_SHOCKCOMBO"
   RewardCount=15
   RewardAnnouncementSwitch=3
   RewardEvent="REWARD_COMBOKING"
   DeathString="`o non è riuscito a schivare il colpo del combo shock di `k."
   FemaleSuicide="`o ha fatto un errore tattico col suo combo shock."
   MaleSuicide="`o ha fatto un errore tattico col suo combo shock."
   bNeverGibs=True
   bKRadialImpulse=True
   KDamageImpulse=6500.000000
   KImpulseRadius=300.000000
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=2.250000
   Name="Default__UTDmgType_ShockCombo"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
