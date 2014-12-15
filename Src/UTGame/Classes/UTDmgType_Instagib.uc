/**
 * UTDmgType_Instagib
 *
 *
 *
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Instagib extends UTDamageType
	abstract;

static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	Super.SpawnHitEffect(P,Damage,Momentum,BoneName,HitLocation);
	if(UTPawn(P) != none)
	{
		UTPawn(P).SoundGroupClass.Static.PlayInstagibSound(P);
	}
}

defaultproperties
{
   GibPerterbation=0.500000
   DamageWeaponClass=Class'UTGame.UTWeap_InstagibRifle'
   DamageWeaponFireMode=2
   KillStatsName="KILLS_INSTAGIB"
   DeathStatsName="DEATHS_INSTAGIB"
   SuicideStatsName="SUICIDES_INSTAGIB"
   DeathString="`o è stato ucciso all'istante dal super raggio shock di `k."
   FemaleSuicide="`o in qualche modo è riuscita a spararsi col fucile instagib."
   MaleSuicide="`o in qualche modo è riuscito a spararsi col fucile instagib."
   bAlwaysGibs=True
   Name="Default__UTDmgType_Instagib"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
