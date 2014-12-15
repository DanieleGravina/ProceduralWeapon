/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_PlayFaceFXAnim extends SequenceAction
	native(Sequence);

/** Reference to FaceFX AnimSet package the animation is in */
var()	FaceFXAnimSet	FaceFXAnimSetRef;

/**
 *	Name of group within the FaceFXAsset to find the animation in. Case sensitive.
 */
var()	string			FaceFXGroupName;

/** 
 *	Name of FaceFX animation within the specified group to play. Case sensitive.
 */
var()	string			FaceFXAnimName;

defaultproperties
{
   InputLinks(0)=(LinkDesc="Play")
   ObjName="Play FaceFX Anim"
   ObjCategory="Sound"
   Name="Default__SeqAct_PlayFaceFXAnim"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
