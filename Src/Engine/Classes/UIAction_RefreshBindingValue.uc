/**
 * This action instructs the owning widget to refresh and reapply the value of a data store binding.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_RefreshBindingValue extends UIAction_DataStore
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
 * Determines whether this class should be displayed in the list of available ops in the UI's kismet editor.
 *
 * @param	TargetObject	the widget that this SequenceObject would be attached to.
 *
 * @return	TRUE if this sequence object should be available for use in the UI kismet editor
 */
event bool IsValidUISequenceObject( optional UIScreenObject TargetObject )
{
	if ( !Super.IsValidUISequenceObject(TargetObject) )
	{
		return false;
	}

	if ( TargetObject != None )
	{
		// this op can only be used by widgets that implement the UIDataStoreSubscriber interface
		return UIDataStoreSubscriber(TargetObject) != None;
	}

	return true;
}

defaultproperties
{
   ObjName="Refresh Value"
   Name="Default__UIAction_RefreshBindingValue"
   ObjectArchetype=UIAction_DataStore'Engine.Default__UIAction_DataStore'
}
