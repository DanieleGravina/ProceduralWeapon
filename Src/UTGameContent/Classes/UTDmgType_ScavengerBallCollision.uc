/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_ScavengerBallCollision extends UTDamageType
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

// no K impulse because this occurs during async tick, so we can add impulse to kactors

defaultproperties
{
   DamageOverlayTime=0.000000
   AlwaysGibDamageThreshold=80
   DamageWeaponClass=Class'UTGameContent.UTVWeap_ScavengerGun'
   KillStatsName="EVENT_RANOVERKILLS"
   DeathStatsName="EVENT_RANOVERDEATHS"
   DeathString="`o è stato maciullato dallo Scavenger di `k."
   FemaleSuicide="`o si è maciullata da sola."
   MaleSuicide="`o si è maciullato da solo."
   bArmorStops=False
   bLocationalHit=False
   KDamageImpulse=0.000000
   KImpulseRadius=0.000000
   Name="Default__UTDmgType_ScavengerBallCollision"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
