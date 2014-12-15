/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Enforcer extends UTDamageType
	abstract;

static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	Super.SpawnHitEffect(P,Damage,Momentum,BoneName,HitLocation);
	if(UTPawn(P) != none)
	{
		UTPawn(P).SoundGroupClass.Static.PlayBulletImpact(P);
	}
}

defaultproperties
{
   bBulletHit=True
   DamageWeaponClass=Class'UTGame.UTWeap_Enforcer'
   DamageWeaponFireMode=2
   NodeDamageScaling=0.500000
   KillStatsName="KILLS_ENFORCER"
   DeathStatsName="DEATHS_ENFORCER"
   SuicideStatsName="SUICIDES_ENFORCER"
   RewardCount=15
   RewardAnnouncementSwitch=7
   RewardEvent="REWARD_GUNSLINGER"
   CustomTauntIndex=10
   DeathString="`k ha crivellato `o di colpi con l'Enforcer."
   FemaleSuicide="`o ha fatto l'impossibile."
   MaleSuicide="`o ha fatto l'impossibile."
   bNeverGibs=True
   bCausesBloodSplatterDecals=True
   KDamageImpulse=200.000000
   VehicleDamageScaling=0.330000
   VehicleMomentumScaling=0.000000
   Name="Default__UTDmgType_Enforcer"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
