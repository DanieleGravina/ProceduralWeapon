/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_CicadaRocket extends UTDmgType_Burning
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
   DamageWeaponClass=Class'UTGameContent.UTVWeap_CicadaMissileLauncher'
   NodeDamageScaling=0.800000
   KillStatsName="KILLS_CICADAROCKET"
   DeathStatsName="DEATHS_CICADAROCKET"
   SuicideStatsName="SUICIDES_CICADAROCKET"
   DeathString="`k ha fatto `o a pezzi."
   FemaleSuicide="`o si è annientata."
   MaleSuicide="`o si è annientato."
   VehicleMomentumScaling=2.500000
   Name="Default__UTDmgType_CicadaRocket"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
