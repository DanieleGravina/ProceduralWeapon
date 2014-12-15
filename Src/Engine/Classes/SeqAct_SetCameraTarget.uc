/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_SetCameraTarget extends SequenceAction
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Internal.  Holds a ref to the new desired camera target. */
var transient Actor		CameraTarget;

/** Parameters that define how the camera will transition to the new target. */
var() const Camera.ViewTargetTransitionParams	TransitionParams;

defaultproperties
{
   TransitionParams=(BlendFunction=VTBlend_Cubic,BlendExp=2.000000)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Cam Target",MinVars=1,MaxVars=255)
   ObjClassVersion=2
   ObjName="Set Camera Target"
   ObjCategory="Camera"
   Name="Default__SeqAct_SetCameraTarget"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
