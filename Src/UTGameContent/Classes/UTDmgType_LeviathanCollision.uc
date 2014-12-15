/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTDmgType_LeviathanCollision extends UTDamageType
	abstract;

defaultproperties
{
   KillStatsName="KILLS_VEHICLE_COLLISION"
   DeathStatsName="DEATHS_VEHICLE_COLLISION"
   SuicideStatsName="SUICIDES_VEHICLE_COLLISION"
   DeathString="Il Leviathan di `k ha schiacciato `o."
   FemaleSuicide="`o ha fatto un incidente."
   MaleSuicide="`o ha fatto un incidente."
   Name="Default__UTDmgType_LeviathanCollision"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
