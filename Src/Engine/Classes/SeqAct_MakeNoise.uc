/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


/** Causes target actor to make a noise that AI will hear */
class SeqAct_MakeNoise extends SequenceAction;

var() float Loudness;

defaultproperties
{
   Loudness=1.000000
   ObjClassVersion=2
   ObjName="MakeNoise"
   ObjCategory="AI"
   Name="Default__SeqAct_MakeNoise"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
