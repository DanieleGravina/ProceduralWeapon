/**
 * Base class for all actions that manipulate scenes.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_Scene extends UIAction
	abstract
	native(UISequence);

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

/** the scene that this action will manipulate */
var()	UIScene		Scene;

/**
 * Determines whether this class should be displayed in the list of available ops in the level kismet editor.
 *
 * @return	TRUE if this sequence object should be available for use in the level kismet editor
 */
event bool IsValidLevelSequenceObject()
{
	return true;
}

defaultproperties
{
   bCallHandler=False
   bAutoActivateOutputLinks=False
   OutputLinks(0)=(LinkDesc="Success")
   OutputLinks(1)=(LinkDesc="Failed")
   VariableLinks(0)=(LinkDesc="Scene",PropertyName="Scene")
   Name="Default__UIAction_Scene"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
