/**
 * Upon activation this action triggers the associated output link
 * of the owning Sequence.
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_FinishSequence extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Text label to use on the sequence output link */
var() string OutputLabel;

defaultproperties
{
   OutputLabel="Default Output"
   ObjName="Finish Sequence"
   ObjCategory="Misc"
   Name="Default__SeqAct_FinishSequence"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
