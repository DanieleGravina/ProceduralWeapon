/**
 * Activates a tab page in a tab control.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_ActivatePage extends UIAction_TabControl;

/** Reference to the page that should be activated */
var	UITabPage	PageToActivate;

/** TRUE to activate the specified page; FALSE to deactivate it */
var()	bool	bActivate;

/* == Events == */
/**
 * Called when this event is activated.  Performs the logic for this action.
 */
event Activated()
{
	Super.Activated();

	if ( TabControl != None && PageToActivate != None )
	{
		if ( TabControl.ActivatePage(PageToActivate, PlayerIndex, bActivate) )
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
   bActivate=True
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Activate?",PropertyName="bActivate",bHidden=True,MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Tab Page",PropertyName="PageToActivate",MinVars=1,MaxVars=255)
   ObjName="Activate/Deactivate Page"
   Name="Default__UIAction_ActivatePage"
   ObjectArchetype=UIAction_TabControl'Engine.Default__UIAction_TabControl'
}
