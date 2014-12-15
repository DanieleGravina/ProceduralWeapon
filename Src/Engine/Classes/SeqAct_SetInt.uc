/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetInt extends SeqAct_SetSequenceVariable
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Target property use to write to */
var int Target;

/** Value to apply */
var() int Value;

defaultproperties
{
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Int',PropertyName="Target",bWriteable=True)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Value",PropertyName="Value",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Int"
   Name="Default__SeqAct_SetInt"
   ObjectArchetype=SeqAct_SetSequenceVariable'Engine.Default__SeqAct_SetSequenceVariable'
}
