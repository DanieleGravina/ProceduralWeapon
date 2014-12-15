/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetBool extends SeqAct_SetSequenceVariable
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() bool DefaultValue;

defaultproperties
{
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Bool',PropertyName=,bWriteable=True)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Value",MaxVars=255)
   ObjName="Bool"
   Name="Default__SeqAct_SetBool"
   ObjectArchetype=SeqAct_SetSequenceVariable'Engine.Default__SeqAct_SetSequenceVariable'
}
