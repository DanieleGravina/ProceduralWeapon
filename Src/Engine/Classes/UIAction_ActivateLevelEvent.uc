/**
 * Allows designers to activate remote events in the current level.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_ActivateLevelEvent extends UIAction
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Name of the event to activate */
var() Name EventName;

defaultproperties
{
   EventName="DefaultEvent"
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Failed")
   OutputLinks(1)=(LinkDesc="Success")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Player Index",PropertyName=,bWriteable=True,bHidden=True)
   VariableLinks(1)=(LinkDesc="Gamepad Id",PropertyName="GamepadID")
   ObjName="Activate Level Event"
   ObjCategory="Level"
   Name="Default__UIAction_ActivateLevelEvent"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
