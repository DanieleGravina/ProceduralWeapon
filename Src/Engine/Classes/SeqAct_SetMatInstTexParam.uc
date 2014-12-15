/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetMatInstTexParam extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() MaterialInstanceConstant	MatInst;
var() Texture					NewTexture;
var() Name						ParamName;

defaultproperties
{
   ObjName="Set TextureParam"
   ObjCategory="Material Instance"
   Name="Default__SeqAct_SetMatInstTexParam"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
