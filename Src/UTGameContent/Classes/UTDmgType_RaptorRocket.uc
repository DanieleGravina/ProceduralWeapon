/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_RaptorRocket extends UTDmgType_Burning
	abstract;

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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_RaptorGun'
   DamageWeaponFireMode=1
   KillStatsName="KILLS_RAPTORROCKET"
   DeathStatsName="DEATHS_RAPTORROCKET"
   SuicideStatsName="SUICIDES_RAPTORROCKET"
   DeathString="`o non è riuscito a schivare il missile aria-aria di `k."
   FemaleSuicide="`o si è fatta saltare in aria."
   MaleSuicide="`o si è fatto saltare in aria."
   bKRadialImpulse=True
   KDamageImpulse=2000.000000
   VehicleDamageScaling=1.500000
   VehicleMomentumScaling=0.750000
   Name="Default__UTDmgType_RaptorRocket"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
