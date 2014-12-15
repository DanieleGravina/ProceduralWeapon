/**
 * Provides access to the number of pages in the tab control.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_GetPageCount extends UIAction_TabControl;

/* == Events == */
/**
 * Called when this event is activated.  Performs the logic for this action.
 */
event Activated()
{
	local int PageCount;
	local SeqVar_Int IntVar;
	local bool bSuccess;

	Super.Activated();

	if ( TabControl != None )
	{
		PageCount = TabControl.GetPageCount();
		foreach LinkedVariables( class'SeqVar_Int', IntVar, "Count" )
		{
			IntVar.IntValue = PageCount;
			bSuccess = true;
		}
	}

	if ( bSuccess )
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

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Count",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get Page Count"
   Name="Default__UIAction_GetPageCount"
   ObjectArchetype=UIAction_TabControl'Engine.Default__UIAction_TabControl'
}
