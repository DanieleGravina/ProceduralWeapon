/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_GoliathMachineGun extends UTDamageType
	abstract;

defaultproperties
{
   bBulletHit=True
   DamageWeaponClass=Class'UTGameContent.UTVWeap_GoliathMachineGun'
   NodeDamageScaling=0.500000
   KillStatsName="KILLS_GOLIATHMACHINEGUN"
   DeathStatsName="DEATHS_GOLIATHMACHINEGUN"
   SuicideStatsName="SUICIDES_GOLIATHMACHINEGUN"
   DeathString="`o è stato fatto scendere dalla torretta del minigun di `k."
   FemaleSuicide="`o ha rivolto il minigun contro se stessa."
   MaleSuicide="`o ha rivolto il minigun contro se stesso."
   bCausesBloodSplatterDecals=True
   KDamageImpulse=700.000000
   VehicleDamageScaling=0.500000
   Name="Default__UTDmgType_GoliathMachineGun"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
