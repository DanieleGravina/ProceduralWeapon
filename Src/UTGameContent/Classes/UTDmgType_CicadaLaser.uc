/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_CicadaLaser extends UTDamageType
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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_CicadaTurret'
   KillStatsName="KILLS_CICADATURRET"
   DeathStatsName="DEATHS_CICADATURRET"
   SuicideStatsName="SUICIDES_CICADATURRET"
   DeathString="Il blaster di `k ha colpito `o."
   FemaleSuicide="`o ha usato il suo blaster su di s�."
   MaleSuicide="`o ha usato il suo blaster su di s�."
   Name="Default__UTDmgType_CicadaLaser"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
