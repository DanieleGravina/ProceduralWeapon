/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ParticleModuleTypeDataBase extends ParticleModule
	native(Particle)
	editinlinenew
	collapsecategories
	hidecategories(Object)
	abstract;


enum FluidEmitterType
{
	FET_CONSTANT_FLOW,
	FET_CONSTANT_PRESSURE,
	FET_FILL_OWNER_VOLUME,
};

enum FluidEmitterShape
{
	FES_RECTANGLE,
	FES_ELLIPSE,
};

enum FluidSimulationMethod
{
	FSM_SPH,
	FSM_NO_PARTICLE_INTERACTION,
	FSM_MIXED_MODE
};

enum FluidPacketSizeMultiplier
{
	FPSM_4,
	FPSM_8,
	FPSM_16,
	FPSM_32,
	FPSM_64,
	FPSM_128
};





struct native PhysXFluidTypeData
{
	var(Fluid) int                              FluidMaxParticles;
	var(Fluid) int                              FluidNumReserveParticles;
	var(Fluid) float                            FluidRestParticlesPerMeter;
	var(Fluid) float                            FluidRestDensity;
	var(Fluid) float                            FluidKernelRadiusMultiplier;
	var(Fluid) float                            FluidMotionLimitMultiplier;
	var(Fluid) float                            FluidCollisionDistanceMultiplier;
	var(Fluid) FluidPacketSizeMultiplier        FluidPacketSizeMultiplier;
	var(Fluid) float                            FluidStiffness;
	var(Fluid) float                            FluidViscosity;
	var(Fluid) float                            FluidDamping;
	var(Fluid) float                            FluidFadeInTime;
	var(Fluid) vector                           FluidExternalAcceleration;
	var(Fluid) float                            FluidStaticCollisionRestitution;
	var(Fluid) float                            FluidStaticCollisionAdhesion;
	var(Fluid) float                            FluidStaticCollisionAttraction;
	var(Fluid) float                            FluidDynamicCollisionRestitution;
	var(Fluid) float                            FluidDynamicCollisionAdhesion;
	var(Fluid) float                            FluidDynamicCollisionAttraction;
	var(Fluid) float                            FluidCollisionResponseCoefficient;
	var(Fluid) FluidSimulationMethod            FluidSimulationMethod;
	var(Fluid) bool                             bFluidStaticCollision;
	var(Fluid) bool                             bFluidDynamicCollision;
	var(Fluid) bool                             bFluidTwoWayCollision;
	var(Fluid) bool								bDisableGravity;

	var(Fluid) int								FluidPacketMaxCount;
	var(Fluid) int								FluidPacketMinParticleCount;

	var(FluidForceField) float					FluidForceScale;

	var(FluidEmitter) FluidEmitterType          FluidEmitterType;
	var(FluidEmitter) int                       FluidEmitterMaxParticles;
	var(FluidEmitter) FluidEmitterShape         FluidEmitterShape;
	var(FluidEmitter) float                     FluidEmitterDimensionX;
	var(FluidEmitter) float                     FluidEmitterDimensionY;
	var(FluidEmitter) vector                    FluidEmitterRandomPos;
	var(FluidEmitter) float                     FluidEmitterRandomAngle;
	var(FluidEmitter) float                     FluidEmitterFluidVelocityMagnitude;
	var(FluidEmitter) float                     FluidEmitterRate;
	var(FluidEmitter) float                     FluidEmitterParticleLifetime;
	var(FluidEmitter) float                     FluidEmitterRepulsionCoefficient;

	var native pointer                          NovodexFluid{class NxFluid};
	var native pointer                          RBPhysScene{class FRBPhysScene};
	var native pointer                          PrimaryEmitter{class NxFluidEmitter};

	var native int                              FluidNumParticles;
	var native int                              FluidNumCreated;
	var native int                              FluidNumDeleted;
	var native pointer                          FluidIDCreationBuffer{DWORD};
	var native pointer                          FluidIDDeletionBuffer{DWORD};
	var native pointer                          FluidParticleBuffer{class NxFluidParticle};
	var native pointer                          FluidParticleBufferEx{class NxFluidParticleEx};
	var native pointer                          FluidParticleContacts{class NxVec3};

	var native pointer							ParticleRanks{WORD};

	var native pointer                          FluidAddParticlePos{class NxVec3};
	var native pointer                          FluidAddParticleVel{class NxVec3};
	var native pointer                          FluidAddParticleLife{FLOAT};

	var native int								FluidNumParticlePackets;
	var native pointer							FluidParticlePacketData{struct NxFluidPacket};

	var native int								FluidNumParticleForceUpdate;
	var native pointer							FluidParticleForceUpdate{class FVector};
	var bool									bFluidApplyParticleForceUpdates;
	
	var	native bool								bNeedsExtendedParticleData;
	var native bool								bNeedsParticleContactData;
	var native bool								bNeedsParticleRanks;

	var native pointer							ParticleDataTransfer{BYTE};
	var native pointer							ParticleIndicesTransfer{WORD};
	var native pointer							InstanceDataTransfer{BYTE};
	var native int								ActiveParticlesTransfer;
	var native int								MaxActiveParticlesTransfer;

	structcpptext
	{
		FPhysXFluidTypeData();
		~FPhysXFluidTypeData();

		void					PostEditChange(void);
		void					FinishDestroy(void);

		void					UpdatePrimaryEmitter(void);

		class NxFluidEmitter*	CreateEmitter(FPhysXEmitterInstance &Instance);

		void					ReleaseEmitter(class NxFluidEmitter &emitter);
		void					TickEmitter(class NxFluidEmitter &emitter, FLOAT DeltaTime);

		 
		void					AddForceField(class NxFluidEmitter &emitter, class FForceApplicator* Applicator, const FBox& FieldBoundingBox);
	
		 
		void					ApplyParticleForces(class NxFluidEmitter &emitter);

		 
		void					FillVolume(class AActor &BaseActor);

		void					CaptureParticleData( struct FParticleEmitterInstance * EmitterInstance );
		void					RestoreParticleData( struct FParticleEmitterInstance * EmitterInstance );	
	}

	structdefaultproperties
	{
		FluidMaxParticles = 1000
		FluidNumReserveParticles = 0
		FluidRestParticlesPerMeter = 5.0
		FluidRestDensity = 1000.0
		FluidKernelRadiusMultiplier = 1.2
		FluidMotionLimitMultiplier = 3.6  
		FluidCollisionDistanceMultiplier = 0.12 
		FluidPacketSizeMultiplier = FPSM_16
		FluidStiffness = 20.0
		FluidViscosity = 6.0
		FluidDamping = 0.0
		FluidFadeInTime = 0.0
		FluidExternalAcceleration = (X=0.0,Y=0.0,Z=0.0)
		FluidStaticCollisionRestitution = 0.5
		FluidStaticCollisionAdhesion = 0.05
		FluidStaticCollisionAttraction = 0.0
		FluidDynamicCollisionRestitution = 0.5
		FluidDynamicCollisionAdhesion = 0.5
		FluidDynamicCollisionAttraction = 0.0
		FluidCollisionResponseCoefficient = 0.2
		FluidSimulationMethod = FSM_NO_PARTICLE_INTERACTION
		bFluidStaticCollision = true
		bFluidDynamicCollision = false
		bFluidTwoWayCollision = false
		bDisableGravity = false

		FluidPacketMaxCount = 0
		FluidPacketMinParticleCount = 0

		FluidForceScale = 1.0
			
		FluidEmitterType = FET_CONSTANT_PRESSURE
		FluidEmitterMaxParticles = 1000
		FluidEmitterShape = FES_RECTANGLE
		FluidEmitterDimensionX = 12.5
		FluidEmitterDimensionY = 12.5
		FluidEmitterRandomPos = (X=0.0,Y=0.0,Z=0.0)
		FluidEmitterRandomAngle = 0.0
		FluidEmitterFluidVelocityMagnitude = 50.0
		FluidEmitterRate = 100.0
		FluidEmitterParticleLifetime = 5.0
		FluidEmitterRepulsionCoefficient = 1.0
		
		bNeedsExtendedParticleData = false
		bNeedsParticleContactData = false
	}
};
#linenumber 11

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
   Name="Default__ParticleModuleTypeDataBase"
   ObjectArchetype=ParticleModule'Engine.Default__ParticleModule'
}
