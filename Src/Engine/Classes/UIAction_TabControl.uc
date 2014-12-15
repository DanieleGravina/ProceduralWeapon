/**
 * Base class for all actions which operate on UITabControl, UITabButton, or UITabPage.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_TabControl extends UIAction
	abstract;

/** Reference to the tab control to act on */
var()	UITabControl	TabControl;

defaultproperties
{
   bCallHandler=False
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Success")
   OutputLinks(1)=(LinkDesc="Failure")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Player Index",PropertyName=,bWriteable=True,bHidden=True)
   VariableLinks(1)=(LinkDesc="Gamepad Id",PropertyName="GamepadID")
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Tab Control",PropertyName="TabControl",bWriteable=False,bHidden=False)
   ObjName="Tab Control Action"
   ObjCategory="Tab Control"
   Name="Default__UIAction_TabControl"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
