/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_MantaBolt extends UTDamageType
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
}

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_MantaGun'
   NodeDamageScaling=0.700000
   KillStatsName="KILLS_MANTAGUN"
   DeathStatsName="DEATHS_MANTAGUN"
   SuicideStatsName="SUICIDES_MANTAGUN"
   DeathString="Il manta di `k ha sventrato `o col plasma fuso."
   FemaleSuicide="`o ha sparato troppo presto."
   MaleSuicide="`o ha sparato troppo presto."
   bCausesBlood=False
   VehicleDamageScaling=0.700000
   Name="Default__UTDmgType_MantaBolt"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
