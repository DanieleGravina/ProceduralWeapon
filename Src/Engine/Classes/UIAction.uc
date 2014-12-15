/**
 * Abstract base class for UI actions.
 * Actions perform tasks for widgets, in response to some external event.  Actions are created by programmers and are
 * bound to widget events by designers using the UI editor.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction extends SequenceAction
	native(UISequence)
	abstract
	placeable;

/**
 * The ControllerId of the LocalPlayer corresponding to the 'PlayerIndex' element of the Engine.GamePlayers array.
 */
var	transient	noimport	int		GamepadID;

/**
 * Controls whether this action is automatically executed on the owning widget.  If true, this action will add the owning
 * widget to the Targets array when it's activated, provided the Targets array is empty.
 */
var()		bool		bAutoTargetOwner;

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
// (cpptext)
// (cpptext)

/**
 * Returns the widget that contains this UIAction.
 */
native final function UIScreenObject GetOwner() const;

/**
 * Returns the scene that contains this UIAction.
 */
native final function UIScene GetOwnerScene() const;

/**
 * Determines whether this class should be displayed in the list of available ops in the level kismet editor.
 *
 * @return	TRUE if this sequence object should be available for use in the level kismet editor
 */
event bool IsValidLevelSequenceObject()
{
	return false;
}

/**
 * Determines whether this class should be displayed in the list of available ops in the UI's kismet editor.
 *
 * @param	TargetObject	the widget that this SequenceObject would be attached to.
 *
 * @return	TRUE if this sequence object should be available for use in the UI kismet editor
 */
event bool IsValidUISequenceObject( optional UIScreenObject TargetObject )
{
	return true;
}

defaultproperties
{
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Player Index",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Gamepad Id",PropertyName="GamepadID",bWriteable=True,bHidden=True,MinVars=1,MaxVars=255)
   ObjClassVersion=4
   ObjCategory="UI"
   Name="Default__UIAction"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
