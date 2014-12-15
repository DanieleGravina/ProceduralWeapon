/**
 * Abstract base class for events which are implemented by UIStates.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIEvent_State extends UIEvent
	native(inherit)
	abstract;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bPropagateEvent=False
   VariableLinks(0)=(LinkDesc="State")
   ObjName="State Event"
   Name="Default__UIEvent_State"
   ObjectArchetype=UIEvent'Engine.Default__UIEvent'
}
