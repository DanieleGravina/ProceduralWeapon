/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_StingerShard extends UTDamageType;

static function PawnTornOff(UTPawn DeadPawn)
{
	if ( !class'GameInfo'.Static.UseLowGore(DeadPawn.WorldInfo) )
	{
	 	class'UTProj_StingerShard'.static.CreateSpike(DeadPawn, DeadPawn.TakeHitLocation, DeadPawn.Normal(DeadPawn.TearOffMomentum));
	}
}

defaultproperties
{
   bThrowRagdoll=True
   DamageWeaponClass=Class'UTGame.UTWeap_Stinger'
   DamageWeaponFireMode=1
   NodeDamageScaling=0.600000
   KillStatsName="KILLS_STINGER"
   DeathStatsName="DEATHS_STINGER"
   SuicideStatsName="SUICIDES_STINGER"
   RewardCount=15
   RewardAnnouncementSwitch=9
   RewardEvent="REWARD_BLUESTREAK"
   CustomTauntIndex=9
   DeathString="`o è stato sbudellato dallo stinger di `k."
   FemaleSuicide="`o ha rivolto lo Stinger verso sé stessa."
   MaleSuicide="`o ha rivolto lo Stinger verso sé stesso."
   bNeverGibs=True
   bCausesBloodSplatterDecals=True
   bKRadialImpulse=True
   KDamageImpulse=1000.000000
   KDeathUpKick=200.000000
   VehicleDamageScaling=0.600000
   VehicleMomentumScaling=2.000000
   Name="Default__UTDmgType_StingerShard"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
