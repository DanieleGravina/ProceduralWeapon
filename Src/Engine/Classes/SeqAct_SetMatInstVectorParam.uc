/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetMatInstVectorParam extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() MaterialInstanceConstant	MatInst;
var() Name						ParamName;

var() LinearColor VectorValue;

defaultproperties
{
   VectorValue=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   ObjName="Set VectorParam"
   ObjCategory="Material Instance"
   Name="Default__SeqAct_SetMatInstVectorParam"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
