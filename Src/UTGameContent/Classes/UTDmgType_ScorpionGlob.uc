/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_ScorpionGlob extends UTDamageType
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=0.000000,G=30.000000,B=50.000000,A=1.000000)
   DamageWeaponClass=Class'UTGameContent.UTVWeap_ScorpionTurret'
   NodeDamageScaling=0.750000
   KillStatsName="KILLS_SCORPIONGLOB"
   DeathStatsName="DEATHS_SCORPIONGLOB"
   SuicideStatsName="SUICIDES_SCORPIONGLOB"
   DeathString="Lo scorpion di `k ha spedito `o all'altro mondo."
   FemaleSuicide="`o si è fatta esplodere."
   MaleSuicide="`o si è fatto esplodere."
   bCausesBlood=False
   VehicleDamageScaling=0.750000
   Name="Default__UTDmgType_ScorpionGlob"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
