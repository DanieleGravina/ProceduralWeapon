/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetString extends SeqAct_SetSequenceVariable
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
var String Target;

/** Value to apply */
var() String Value;

defaultproperties
{
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_String',PropertyName="Target",bWriteable=True)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Value",PropertyName="Value",MinVars=1,MaxVars=255)
   ObjName="String"
   Name="Default__SeqAct_SetString"
   ObjectArchetype=SeqAct_SetSequenceVariable'Engine.Default__SeqAct_SetSequenceVariable'
}
