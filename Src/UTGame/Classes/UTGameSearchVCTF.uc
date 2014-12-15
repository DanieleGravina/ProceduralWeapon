/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Holds the base game search for a VCTF match.
 */
class UTGameSearchVCTF extends UTGameSearchCommon;

defaultproperties
{
   Query=(ValueIndex=3)
   GameSettingsClass=Class'UTGame.UTGameSettingsVCTF'
   LocalizedSettings(0)=(ValueIndex=3)
   Name="Default__UTGameSearchVCTF"
   ObjectArchetype=UTGameSearchCommon'UTGame.Default__UTGameSearchCommon'
}
