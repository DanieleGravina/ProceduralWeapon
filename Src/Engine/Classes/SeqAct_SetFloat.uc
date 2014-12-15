/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetFloat extends SeqAct_SetSequenceVariable
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var float Target;

var() float Value;

defaultproperties
{
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Float',PropertyName="Target",bWriteable=True)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Value",PropertyName="Value",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Float"
   Name="Default__SeqAct_SetFloat"
   ObjectArchetype=SeqAct_SetSequenceVariable'Engine.Default__SeqAct_SetSequenceVariable'
}
