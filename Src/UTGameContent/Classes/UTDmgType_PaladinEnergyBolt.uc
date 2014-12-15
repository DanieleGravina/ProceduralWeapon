/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_PaladinEnergyBolt extends UTDamageType
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

defaultproperties
{
   bThrowRagdoll=True
   DamageWeaponClass=Class'UTGameContent.UTVWeap_PaladinGun'
   KillStatsName="KILLS_PALADINGUN"
   DeathStatsName="DEATHS_PALADINGUN"
   SuicideStatsName="SUICIDES_PALADINGUN"
   DeathString="`o non è riuscito a schivare il colpo del Paladin di `k."
   VehicleMomentumScaling=2.500000
   Name="Default__UTDmgType_PaladinEnergyBolt"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
