/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Warfare specific datastore for TDM game creation
 */
class UTDataStore_GameSettingsDM extends UIDataStore_OnlineGameSettings;

defaultproperties
{
   GameSettingsCfgList(0)=(GameSettingsClass=Class'UTGame.UTGameSettingsDM',SettingsName="UTGameSettingsDM")
   GameSettingsCfgList(1)=(GameSettingsClass=Class'UTGame.UTGameSettingsTDM',SettingsName="UTGameSettingsTDM")
   GameSettingsCfgList(2)=(GameSettingsClass=Class'UTGame.UTGameSettingsCTF',SettingsName="UTGameSettingsCTF")
   GameSettingsCfgList(3)=(GameSettingsClass=Class'UTGame.UTGameSettingsVCTF',SettingsName="UTGameSettingsVCTF")
   GameSettingsCfgList(4)=(GameSettingsClass=Class'UTGame.UTGameSettingsWAR',SettingsName="UTGameSettingsWAR")
   GameSettingsCfgList(5)=(GameSettingsClass=Class'UTGame.UTGameSettingsDUEL',SettingsName="UTGameSettingsDUEL")
   GameSettingsCfgList(6)=(GameSettingsClass=Class'UTGame.UTGameSettingsGreed',SettingsName="UTGameSettingsGreed")
   GameSettingsCfgList(7)=(GameSettingsClass=Class'UTGame.UTGameSettingsBetrayal',SettingsName="UTGameSettingsBetrayal")
   GameSettingsCfgList(8)=(GameSettingsClass=Class'UTGame.UTGameSettingsCampaign',SettingsName="UTGameSettingsCampaign")
   Tag="UTGameSettings"
   Name="Default__UTDataStore_GameSettingsDM"
   ObjectArchetype=UIDataStore_OnlineGameSettings'Engine.Default__UIDataStore_OnlineGameSettings'
}
