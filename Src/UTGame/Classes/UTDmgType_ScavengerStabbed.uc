/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_ScavengerStabbed extends UTDamageType
	abstract;

defaultproperties
{
   KillStatsName="KILLS_SCAVENGERSTABBED"
   DeathStatsName="DEATHS_SCAVENGERSTABBED"
   SuicideStatsName="SUICIDES_SCAVENGERSTABBED"
   DeathString="`o è stato impalato dallo Scavenger di `k."
   FemaleSuicide="`o si è impalata."
   MaleSuicide="`o si è impalato."
   Name="Default__UTDmgType_ScavengerStabbed"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
