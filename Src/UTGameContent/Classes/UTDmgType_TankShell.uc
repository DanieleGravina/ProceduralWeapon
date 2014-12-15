/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_TankShell extends UTDmgType_Burning
	abstract;

static function ScoreKill(UTPlayerReplicationInfo KillerPRI, UTPlayerReplicationInfo KilledPRI, Pawn KilledPawn)
{
	super.ScoreKill(KillerPRI, KilledPRI, KilledPawn);
	if ( KilledPRI != None && KillerPRI != KilledPRI && UTVehicle(KilledPawn) != None && UTVehicle(KilledPawn).EagleEyeTarget() )
	{
		KillerPRI.IncrementEventStat('EVENT_EAGLEEYE');
		if (UTPlayerController(KillerPRI.Owner) != None)
			UTPlayerController(KillerPRI.Owner).ReceiveLocalizedMessage(class'UTVehicleKillMessage', 5);
	}
}

static function float VehicleDamageScalingFor(Vehicle V)
{
	if ( (UTVehicle(V) != None) && UTVehicle(V).bLightArmor )
		return 1.2;

	return Default.VehicleDamageScaling;
}

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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_GoliathTurret'
   NodeDamageScaling=1.250000
   KillStatsName="KILLS_GOLIATHTURRET"
   DeathStatsName="DEATHS_GOLIATHTURRET"
   SuicideStatsName="SUICIDES_GOLIATHTURRET"
   DeathString="Il proiettile del carro armato di `k ha ridotto `o in cenere."
   FemaleSuicide="`o ha sparato il suo razzo troppo presto."
   MaleSuicide="`o ha sparato il suo razzo troppo presto."
   bKRadialImpulse=True
   KDamageImpulse=8000.000000
   KImpulseRadius=500.000000
   VehicleMomentumScaling=1.500000
   Name="Default__UTDmgType_TankShell"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
