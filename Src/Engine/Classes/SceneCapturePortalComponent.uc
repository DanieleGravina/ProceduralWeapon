/**
 * SceneCapturePortalComponent
 *
 * Captures the scene as if viewed through a portal to a
 * 2D texture render target.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SceneCapturePortalComponent extends SceneCaptureComponent
	native;

/** render target resource to set as target for capture */
var(Capture) const TextureRenderTarget2D TextureTarget;
/** scale field of view so that there can be some overdraw */
var(Capture) const float ScaleFOV;
/** actor at the target view location for this portal
 * (this will be the point where the scene is captured from) */
var(Capture) const Actor ViewDestination;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** interface for changing TextureTarget, ScaleFOV, and ViewDestination */
native noexport final function SetCaptureParameters( optional TextureRenderTarget2D NewTextureTarget = TextureTarget,
							optional float NewScaleFOV = ScaleFOV, optional Actor NewViewDest = ViewDestination );

defaultproperties
{
   ScaleFOV=1.000000
   bSkipUpdateIfOwnerOccluded=True
   FrameRate=1000.000000
   Name="Default__SceneCapturePortalComponent"
   ObjectArchetype=SceneCaptureComponent'Engine.Default__SceneCaptureComponent'
}
