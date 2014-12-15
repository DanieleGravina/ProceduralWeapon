/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_AttachToActor extends SequenceAction;

/** if true, then attachments will be detached. */
var() bool		bDetach;

/** Should hard attach to the actor */
var() bool		bHardAttach;

/** Bone Name to use for attachment */
var() Name		BoneName;

/** true if attachment should be set relatively to the target, using an offset */
var() bool		bUseRelativeOffset;

/** offset to use when attaching */
var() vector	RelativeOffset;

/** Use relative rotation offset */
var() bool		bUseRelativeRotation;

/** relative rotation */
var()	Rotator	RelativeRotation;

defaultproperties
{
   bHardAttach=True
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Attachment",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Attach to Actor"
   ObjCategory="Actor"
   Name="Default__SeqAct_AttachToActor"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
