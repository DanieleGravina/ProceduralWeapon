/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_AddFloat extends SeqAct_SetSequenceVariable
	native(Sequence);

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

var() float ValueA;
var() float ValueB;
var float FloatResult;
var int IntResult;

defaultproperties
{
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="A",PropertyName="ValueA")
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="B",PropertyName="ValueB",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="FloatResult",PropertyName="FloatResult",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="IntResult",PropertyName="IntResult",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Add Float"
   ObjCategory="Math"
   Name="Default__SeqAct_AddFloat"
   ObjectArchetype=SeqAct_SetSequenceVariable'Engine.Default__SeqAct_SetSequenceVariable'
}
