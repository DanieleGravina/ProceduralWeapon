/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_Drowned extends UTDamageType
	abstract;

defaultproperties
{
   bOverrideHitEffectColor=True
   HitEffectColor=(R=-1.000000,G=-1.000000,B=2.000000,A=1.000000)
   DeathString="`o si è dimenticato di risalire a prendere aria."
   FemaleSuicide="`o si è dimenticata di risalire a prendere aria. "
   MaleSuicide="`o si è dimenticato di risalire a prendere aria."
   bArmorStops=False
   bLocationalHit=False
   bCausesBlood=False
   Name="Default__UTDmgType_Drowned"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
