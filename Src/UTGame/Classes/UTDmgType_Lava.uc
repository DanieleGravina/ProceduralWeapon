/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Lava extends UTDmgType_Burning
	abstract;

defaultproperties
{
   DamageBodyMatColor=(R=50.000000,G=50.000000,B=0.000000,A=1.000000)
   DamageOverlayTime=0.300000
   DeathOverlayTime=0.600000
   DeathString="`o è stato incenerito da `k."
   FemaleSuicide="`o è stata incenerita da `k."
   MaleSuicide="`o è stato incenerito da `k."
   bCausedByWorld=True
   Name="Default__UTDmgType_Lava"
   ObjectArchetype=UTDmgType_Burning'UTGame.Default__UTDmgType_Burning'
}
