/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

// Used to provide an extended PSysComponent to allow collision to function in the preview window.
class CascadeParticleSystemComponent extends ParticleSystemComponent
	native(Cascade)
	hidecategories(Object)
	hidecategories(Physics)
	hidecategories(Collision)
	editinlinenew;

var		native		const	pointer									CascadePreviewViewportPtr{class FCascadePreviewViewportClient};

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Name="Default__CascadeParticleSystemComponent"
   ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
}
