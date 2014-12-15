/**
 * Base class for events which are activated when some widget that contains data wishes to publish that data.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * @note: native because C++ code activates this event
 */
class UIEvent_SubmitData extends UIEvent
	native(inherit)
	abstract;

defaultproperties
{
   ObjCategory="Data Submitted"
   Name="Default__UIEvent_SubmitData"
   ObjectArchetype=UIEvent'Engine.Default__UIEvent'
}
