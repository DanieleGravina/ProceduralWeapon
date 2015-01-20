/**
 * Finds the tab page whose button has the specified caption or data store binding value.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_FindPageByCaption extends UIAction_GetPageReference;

/** the button caption to search for */
var()	string		SearchCaption;

/** indicates that the search caption is actually a markup string */
var()	bool		bMarkupString;

/* == Events == */
/**
 * Called when this event is activated.  Performs the logic for this action.
 */
event Activated()
{
	local int SearchIndex;

	if ( TabControl != None )
	{
		SearchIndex = TabControl.FindPageIndexByCaption(SearchCaption, bMarkupString);
		PageReference = TabControl.GetPageAtIndex(SearchIndex);
	}

	// call Super.Activated after setting the PageReference, as the parent version sets the PageIndex value if we have
	// a valid PageReference
	Super.Activated();
}

defaultproperties
{
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Page Caption",PropertyName="SearchCaption",MinVars=1,MaxVars=255)
   ObjName="Find Page By Caption"
   Name="Default__UIAction_FindPageByCaption"
   ObjectArchetype=UIAction_GetPageReference'Engine.Default__UIAction_GetPageReference'
}