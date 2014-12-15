/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_Log extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Should this message be drawn on the screen as well as placed in the log? */
var() bool bOutputToScreen;

/** Should ObjComment be included in the log? */
var() bool bIncludeObjComment;

/** Time to leave text floating above Target actor */
var() float TargetDuration;

/** Offset to apply to the Target actor location when positioning debug text */
var() vector TargetOffset;

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
   bOutputToScreen=True
   bIncludeObjComment=True
   TargetDuration=-1.000000
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="String",PropertyName=,bHidden=True,MinVars=0)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Float",bHidden=True,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Bool",bHidden=True,MaxVars=255)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Object",bHidden=True,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Int",bHidden=True,MaxVars=255)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Target",PropertyName="Targets",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Log"
   ObjCategory="Misc"
   Name="Default__SeqAct_Log"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
