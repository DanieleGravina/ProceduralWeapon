/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * UT-specific CameraAnim action to provide for stopping a playing cameraanim.
 */

class UTSeqAct_StopCameraAnim extends SequenceAction;

/** True to stop immediately, regardless of BlendOutTime specified when the anim was played. */
var()	bool		bStopImmediately;

defaultproperties
{
   ObjName="Stop Camera Animation"
   ObjCategory="Camera"
   Name="Default__UTSeqAct_StopCameraAnim"
   ObjectArchetype=SequenceAction'Engine.Default__SequenceAction'
}
