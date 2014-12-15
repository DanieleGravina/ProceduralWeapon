/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTDmgType_VehicleExplosion extends UTDmgType_Burning
	abstract;

defaultproperties
{
   bThrowRagdoll=True
   GibPerterbation=0.150000
   KillStatsName="KILLS_VEHICLEEXPLOSION"
   DeathStatsName="DEATHS_VEHICLEEXPLOSION"
   SuicideStatsName="SUICIDES_VEHICLEEXPLOSION"
   DeathString="`k ha eliminato `o con l'esplosione di un veicolo."
   FemaleSuicide="`o stava un po' troppo vicino al veicolo che ha fatto esplodere."
   MaleSuicide="`o stava un po' troppo vicino al veicolo che ha fatto esplodere."
   KDamageImpulse=1000.000000
   Name="Default__UTDmgType_VehicleExplosion"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
