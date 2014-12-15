/**
 * Base class for all events implemented by scenes.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIEvent_Scene extends UIEvent
	native(inherit)
	abstract;

defaultproperties
{
   bPlayerOnly=False
   Name="Default__UIEvent_Scene"
   ObjectArchetype=UIEvent'Engine.Default__UIEvent'
}
