/**
 * UTDmgType_Rocket
 *
 *
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Rocket extends UTDmgType_Burning
	abstract;

/** SpawnHitEffect()
 * Possibly spawn a custom hit effect
 */
static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	local UTEmit_VehicleHit BF;

	if ( Vehicle(P) != None )
	{
		BF = P.spawn(class'UTEmit_VehicleHit',P,, HitLocation, rotator(Momentum));
		BF.AttachTo(P, BoneName);
	}
	else
	{
		Super.SpawnHitEffect(P, Damage, Momentum, BoneName, HitLocation);
	}
}

defaultproperties
{
   bThrowRagdoll=True
   GibPerterbation=0.150000
   AlwaysGibDamageThreshold=99
   DamageWeaponClass=Class'UTGame.UTWeap_RocketLauncher'
   NodeDamageScaling=1.100000
   KillStatsName="KILLS_ROCKETLAUNCHER"
   DeathStatsName="DEATHS_ROCKETLAUNCHER"
   SuicideStatsName="SUICIDES_ROCKETLAUNCHER"
   RewardCount=15
   RewardAnnouncementSwitch=10
   RewardEvent="REWARD_ROCKETSCIENTIST"
   CustomTauntIndex=7
   DeathString="`o ha annientato il razzo di `k."
   FemaleSuicide="`o ha sparato il suo razzo troppo presto."
   MaleSuicide="`o ha sparato il suo razzo troppo presto."
   bKRadialImpulse=True
   KDamageImpulse=1000.000000
   KDeathUpKick=200.000000
   VehicleDamageScaling=0.800000
   VehicleMomentumScaling=4.000000
   Name="Default__UTDmgType_Rocket"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
