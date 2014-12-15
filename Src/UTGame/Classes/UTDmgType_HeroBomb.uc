/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_HeroBomb extends UTDamageType
	abstract;

defaultproperties
{
   bDestroysBarricades=True
   bComplainFriendlyFire=False
   bHeadGibCamera=False
   DamageWeaponFireMode=2
   NodeDamageScaling=0.350000
   KillStatsName="KILLS_HEROBOMB"
   DeathStatsName="KILLS_HEROBOMB"
   SuicideStatsName="KILLS_HEROBOMB"
   HeroPointsMultiplier=0.000000
   bKUseOwnDeathVel=True
   KDamageImpulse=20000.000000
   KDeathUpKick=700.000000
   KImpulseRadius=5000.000000
   VehicleDamageScaling=1.500000
   DamagedFFWaveform=ForceFeedbackWaveform'UTGame.Default__UTDmgType_HeroBomb:ForceFeedbackWaveform10'
   Name="Default__UTDmgType_HeroBomb"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
