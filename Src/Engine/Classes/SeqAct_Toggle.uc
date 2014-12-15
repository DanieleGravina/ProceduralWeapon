/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_Toggle extends SequenceAction
	native(Sequence);

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
	return true;
}

defaultproperties
{
   InputLinks(0)=(LinkDesc="Turn On")
   InputLinks(1)=(LinkDesc="Turn Off")
   InputLinks(2)=(LinkDesc="Toggle")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Bool",MaxVars=255)
   EventLinks(0)=(ExpectedType=Class'Engine.SequenceEvent',LinkDesc="Event")
   ObjName="Toggle"
   ObjCategory="Toggle"
   Name="Default__SeqAct_Toggle"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
