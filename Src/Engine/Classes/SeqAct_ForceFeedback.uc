/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class SeqAct_ForceFeedback extends SequenceAction;

var() editinline ForceFeedbackWaveform FFWaveform;

defaultproperties
{
   InputLinks(0)=(LinkDesc="Start")
   InputLinks(1)=(LinkDesc="Stop")
   ObjName="Force Feedback"
   ObjCategory="Misc"
   Name="Default__SeqAct_ForceFeedback"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
