/**
 * Enables or disables a tab button and tab page in a tab control.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_EnablePage extends UIAction_TabControl;

/** Reference to the page that should be activated */
var	UITabPage	PageToEnable;

/** TRUE to enable the specified page; FALSE to disable it */
var()	bool	bEnable;

/* == Events == */
/**
 * Called when this event is activated.  Performs the logic for this action.
 */
event Activated()
{
	Super.Activated();

	if ( TabControl != None && PageToEnable != None )
	{
		if ( TabControl.EnableTabPage(PageToEnable, PlayerIndex, bEnable) )
		{
			if ( !OutputLinks[0].bDisabled )
			{
				OutputLinks[0].bHasImpulse = true;
			}
		}
		else
		{
			if ( !OutputLinks[1].bDisabled )
			{
				OutputLinks[1].bHasImpulse = true;
			}
		}
	}
}

defaultproperties
{
   bEnable=True
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Enable?",PropertyName="bEnable",bHidden=True,MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Tab Page",PropertyName="PageToEnable",MinVars=1,MaxVars=255)
   ObjName="Enable/Disable Page"
   Name="Default__UIAction_EnablePage"
   ObjectArchetype=UIAction_TabControl'Engine.Default__UIAction_TabControl'
}
