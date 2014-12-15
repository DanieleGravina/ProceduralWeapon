/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_FuryBolt extends UTDamageType;

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

static function ScoreKill(UTPlayerReplicationInfo KillerPRI, UTPlayerReplicationInfo KilledPRI, Pawn KilledPawn)
{
	super.ScoreKill(KillerPRI, KilledPRI, KilledPawn);
	if (KilledPRI != None && KillerPRI != KilledPRI && Vehicle(KilledPawn) != None && Vehicle(KilledPawn).bCanFly)
	{
		KillerPRI.IncrementEventStat('EVENT_TOPGUN');
		if (UTPlayerController(KillerPRI.Owner) != None)
			UTPlayerController(KillerPRI.Owner).ReceiveLocalizedMessage(class'UTVehicleKillMessage', 6);
	}
}

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_FuryGun'
   DamageWeaponFireMode=2
   KillStatsName="KILLS_FURYBOLT"
   DeathStatsName="DEATHS_FURYBOLT"
   SuicideStatsName="SUICIDES_FURYBOLT"
   DeathString="Il Fury di `k ha riempito `o di plasma."
   FemaleSuicide="`o si è incenerita col suo fuoco al plasma."
   MaleSuicide="`o si è incenerito col suo fuoco al plasma."
   bCausesBlood=False
   KDamageImpulse=1000.000000
   Name="Default__UTDmgType_FuryBolt"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
