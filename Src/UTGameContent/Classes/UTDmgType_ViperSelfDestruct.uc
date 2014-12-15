/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_ViperSelfDestruct extends UTDmgType_Burning;

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
   bSelfDestructDamage=True
   KillStatsName="KILLS_VIPERSELFDESTRUCT"
   DeathStatsName="DEATHS_VIPERSELFDESTRUCT"
   SuicideStatsName="SUICIDES_VIPERSELFDESTRUCT"
   DeathString="`o stava troppo vicino all'autodistruzione del Viper di `k."
   FemaleSuicide="`o si è incenerita con l'autodistruzione del suo Viper."
   MaleSuicide="`o si è incenerito con l'autodistruzione del suo Viper."
   bDontHurtInstigator=True
   bKRadialImpulse=True
   KDamageImpulse=12000.000000
   KImpulseRadius=500.000000
   Name="Default__UTDmgType_ViperSelfDestruct"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
