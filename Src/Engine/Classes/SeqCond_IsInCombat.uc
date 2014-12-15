/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class SeqCond_IsInCombat extends SequenceCondition
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   OutputLinks(0)=(LinkDesc="True")
   OutputLinks(1)=(LinkDesc="False")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Players",MinVars=1,MaxVars=255)
   ObjName="In Combat"
   Name="Default__SeqCond_IsInCombat"
   ObjectArchetype=SequenceCondition'Engine.Default__SequenceCondition'
}
