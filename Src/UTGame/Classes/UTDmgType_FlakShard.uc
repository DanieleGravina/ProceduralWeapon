/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_FlakShard extends UTDamageType
	abstract;

defaultproperties
{
   bBulletHit=True
   GibThreshold=-15
   MinAccumulateDamageThreshold=55
   AlwaysGibDamageThreshold=80
   DamageWeaponClass=Class'UTGame.UTWeap_FlakCannon'
   KillStatsName="KILLS_FLAKCANNON"
   DeathStatsName="DEATHS_FLAKCANNON"
   SuicideStatsName="SUICIDES_FLAKCANNON"
   RewardCount=15
   RewardAnnouncementSwitch=1
   RewardEvent="REWARD_FLAKMASTER"
   CustomTauntIndex=6
   DeathString="`o è stato ridotto a brandelli dal cannone flak di `k."
   FemaleSuicide="`o è rimasta crivellata dal suo stesso flak."
   MaleSuicide="`o è rimasto crivellato dal suo stesso flak."
   KDamageImpulse=600.000000
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=0.650000
   Name="Default__UTDmgType_FlakShard"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
