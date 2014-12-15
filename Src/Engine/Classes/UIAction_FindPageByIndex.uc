/**
 * Finds the tab page at a particular index in the tab control's Pages array.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_FindPageByIndex extends UIAction_GetPageReference;

/** the index of the page to find */
var()	int		SearchIndex;

/* == Events == */
/**
 * Called when this event is activated.  Performs the logic for this action.
 */
event Activated()
{
	if ( TabControl != None )
	{
		PageReference = TabControl.GetPageAtIndex(SearchIndex);
	}

	// call Super.Activated after setting the PageReference, as the parent version sets the PageIndex value if we have
	// a valid PageReference
	Super.Activated();
}

defaultproperties
{
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Search Index",PropertyName="SearchIndex",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Find Page By Index"
   Name="Default__UIAction_FindPageByIndex"
   ObjectArchetype=UIAction_GetPageReference'Engine.Default__UIAction_GetPageReference'
}
