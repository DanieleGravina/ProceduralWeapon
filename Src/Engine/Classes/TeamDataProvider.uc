/**
 * Provides data about an instance of the TeamInfo class in the game.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class TeamDataProvider extends UIDynamicDataProvider
	native(inherit);

defaultproperties
{
   DataClass=Class'Engine.TeamInfo'
   Name="Default__TeamDataProvider"
   ObjectArchetype=UIDynamicDataProvider'Engine.Default__UIDynamicDataProvider'
}
