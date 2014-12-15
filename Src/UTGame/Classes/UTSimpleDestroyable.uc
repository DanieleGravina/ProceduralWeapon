/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTSimpleDestroyable extends DynamicSMActor
	abstract
	hidecategories(Collision);

/** Should go boom when shot. */
var()	bool	bDestroyOnDamage;

/** Should go boom when a player walks over it. */
var()	bool	bDestroyOnPlayerTouch;

/** Should go boom when a vehicle drives over it. */
var()	bool	bDestroyOnVehicleTouch;

/** Mesh to switch to when destroyed. */
var()	StaticMesh				MeshOnDestroy;

/** Sound to play when destroyed. */
var()	SoundCue				SoundOnDestroy;

/** Particles to play when destroyed. */
var()	ParticleSystem			ParticlesOnDestroy;

/** Static mesh to spawn as physics object when destroyed. */
var()	StaticMesh				SpawnPhysMesh;

/** How long the spawned physics object should last. */
var()	float					SpawnPhysMeshLifeSpan;

/** Initial linear velocity for spawned physics object. */
var()	vector					SpawnPhysMeshLinearVel;

/** initial angular velocity for spawned physics object. */
var()	vector					SpawnPhysMeshAngularVel;

/** Time between being destroyed and respawning. */
var()	float					RespawnTime;

/** Used to remember what mesh to set us back to when respawned. */
var		StaticMesh				RespawnStaticMesh;

/** Whether we are currently in the destroyed state. */
var		bool					bDestroyed;

/** Time before we are going to respawn. */
var		float					TimeToRespawn;

/** Used to shut down actor on the server to reduce overhead. */
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	// Remember what mesh we
	RespawnStaticMesh = StaticMeshComponent.StaticMesh;

	// If this is on dedicated server 
	if(WorldInfo.NetMode == NM_DedicatedServer)
	{
		SetCollision(FALSE, FALSE);
		DetachComponent(StaticMeshComponent);
		BeginState('IgnoreItAll');
	}
}

/** Do actual explosion. */
simulated function GoBoom()
{
	local UTSD_SpawnedKActor PhysMesh;

	// Swap/hide the mesh
	if(MeshOnDestroy != None)
	{
		StaticMeshComponent.SetStaticMesh(MeshOnDestroy);
	}
	else
	{
		StaticMeshComponent.SetStaticMesh(None);
		DetachComponent(StaticMeshComponent);
	}

	// Fire particles
	if(ParticlesOnDestroy != None)
	{
		WorldInfo.MyEmitterPool.SpawnEmitter(ParticlesOnDestroy, Location, Rotation);
	}

	// Play sound
	if(SoundOnDestroy != None)
	{
		PlaySound(SoundOnDestroy, TRUE);
	}

	// Spawn physics mesh
	if(SpawnPhysMesh != None)
	{
		PhysMesh = spawn(class'UTSD_SpawnedKActor',,,Location, Rotation);
		PhysMesh.StaticMeshComponent.SetStaticMesh(SpawnPhysMesh);
		PhysMesh.StaticMeshComponent.SetRBLinearVelocity(SpawnPhysMeshLinearVel, FALSE);
		PhysMesh.StaticMeshComponent.SetRBAngularVelocity(SpawnPhysMeshAngularVel, FALSE);
		PhysMesh.StaticMeshComponent.WakeRigidBody();

		// Have it collide with the world but thats it (ie not vehicles or players)
		PhysMesh.SetCollision(FALSE, FALSE);
		PhysMesh.StaticMeshComponent.SetRBChannel(RBCC_Nothing);
		PhysMesh.StaticMeshComponent.SetRBCollidesWithChannel(RBCC_Default, TRUE);

		// Set lifespan
		PhysMesh.LifeSpan = SpawnPhysMeshLifeSpan;
	}

	bDestroyed = TRUE;
	TimeToRespawn = RespawnTime;
	SetTimer(1.0, TRUE, 'CheckRespawn');
}

/** Put destructible back into pre-destroyed state. */
simulated function RespawnDestructible()
{
	// Reset static mesh and re-attach component.
	StaticMeshComponent.SetStaticMesh(RespawnStaticMesh);
	if(!StaticMeshComponent.bAttached)
	{
		AttachComponent(StaticMeshComponent);
	}

	bDestroyed = FALSE;
}

/** Called when shot. */
simulated function TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if(!bDestroyed && bDestroyOnDamage)
	{
		GoBoom();
	}
}

/** Called when overlapped by car/player */
simulated function Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	// Ignore if destroyed.
	if(bDestroyed)
	{
		return;
	}

	if( Vehicle(Other) != None )
	{
		if(bDestroyOnVehicleTouch)
		{
			GoBoom();
		}
	}
	else
	{
		if(bDestroyOnPlayerTouch)
		{
			GoBoom();
		}
	}
}

/** Used to countdown to respawn. */
simulated event CheckRespawn()
{
	// If destroyed, countdown to respawn.
	if(bDestroyed)
	{
		TimeToRespawn -= 1.0;

		if(TimeToRespawn < 0.f && (StaticMeshComponent.LastRenderTime < WorldInfo.TimeSeconds - 1.0f))
		{
			RespawnDestructible();
			ClearTimer('CheckRespawn');
		}
	}
}

/** State used to stop anything from happening on dedicated server. */
state IgnoreItAll
{
	ignores Touch, TakeDamage, Tick;
}

defaultproperties
{
   bDestroyOnDamage=True
   bDestroyOnPlayerTouch=True
   bDestroyOnVehicleTouch=True
   SpawnPhysMeshLifeSpan=5.000000
   RespawnTime=30.000000
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__DynamicSMActor:StaticMeshComponent0'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTSimpleDestroyable:MyLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      BlockActors=False
      ObjectArchetype=StaticMeshComponent'Engine.Default__DynamicSMActor:StaticMeshComponent0'
   End Object
   StaticMeshComponent=StaticMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor:MyLightEnvironment'
      bDynamic=False
      bEnabled=True
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicSMActor:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Components(0)=MyLightEnvironment
   Components(1)=StaticMeshComponent0
   bNoDelete=True
   bCollideActors=True
   bProjTarget=True
   bPathColliding=False
   CollisionComponent=StaticMeshComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTSimpleDestroyable"
   ObjectArchetype=DynamicSMActor'Engine.Default__DynamicSMActor'
}
