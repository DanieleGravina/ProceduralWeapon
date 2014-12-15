/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Holds the base game search for a TDM match.
 */
class UTGameSearchTDM extends UTGameSearchCommon;

defaultproperties
{
   Query=(ValueIndex=1)
   GameSettingsClass=Class'UTGame.UTGameSettingsTDM'
   LocalizedSettings(0)=(ValueIndex=4)
   Name="Default__UTGameSearchTDM"
   ObjectArchetype=UTGameSearchCommon'UTGame.Default__UTGameSearchCommon'
}
