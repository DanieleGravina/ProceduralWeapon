/**
 * TextureRenderTarget
 *
 * Base for all render target texture resources
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class TextureRenderTarget extends Texture
	native
	abstract;

/** If true, initialise immediately instead of allowing deferred update. */
var	transient bool	bUpdateImmediate;

/** If true, there will be two copies in memory - one for the texture and one for the render target. If false, they will share memory if possible. This is useful for scene capture textures that are used in the scene. */
var() bool bNeedsTwoCopies;

/** If true, the render target will only be written to one time */
var() bool bRenderOnce;

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
   bNeedsTwoCopies=True
   CompressionNone=True
   NeverStream=True
   LODGroup=TEXTUREGROUP_RenderTarget
   Name="Default__TextureRenderTarget"
   ObjectArchetype=Texture'Engine.Default__Texture'
}
