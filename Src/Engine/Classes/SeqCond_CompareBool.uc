/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqCond_CompareBool extends SequenceCondition
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   OutputLinks(0)=(LinkDesc="True")
   OutputLinks(1)=(LinkDesc="False")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="Bool",MinVars=1,MaxVars=255)
   ObjName="Compare Bool"
   ObjCategory="Comparison"
   Name="Default__SeqCond_CompareBool"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
