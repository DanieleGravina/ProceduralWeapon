/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Telefrag extends UTDamageType
	abstract;

defaultproperties
{
   GibPerterbation=1.000000
   KillStatsName="KILLS_TRANSLOCATOR"
   DeathStatsName="DEATHS_TRANSLOCATOR"
   SuicideStatsName="SUICIDES_TRANSLOCATOR"
   DeathString="Gli atomi di `o sono stati sostituiti da `k."
   FemaleSuicide="`o ha distrutto il suo teletrasportatore."
   MaleSuicide="`o ha distrutto il suo teletrasportatore."
   bAlwaysGibs=True
   bLocationalHit=False
   Name="Default__UTDmgType_Telefrag"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
