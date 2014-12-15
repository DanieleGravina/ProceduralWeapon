/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_SpiderMine extends UTDamageType
	abstract;

defaultproperties
{
   bComplainFriendlyFire=False
   KillStatsName="KILLS_SPIDERMINE"
   DeathStatsName="DEATHS_SPIDERMINE"
   SuicideStatsName="SUICIDES_SPIDERMINE"
   DeathString="Le mine robot di `k hanno scovato `o."
   FemaleSuicide="`o ha perso il controllo delle sue mine."
   MaleSuicide="`o ha perso il controllo delle sue mine."
   bKRadialImpulse=True
   Name="Default__UTDmgType_SpiderMine"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
