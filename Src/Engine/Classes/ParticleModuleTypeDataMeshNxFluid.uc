/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleTypeDataMeshNxFluid extends ParticleModuleTypeDataMesh
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object);

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

enum FluidMeshRotationMethod
{
	FMRM_DISABLED,
	FMRM_SPHERICAL,
	FMRM_BOX,
	FMRM_LONG_BOX,
	FMRM_FLAT_BOX,
};

var() editinline	PhysXFluidTypeData		PhysXFluid;

var(Fluid) const FluidMeshRotationMethod			FluidRotationMethod;	// Made const since some methods require contact buffer allocation
var(Fluid) float									FluidRotationCoefficient;

defaultproperties
{
   PhysXFluid=(FluidMaxParticles=1000,FluidRestParticlesPerMeter=5.000000,FluidRestDensity=1000.000000,FluidKernelRadiusMultiplier=1.200000,FluidMotionLimitMultiplier=3.600000,FluidCollisionDistanceMultiplier=0.120000,FluidPacketSizeMultiplier=FPSM_16,FluidStiffness=20.000000,FluidViscosity=6.000000,FluidStaticCollisionRestitution=0.500000,FluidStaticCollisionAdhesion=0.050000,FluidDynamicCollisionRestitution=0.500000,FluidDynamicCollisionAdhesion=0.500000,FluidCollisionResponseCoefficient=0.200000,FluidSimulationMethod=FSM_NO_PARTICLE_INTERACTION,bFluidStaticCollision=True,FluidForceScale=1.000000,FluidEmitterType=FET_CONSTANT_PRESSURE,FluidEmitterMaxParticles=1000,FluidEmitterDimensionX=12.500000,FluidEmitterDimensionY=12.500000,FluidEmitterFluidVelocityMagnitude=50.000000,FluidEmitterRate=100.000000,FluidEmitterParticleLifetime=5.000000,FluidEmitterRepulsionCoefficient=1.000000)
   FluidRotationMethod=FMRM_SPHERICAL
   FluidRotationCoefficient=5.000000
   Name="Default__ParticleModuleTypeDataMeshNxFluid"
   ObjectArchetype=ParticleModuleTypeDataMesh'Engine.Default__ParticleModuleTypeDataMesh'
}
