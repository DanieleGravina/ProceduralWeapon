/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_ScorpionBlade extends UTDamageType
	abstract;

defaultproperties
{
   KillStatsName="KILLS_SCORPIONBLADE"
   DeathStatsName="DEATHS_SCORPIONBLADE"
   SuicideStatsName="SUICIDES_SCORPIONBLADE"
   DeathString="`o è stato maciullato dalla lama di `k."
   FemaleSuicide="`o è stata maciullata."
   MaleSuicide="`o è stato maciullato."
   bArmorStops=False
   bNeverGibs=True
   Name="Default__UTDmgType_ScorpionBlade"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
