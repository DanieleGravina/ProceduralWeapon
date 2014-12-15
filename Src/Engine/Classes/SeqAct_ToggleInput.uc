/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_ToggleInput extends SeqAct_Toggle;

var() bool bToggleMovement;
var() bool bToggleTurning;

/**
 * Determines whether this class should be displayed in the list of available ops in the UI's kismet editor.
 *
 * @param	TargetObject	the widget that this SequenceObject would be attached to.
 *
 * @return	TRUE if this sequence object should be available for use in the UI kismet editor
 */
event bool IsValidUISequenceObject( optional UIScreenObject TargetObject )
{
	return false;
}

defaultproperties
{
   bToggleMovement=True
   bToggleTurning=True
   ObjName="Toggle Input"
   Name="Default__SeqAct_ToggleInput"
   ObjectArchetype=SeqAct_Toggle'Engine.Default__SeqAct_Toggle'
}
