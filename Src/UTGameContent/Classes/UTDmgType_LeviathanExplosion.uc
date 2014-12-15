/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_LeviathanExplosion extends UTDamageType
	abstract;

defaultproperties
{
   bDestroysBarricades=True
   DamageWeaponClass=Class'UTGameContent.UTVWeap_LeviathanPrimary'
   DamageWeaponFireMode=2
   KillStatsName="KILLS_LEVIATHANEXPLOSION"
   DeathStatsName="DEATHS_LEVIATHANEXPLOSION"
   SuicideStatsName="SUICIDES_LEVIATHANEXLOSION"
   DeathString="Il Leviathan di 'k ha qualche ultima parola per `o."
   FemaleSuicide="`o è stata eliminata dal suo stesso Leviathan"
   MaleSuicide="`o è stato eliminato dal suo stesso Leviathan"
   bKUseOwnDeathVel=True
   KDamageImpulse=20000.000000
   KDeathUpKick=700.000000
   KImpulseRadius=5000.000000
   VehicleDamageScaling=1.500000
   Name="Default__UTDmgType_LeviathanExplosion"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
