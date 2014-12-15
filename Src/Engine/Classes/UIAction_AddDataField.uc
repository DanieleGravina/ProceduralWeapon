/**
 * This action allows designers to add additional fields to
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_AddDataField extends UIAction_DataStoreField
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
 * Indicates whether the data field should be saved to the UIDynamicFieldProvider's persistent storage area.
 */
var()	bool						bPersistentField;

/**
 * Specifies the type of data field being added.
 */
var()	EUIDataProviderFieldType	FieldType;

defaultproperties
{
   OutputLinks(1)=(LinkDesc="Success")
   ObjName="Add Data Field"
   Name="Default__UIAction_AddDataField"
   ObjectArchetype=UIAction_DataStoreField'Engine.Default__UIAction_DataStoreField'
}
