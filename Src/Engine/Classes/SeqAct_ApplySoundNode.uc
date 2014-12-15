/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_ApplySoundNode extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() SoundCue PlaySound;
var() editinline SoundNode ApplyNode;

defaultproperties
{
   ObjName="Apply Sound Node"
   ObjCategory="Sound"
   Name="Default__SeqAct_ApplySoundNode"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
