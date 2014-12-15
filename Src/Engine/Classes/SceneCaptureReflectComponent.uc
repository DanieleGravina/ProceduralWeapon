/**
 * SceneCaptureReflectComponent
 *
 * Captures the reflection of the current view to a
 * 2D texture render target.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SceneCaptureReflectComponent extends SceneCaptureComponent
	native;

/** render target resource to set as target for capture */
var(Capture) TextureRenderTarget2D TextureTarget;
/** scale field of view so that there can be some overdraw */
var(Capture) float ScaleFOV;

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

defaultproperties
{
   ScaleFOV=1.000000
   FrameRate=1000.000000
   Name="Default__SceneCaptureReflectComponent"
   ObjectArchetype=SceneCaptureComponent'Engine.Default__SceneCaptureComponent'
}
