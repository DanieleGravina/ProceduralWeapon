//=============================================================================
// ParticleModuleLocationEmitter
//
// A location module that uses particles from another emitters particles as
// spawn points for its particles.
//
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class ParticleModuleLocationEmitter extends ParticleModuleLocationBase
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

//=============================================================================
// Variables
//=============================================================================
// LocationEmitter

// The source emitter for spawn locations
var(Location)						export		noclear	name					EmitterName;

// The method to use when selecting a spawn target particle from the emitter
enum ELocationEmitterSelectionMethod
{
	ELESM_Random,
	ELESM_Sequential
};
var(Location)	ELocationEmitterSelectionMethod									SelectionMethod;

var(Location)	bool															InheritSourceVelocity;
var(Location)	float															InheritSourceVelocityScale;
var(Location)	bool															bInheritSourceRotation;
var(Location)	float															InheritSourceRotationScale;

//=============================================================================
// C++ functions
//=============================================================================
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

//=============================================================================
// Script functions
//=============================================================================

//=============================================================================
// Default properties
//=============================================================================

defaultproperties
{
   InheritSourceVelocityScale=1.000000
   InheritSourceRotationScale=1.000000
   bSpawnModule=True
   Name="Default__ParticleModuleLocationEmitter"
   ObjectArchetype=ParticleModuleLocationBase'Engine.Default__ParticleModuleLocationBase'
}
