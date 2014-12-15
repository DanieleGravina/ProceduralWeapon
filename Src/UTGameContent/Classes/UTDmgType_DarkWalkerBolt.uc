/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_DarkWalkerBolt extends UTDamageType
      abstract;

defaultproperties
{
   DamageWeaponClass=Class'UTGameContent.UTVWeap_DarkWalkerPassGun'
   DamageWeaponFireMode=2
   NodeDamageScaling=0.700000
   KillStatsName="KILLS_DARKWALKERPASSGUN"
   DeathStatsName="DEATHS_DARKWALKERPASSGUN"
   SuicideStatsName="SUICIDES_DARKWALKERPASSGUN"
   DeathString="Il Dark Walker di `k ha sventrato `o col plasma fuso."
   FemaleSuicide="`o ha sparato troppo presto."
   MaleSuicide="`o ha sparato troppo presto."
   VehicleDamageScaling=0.700000
   Name="Default__UTDmgType_DarkWalkerBolt"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
