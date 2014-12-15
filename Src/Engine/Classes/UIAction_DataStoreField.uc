/**
 * This is the base class for all actions which interact with specific fields from a data provider.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_DataStoreField extends UIAction_DataStore
	native(inherit)
	abstract;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
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
 * The scene to use for resolving the datastore markup in DataFieldMarkupString
 */
var()			UIScene			TargetScene;

/**
 * The data store markup string corresponding to the data field to resolve.
 */
var()			string			DataFieldMarkupString;

defaultproperties
{
   bCallHandler=False
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Failure")
   VariableLinks(0)=(LinkDesc="Target Scene",PropertyName="TargetScene",bHidden=True,MaxVars=1)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Markup String",PropertyName="DataFieldMarkupString",MinVars=1,MaxVars=1)
   Name="Default__UIAction_DataStoreField"
   ObjectArchetype=UIAction_DataStore'Engine.Default__UIAction_DataStore'
}
