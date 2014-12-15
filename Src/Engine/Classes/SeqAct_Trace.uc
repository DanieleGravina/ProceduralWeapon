/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_Trace extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Should actors be traced against? */
var() bool bTraceActors;

/** Should the world be traced against? */
var() bool bTraceWorld;

/** What extent should be used for the trace? */
var() vector TraceExtent;

var() vector StartOffset, EndOffset;

var() editconst Object HitObject;
var() editconst float Distance;

defaultproperties
{
   bTraceWorld=True
   OutputLinks(0)=(LinkDesc="Not Obstructed")
   OutputLinks(1)=(LinkDesc="Obstructed")
   VariableLinks(0)=(LinkDesc="Start",PropertyName=)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="End",MinVars=1,MaxVars=255)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="HitObject",PropertyName="HitObject",bWriteable=True,MinVars=1,MaxVars=255)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Distance",PropertyName="Distance",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Trace"
   ObjCategory="Level"
   Name="Default__SeqAct_Trace"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
