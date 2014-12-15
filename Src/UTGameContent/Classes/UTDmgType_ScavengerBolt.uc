/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTDmgType_ScavengerBolt extends UTDamageType
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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_ScavengerGun'
   KillStatsName="KILLS_SCAVENGERGUN"
   DeathStatsName="DEATHS_SCAVENGERGUN"
   SuicideStatsName="SUICIDES_SCAVENGERGUN"
   DeathString="`o non ha potuto fuggire alla palla di luce iridescente di 'k."
   FemaleSuicide="`o ha visto la luce."
   MaleSuicide="`o ha visto la luce."
   bCausesBlood=False
   Name="Default__UTDmgType_ScavengerBolt"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
