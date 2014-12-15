/**
 * Action for moving elements within a UIList.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_MoveListItem extends UIAction
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * The index of the element to move.
 */
var()		int				ElementIndex;

/**
 * The number of places to move it
 */
var()		int				MoveCount;

defaultproperties
{
   ElementIndex=-1
   bAutoTargetOwner=True
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Failure")
   OutputLinks(1)=(LinkDesc="Success")
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Element Index",PropertyName="ElementIndex",MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Count",PropertyName="MoveCount",MinVars=1,MaxVars=255)
   ObjName="Move Element"
   ObjCategory="List"
   Name="Default__UIAction_MoveListItem"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
