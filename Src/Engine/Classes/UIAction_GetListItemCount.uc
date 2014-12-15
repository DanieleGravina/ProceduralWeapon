/**
 * This action retrieves the number of elements in a list.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetListItemCount extends UIAction
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Output variable for the number of items in the attached list. */
var int	ItemCount;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Item Count",PropertyName="ItemCount",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get List Item Count"
   Name="Default__UIAction_GetListItemCount"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
