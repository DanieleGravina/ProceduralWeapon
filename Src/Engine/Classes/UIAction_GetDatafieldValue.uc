/**
 * This class allows designers to retrieve the value of data fields from a data store.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetDatafieldValue extends UIAction_DataStoreField
	native(inherit);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to a string.
 */
var				string			DataFieldStringValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to an image.
 */
var				Surface			DataFieldImageValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to a collection.
 */
var				array<int>		DataFieldArrayValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to a range value.
 */
var				UIRoot.UIRangeData	DataFieldRangeValue;

defaultproperties
{
   OutputLinks(1)=(LinkDesc="String Value")
   OutputLinks(2)=(LinkDesc="Image Value")
   OutputLinks(3)=(LinkDesc="Array Value")
   OutputLinks(4)=(LinkDesc="Range Value")
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="String Value",PropertyName="DataFieldStringValue",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Image Value",PropertyName="DataFieldImageValue",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(6)=(ExpectedType=Class'Engine.SeqVar_UIRange',LinkDesc="Range Value",PropertyName="DataFieldRangeValue",bWriteable=True,MinVars=1,MaxVars=1)
   ObjClassVersion=5
   ObjName="Get Datastore Value"
   Name="Default__UIAction_GetDatafieldValue"
   ObjectArchetype=UIAction_DataStoreField'Engine.Default__UIAction_DataStoreField'
}
