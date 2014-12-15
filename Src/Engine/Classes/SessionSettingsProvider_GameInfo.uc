/**
 * Provides the UI with read/write access to settings from the GameInfo class.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SessionSettingsProvider_GameInfo extends SessionSettingsProvider;

defaultproperties
{
   ProviderClientMetaClass=Class'Engine.GameInfo'
   Name="Default__SessionSettingsProvider_GameInfo"
   ObjectArchetype=SessionSettingsProvider'Engine.Default__SessionSettingsProvider'
}
