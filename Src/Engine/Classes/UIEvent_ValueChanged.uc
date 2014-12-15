/**
 * Base class for events which are activated when some widget that contains data changes the value of that data
 * (checkboxes, editboxes, lists, etc.)
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * @note: native because C++ code activates this event
 */
class UIEvent_ValueChanged extends UIEvent
	native(inherit)
	abstract;

defaultproperties
{
   ObjName="Value Changed"
   ObjCategory="Value Changed"
   Name="Default__UIEvent_ValueChanged"
   ObjectArchetype=UIEvent'Engine.Default__UIEvent'
}
