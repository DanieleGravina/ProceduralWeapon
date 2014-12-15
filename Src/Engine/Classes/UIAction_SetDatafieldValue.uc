/**
 * This class allows designers to change the value of a data field in a data store.  Whichever object
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetDatafieldValue extends UIAction_DataStoreField
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
var()			string			DataFieldStringValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to an image.
 */
var()			Surface			DataFieldImageValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to a collection.
 */
var()			array<int>		DataFieldArrayValue;

/**
 * The value of the specified field in the resolved data provider, if the datafield's value corresponds to a range value.
 */
var()			UIRoot.UIRangeData	DataFieldRangeValue;

/**
 * If TRUE, immediately calls Commit on the owning data store.
 */
var()			bool			bCommitValueImmediately;

defaultproperties
{
   OutputLinks(1)=(LinkDesc="Success")
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="String Value",PropertyName="DataFieldStringValue",MinVars=1,MaxVars=1)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Image Value",PropertyName="DataFieldImageValue",MinVars=1,MaxVars=1)
   VariableLinks(6)=(ExpectedType=Class'Engine.SeqVar_UIRange',LinkDesc="Range Value",PropertyName="DataFieldRangeValue",MinVars=1,MaxVars=1)
   ObjClassVersion=5
   ObjName="Set Datastore Value"
   Name="Default__UIAction_SetDatafieldValue"
   ObjectArchetype=UIAction_DataStoreField'Engine.Default__UIAction_DataStoreField'
}
