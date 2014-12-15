/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTDmgType_StingerBullet extends UTDamageType
	abstract;

defaultproperties
{
   bBulletHit=True
   DamageWeaponClass=Class'UTGame.UTWeap_Stinger'
   DeathAnim="Death_Stinger"
   DeathAnimRate=0.900000
   StopAnimAfterDamageInterval=0.500000
   NodeDamageScaling=0.600000
   KillStatsName="KILLS_STINGER"
   DeathStatsName="DEATHS_STINGER"
   SuicideStatsName="SUICIDES_STINGER"
   RewardCount=15
   RewardAnnouncementSwitch=9
   RewardEvent="REWARD_BLUESTREAK"
   CustomTauntIndex=8
   DeathString="`o è stato fatto scendere dallo stinger di `k."
   FemaleSuicide="`o ha rivolto lo Stinger verso sé stessa."
   MaleSuicide="`o ha rivolto lo Stinger verso sé stesso."
   bNeverGibs=True
   bCausesBloodSplatterDecals=True
   KDamageImpulse=200.000000
   VehicleDamageScaling=0.600000
   VehicleMomentumScaling=0.750000
   Name="Default__UTDmgType_StingerBullet"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
