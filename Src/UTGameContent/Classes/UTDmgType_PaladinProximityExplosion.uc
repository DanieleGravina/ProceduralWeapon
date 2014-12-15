/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTDmgType_PaladinProximityExplosion extends UTDamageType
	abstract;

defaultproperties
{
   bThrowRagdoll=True
   DamageWeaponClass=Class'UTGameContent.UTVWeap_PaladinGun'
   KillStatsName="KILLS_PALADINEXPLOSION"
   DeathStatsName="DEATHS_PALADINEXPLOSION"
   SuicideStatsName="SUICIDES_PALADINEXPLOSION"
   DeathString="`o si è avvicinato troppo al Paladin di `k."
   Name="Default__UTDmgType_PaladinProximityExplosion"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
