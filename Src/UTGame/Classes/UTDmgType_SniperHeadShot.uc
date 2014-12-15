/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_SniperHeadShot extends UTDamageType
	abstract;

static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	local UTPawn UTP;
	local name HeadBone;
	local UTEmit_HitEffect HitEffect;

	UTP = UTPawn(P);
	if (UTP != None && UTP.Mesh != None)
	{
		HeadBone = UTP.HeadBone;
	}
	HitEffect = P.Spawn(class'UTEmit_HeadShotBloodSpray',,, HitLocation, rotator(-Momentum));
	if (HitEffect != None)
	{
		HitEffect.AttachTo(P, HeadBone);
	}
}

static function int IncrementKills(UTPlayerReplicationInfo KillerPRI)
{
	if ( PlayerController(KillerPRI.Owner) != None )
	{
		PlayerController(KillerPRI.Owner).ReceiveLocalizedMessage( class'UTWeaponKillRewardMessage', 0 );
	}
	return super.IncrementKills(KillerPRI);
}

defaultproperties
{
   bSeversHead=True
   DamageWeaponClass=Class'UTGame.UTWeap_SniperRifle'
   DeathAnim="Death_Headshot"
   NodeDamageScaling=0.400000
   KillStatsName="KILLS_HEADSHOT"
   DeathStatsName="DEATHS_HEADSHOT"
   SuicideStatsName="SUICIDES_HEADSHOT"
   RewardCount=15
   RewardAnnouncementSwitch=2
   RewardEvent="REWARD_HEADHUNTER"
   CustomTauntIndex=3
   DeathString="La materia grigia di `o è stata espulsa da `k."
   FemaleSuicide="`o è caduta sulla sua arma e un colpo alla testa l'ha uccisa."
   MaleSuicide="`o è caduto sulla sua arma e un colpo alla testa lo ha ucciso."
   bNeverGibs=True
   bCausesBloodSplatterDecals=True
   bIgnoreDriverDamageMult=True
   VehicleDamageScaling=0.400000
   Name="Default__UTDmgType_SniperHeadShot"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
