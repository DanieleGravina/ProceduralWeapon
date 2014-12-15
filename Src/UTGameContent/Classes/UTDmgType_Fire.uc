/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_Fire extends UTDmgType_Burning
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=50.000000,G=50.000000,B=0.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.600000
   bCausedByWorld=True
   Name="Default__UTDmgType_Fire"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
