/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqCond_CompareInt extends SequenceCondition
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

var() int ValueA;

var() int ValueB;

defaultproperties
{
   OutputLinks(0)=(LinkDesc="A <= B")
   OutputLinks(1)=(LinkDesc="A > B")
   OutputLinks(2)=(LinkDesc="A == B")
   OutputLinks(3)=(LinkDesc="A < B")
   OutputLinks(4)=(LinkDesc="A >= B")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="A",PropertyName="ValueA",MinVars=1,MaxVars=255)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="B",PropertyName="ValueB",MinVars=1,MaxVars=255)
   ObjName="Compare Int"
   ObjCategory="Comparison"
   Name="Default__SeqCond_CompareInt"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
