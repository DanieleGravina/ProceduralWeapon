/**
 * Base class for all actions which access to widget properties.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetValue extends UIAction
	abstract
	native(inherit);

defaultproperties
{
   ObjCategory="Get Value"
   Name="Default__UIAction_GetValue"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
