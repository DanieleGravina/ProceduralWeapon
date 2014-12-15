/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_NemesisBeam extends UTDamageType
	abstract;

/** SpawnHitEffect()
 * Possibly spawn a custom hit effect
 */
static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	local UTEmit_VehicleHit BF;

	if ( Vehicle(P) != None )
	{
		BF = P.spawn(class'UTEmit_VehicleHit',P,, HitLocation, rotator(Momentum));
		BF.AttachTo(P, BoneName);
	}
}

defaultproperties
{
   DamageBodyMatColor=(R=40.000000,G=20.000000,B=0.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.600000
   GibPerterbation=0.750000
   DamageWeaponClass=Class'UTGameContent.UTVWeap_NemesisTurret'
   KillStatsName="KILLS_NEMESISTURRET"
   DeathStatsName="DEATHS_NEMESISTURRET"
   SuicideStatsName="SUICIDES_NEMESISTURRET"
   DeathString="`o è stato fulminato dal Nemesis di `k."
   FemaleSuicide="`o si è incenerita col laser del suo Nemesis."
   MaleSuicide="`o si è incenerito col laser del suo Nemesis."
   bCausesBlood=False
   KDamageImpulse=1500.000000
   VehicleMomentumScaling=2.000000
   Name="Default__UTDmgType_NemesisBeam"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
