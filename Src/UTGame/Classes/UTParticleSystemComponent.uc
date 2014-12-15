/**
 * Special Particle system component that can handle rendering at a different FOV than the the world.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTParticleSystemComponent extends ParticleSystemComponent
	native;

/** Used when a custom FOV is set to make sure the particles render properly using the custom FOV */
var public{private} const float FOV;
var public{private} const bool bHasSavedScale3D;
var public{private} const vector SavedScale3D;


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)


/** This changes the FOV used for rendering the particle system component. A value of 0 means to use the default. */
native final function SetFOV(float NewFOV);

defaultproperties
{
   bOverrideLODMethod=True
   SecondsBeforeInactive=1.000000
   LODMethod=PARTICLESYSTEMLODMETHOD_DirectSet
   Name="Default__UTParticleSystemComponent"
   ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
}
