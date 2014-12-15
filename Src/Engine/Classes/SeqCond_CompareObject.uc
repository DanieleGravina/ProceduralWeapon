/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqCond_CompareObject extends SequenceCondition
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   OutputLinks(0)=(LinkDesc="A == B")
   OutputLinks(1)=(LinkDesc="A != B")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="A",MinVars=1,MaxVars=255)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="B",MinVars=1,MaxVars=255)
   ObjName="Compare Objects"
   ObjCategory="Comparison"
   Name="Default__SeqCond_CompareObject"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
