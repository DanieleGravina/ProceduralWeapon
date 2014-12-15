/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_AvrilRocket extends UTDamageType
	abstract;

defaultproperties
{
   GibPerterbation=0.150000
   AlwaysGibDamageThreshold=99
   DamageWeaponClass=Class'UTGame.UTWeap_Avril'
   KillStatsName="KILLS_AVRIL"
   DeathStatsName="DEATHS_AVRIL"
   SuicideStatsName="SUICIDES_AVRIL"
   RewardCount=15
   RewardAnnouncementSwitch=8
   RewardEvent="REWARD_BIGGAMEHUNTER"
   DeathString="`k ha distrutto `o con un AVRiL."
   FemaleSuicide="`o ha puntato la sua arma dalla parte sbagliata."
   MaleSuicide="`o ha puntato la sua arma dalla parte sbagliata."
   bKRadialImpulse=True
   KDamageImpulse=3000.000000
   KImpulseRadius=100.000000
   VehicleDamageScaling=1.600000
   VehicleMomentumScaling=5.000000
   Name="Default__UTDmgType_AvrilRocket"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
