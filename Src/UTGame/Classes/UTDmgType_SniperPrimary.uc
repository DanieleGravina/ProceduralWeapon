/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_SniperPrimary extends UTDamageType
	abstract;

static function float VehicleDamageScalingFor(Vehicle V)
{
	if ( (UTVehicle(V) != None) && UTVehicle(V).bLightArmor )
		return 1.5 * Default.VehicleDamageScaling;

	return Default.VehicleDamageScaling;
}

defaultproperties
{
   GibPerterbation=0.250000
   DamageWeaponClass=Class'UTGame.UTWeap_SniperRifle'
   NodeDamageScaling=0.400000
   KillStatsName="KILLS_SNIPERRIFLE"
   DeathStatsName="DEATHS_SNIPERRIFLE"
   SuicideStatsName="SUICIDES_SNIPERRIFLE"
   CustomTauntIndex=2
   DeathString="`o è stato abbattuto da `k."
   FemaleSuicide="`o è caduta sulla sua arma e un colpo al petto l'ha uccisa."
   MaleSuicide="`o è caduto sulla sua arma e un colpo al petto lo ha ucciso."
   bNeverGibs=True
   bCausesBloodSplatterDecals=True
   VehicleDamageScaling=0.400000
   Name="Default__UTDmgType_SniperPrimary"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
