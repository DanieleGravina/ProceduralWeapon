/**
 * Base class for all actions which return a reference to a UITabPage.  Each child class uses a different search mechanism.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_GetPageReference extends UIAction_TabControl
	abstract;

/** Reference to the page being searched for; NULL if not found */
var	UITabPage	PageReference;

/** Index of the page [into its tab control's Pages array] for the page that was found */
var		int		PageIndex;

/* == Events == */
/**
 * Called when this event is activated.  Performs the logic for this action.
 */
event Activated()
{
	Super.Activated();

	if ( TabControl != None && PageReference != None )
	{
		PageIndex = TabControl.FindPageIndexByPageRef(PageReference);
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

defaultproperties
{
   PageIndex=-1
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Tab Page",PropertyName="PageReference",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Page Index",PropertyName="PageIndex",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   ObjName="Find Page"
   Name="Default__UIAction_GetPageReference"
   ObjectArchetype=UIAction_TabControl'Engine.Default__UIAction_TabControl'
}
