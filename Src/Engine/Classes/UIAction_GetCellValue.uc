/**
 * This action allows designers to retrieve data associated with a specific cell in a UIList element.
 *
 * This action's Targets array should be linked to UIList objects.  This action builds a markup string
 * that can be used to access the data in a single cell of a UIListElementCellProvider using the values
 * assigned to CollectionIndex and CellFieldName, and writes both the resulting markup string and the actual
 * value to the output varable links.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetCellValue extends UIAction_DataStore
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * The index for the item to retrieve the value for from the data store bound to the this action's associated list.
 */
var()			int				CollectionIndex;

/**
 * The name of the field to retrieve the data markup for
 */
var()			name			CellFieldName;

/**
 * The data store markup text used for accessing the value of the specified cell in the list's data provider.
 */
var				string			CellFieldMarkup;

/**
 * The resolved value of the specified cell in the list's data provider, if the cell field's value corresponds to a string.
 */
var				string			CellFieldStringValue;

/**
 * The resolved value of the specified cell in the list's data provider, if the cell field's value corresponds to an image.
 */
var				Surface			CellFieldImageValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to a range value.
 * @todo ronp - hmmm, since this is read-only, do we need to support a range value here???
 */
var				UIRoot.UIRangeData	CellFieldRangeValue;

defaultproperties
{
   CollectionIndex=-1
   bCallHandler=False
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Success")
   OutputLinks(1)=(LinkDesc="Failure")
   VariableLinks(0)=(MaxVars=1)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Index",PropertyName="CollectionIndex",MinVars=1,MaxVars=1)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Markup",PropertyName="CellFieldMarkup",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="String Value",PropertyName="CellFieldStringValue",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   VariableLinks(6)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Image Value",PropertyName="CellFieldImageValue",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   VariableLinks(7)=(ExpectedType=Class'Engine.SeqVar_UIRange',LinkDesc="Range Value",PropertyName="CellFieldRangeValue",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   ObjClassVersion=5
   ObjName="Get Cell Value"
   Name="Default__UIAction_GetCellValue"
   ObjectArchetype=UIAction_DataStore'Engine.Default__UIAction_DataStore'
}
