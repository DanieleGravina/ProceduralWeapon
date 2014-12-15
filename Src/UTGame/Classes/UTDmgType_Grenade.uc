/**
 * UTDmgType_Grenade
 *
 *
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_Grenade extends UTDmgType_Rocket
	abstract;

defaultproperties
{
   DeathString="`o ha preso la granata di `k."
   FemaleSuicide="`o è caduta sulla sua stessa granata."
   MaleSuicide="`o è caduto sulla sua stessa granata."
   Name="Default__UTDmgType_Grenade"
   ObjectArchetype=UTDmgType_Rocket'UTGame.Default__UTDmgType_Rocket'
}
