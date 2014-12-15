/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_HeroMelee extends UTDamageType
	abstract;

static function SpawnHitEffect(Pawn P, float Damage, vector Momentum, name BoneName, vector HitLocation)
{
	Super.SpawnHitEffect(P,Damage,Momentum,BoneName,HitLocation);
	if(UTPawn(P) != none)
	{
		UTPawn(P).SoundGroupClass.Static.PlayCrushedSound(P);
	}
}

defaultproperties
{
   GibPerterbation=1.000000
   bAlwaysGibs=True
   bLocationalHit=False
   Name="Default__UTDmgType_HeroMelee"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
