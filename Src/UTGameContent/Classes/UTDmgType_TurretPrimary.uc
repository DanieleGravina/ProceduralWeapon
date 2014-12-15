/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_TurretPrimary extends UTDamageType;

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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_TurretPrimary'
   KillStatsName="KILLS_TURRETPRIMARY"
   DeathStatsName="DEATHS_TURRETPRIMARY"
   SuicideStatsName="SUICIDES_TURRETPRIMARY"
   DeathString="`o è stato disintegrato dal raggio di `k."
   FemaleSuicide="`o si è fatta esplodere."
   MaleSuicide="`o si è fatto esplodere."
   bCausesBlood=False
   VehicleDamageScaling=0.700000
   Name="Default__UTDmgType_TurretPrimary"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
