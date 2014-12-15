/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_HellBenderPrimary extends UTDamageType
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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_HellBenderPrimary'
   KillStatsName="KILLS_HELLBENDERPRIMARY"
   DeathStatsName="DEATHS_HELLBENDERPRIMARY"
   SuicideStatsName="SUICIDES_HELLBENDERPRIMARY"
   DeathString="`o è stato disintegrato dal raggio di `k."
   FemaleSuicide="`o si è disintegrata."
   MaleSuicide="`o si è disintegrato."
   KDamageImpulse=3001.000000
   VehicleDamageScaling=0.850000
   Name="Default__UTDmgType_HellBenderPrimary"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
