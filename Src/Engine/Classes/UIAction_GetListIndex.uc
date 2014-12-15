/**
 * This action retrieves the index and value of the item at the index for the list that activated this action.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetListIndex extends UIAction_GetValue
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   bAutoTargetOwner=True
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Valid")
   OutputLinks(1)=(LinkDesc="Invalid")
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Current Item",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Current Index",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   ObjClassVersion=5
   ObjName="Selected List Item"
   Name="Default__UIAction_GetListIndex"
   ObjectArchetype=UIAction_GetValue'Engine.Default__UIAction_GetValue'
}
