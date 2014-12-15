/**
 * This action allows designers to change the index of a UIList.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetListIndex extends UIAction_SetValue;

/** the index to change the list to */
var()	int		NewIndex;

/** whether to clamp invalid index values */
var()	bool	bClampInvalidValues;

/** whether the list should activate the ListIndexChanged event */
var()	bool	bActivateListChangeEvent;

defaultproperties
{
   NewIndex=-1
   bClampInvalidValues=True
   bActivateListChangeEvent=True
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Success")
   OutputLinks(1)=(LinkDesc="Failed")
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="New Index",PropertyName="NewIndex",MinVars=1,MaxVars=255)
   ObjName="Set List Index"
   Name="Default__UIAction_SetListIndex"
   ObjectArchetype=UIAction_SetValue'Engine.Default__UIAction_SetValue'
}
