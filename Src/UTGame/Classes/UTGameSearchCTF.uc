/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Holds the base game search for a CTF match.
 */
class UTGameSearchCTF extends UTGameSearchCommon;

defaultproperties
{
   Query=(ValueIndex=2)
   GameSettingsClass=Class'UTGame.UTGameSettingsCTF'
   LocalizedSettings(0)=(ValueIndex=1)
   Name="Default__UTGameSearchCTF"
   ObjectArchetype=UTGameSearchCommon'UTGame.Default__UTGameSearchCommon'
}
