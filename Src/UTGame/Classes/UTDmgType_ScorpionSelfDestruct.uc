/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_ScorpionSelfDestruct extends UTDmgType_Burning;

/** Amount of damage to given when hitting a vehicle **/
var int DamageGivenForSelfDestruct;

static function int IncrementKills(UTPlayerReplicationInfo KillerPRI)
{
	if ( UTPlayerController(KillerPRI.Owner) != None )
	{
		UTPlayerController(KillerPRI.Owner).BullseyeMessage();
	}
	return super.IncrementKills(KillerPRI);
}

defaultproperties
{
   DamageGivenForSelfDestruct=610
   bSelfDestructDamage=True
   KillStatsName="KILLS_SCORPIONSELFDESTRUCT"
   DeathStatsName="DEATHS_SCORPIONSELFDESTRUCT"
   SuicideStatsName="SUICIDES_SCORPIONSELFDESTRUCT"
   DeathString="`o stava troppo vicino all'autodistruzione dello Scorpion di `k."
   FemaleSuicide="`o si è incenerita con l'autodistruzione della sua Scorpion."
   MaleSuicide="`o si è incenerito con l'autodistruzione della sua Scorpion."
   bDontHurtInstigator=True
   bKRadialImpulse=True
   KDamageImpulse=12000.000000
   KImpulseRadius=500.000000
   Name="Default__UTDmgType_ScorpionSelfDestruct"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
