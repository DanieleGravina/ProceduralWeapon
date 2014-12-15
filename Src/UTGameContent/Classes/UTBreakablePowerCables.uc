/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTBreakablePowerCables extends Actor
	placeable
	hidecategories(Collision);


var()	SkeletalMeshComponent	Mesh;
var()	StaticMeshComponent		BoxComp;
var		ParticleSystemComponent	SparkComponent0;
var		ParticleSystemComponent	SparkComponent1;
var		PointLightComponent		SparkLight;
var		AudioComponent			SparkNoise;

var		AnimNodeSequence		AnimNode;

var		ParticleSystem			BreakEffect;

var		bool					bBroken;

var		vector2D				ReSparkInterval;
var		float					TimeToRespawn;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	// If this is on dedicated server, detach all components and basically shut down
	if(WorldInfo.NetMode == NM_DedicatedServer)
	{
		SetCollision(FALSE, FALSE);
		DetachComponent(Mesh);
		DetachComponent(BoxComp);
		DetachComponent(SparkLight);
		DetachComponent(SparkNoise);
		BeginState('IgnoreItAll');
	}
	// If not dedicated - attach particle components to ends of cable
	else
	{
		Mesh.AttachComponent(SparkComponent0, 'BoneEndL');
		Mesh.AttachComponent(SparkLight, 'BoneEndL');
		Mesh.AttachComponent(SparkNoise, 'BoneEndL');
		Mesh.AttachComponent(SparkComponent1, 'BoneEndR');

		// Cache pointer to AnimNodeSequence
		AnimNode = AnimNodeSequence(Mesh.Animations);
	}
}

/** State used to stop anything from happening on dedicated server. */
state IgnoreItAll
{
	ignores Touch, TakeDamage, Tick;
}

/** Something has touched the cable - do all the effects and stuff! */
simulated function BreakCable()
{
	local vector BreakPos;
	local float SparkTime;

	// Play animation of cable breaking
	AnimNode.PlayAnim(FALSE, 1.0, 0.0);

	// Get location in middle of rope
	BreakPos = Mesh.GetBoneLocation('BoneEndL');

	// Play sparky sound
	SparkNoise.SoundCue = SoundCue'A_Ambient_NonLoops.HiTech.spark_large_LargeRadius_Cue';
	SparkNoise.Play();

	// Play big spark effect
	WorldInfo.MyEmitterPool.SpawnEmitter(BreakEffect, BreakPos);

	// Make emitter on each end of the cable spark
	SparkComponent0.SetActive(true);
	SparkComponent1.SetActive(true);
	SetTimer(0.3, FALSE, 'TurnOffSparkEffects');

	// Turn on light, and set timer to turn it off again
	SparkLight.SetEnabled(TRUE);
	SetTimer(0.2, FALSE, 'TurnOffSparkLight');

	// Set flag to indicate cables are broken
	bBroken = TRUE;

	// Start a timer for causing extra sparks from the cables
	SparkTime = RandRange(ReSparkInterval.X, ReSparkInterval.Y);
	SetTimer(SparkTime, FALSE, 'SparkCable');

	// Start a countdown to resetting the cables.
	TimeToRespawn = 30.0;
	SetTimer(1.0, TRUE, 'CheckRespawn');

	// Turn off collision now
	SetCollision(FALSE, FALSE);
}

/** */
simulated function TurnOffSparkLight()
{
	SparkLight.SetEnabled(FALSE);
}

/** */
simulated function TurnOffSparkEffects()
{
	SparkComponent0.DeactivateSystem();
	SparkComponent1.DeactivateSystem();
}

/** */
simulated function SparkCable()
{
	local float SparkTime;

	SparkComponent0.SetActive(true);
	SparkComponent1.SetActive(true);
	SetTimer(0.3, FALSE, 'TurnOffSparkEffects');

	SparkNoise.Stop();
	SparkNoise.SoundCue = SoundCue'A_Ambient_NonLoops.HiTech.spark_small_Cue';
	SparkNoise.Play();

	AnimNode.SetAnim( (FRand() < 0.5) ? 'Spark1' : 'Spark2' );
	AnimNode.PlayAnim(FALSE, 1.0, 0.0);

	SparkTime = RandRange(ReSparkInterval.X, ReSparkInterval.Y);
	SetTimer(SparkTime, FALSE, 'SparkCable');
}

/** Used to countdown to respawn. */
simulated event CheckRespawn()
{
	// If destroyed, countdown to respawn.
	if(bBroken)
	{
		TimeToRespawn -= 1.0;

		if(TimeToRespawn < 0.f && (Mesh.LastRenderTime < WorldInfo.TimeSeconds - 1.0f))
		{
			// Put cable back to start position
			AnimNode.SetAnim('Break');
			AnimNode.SetPosition(0.0, FALSE);

			// Turn off sparkinf and respawning timers
			ClearTimer('SparkCable');
			ClearTimer('CheckRespawn');

			// Turn collision back on
			SetCollision(TRUE, FALSE);

			// Reset flag
			bBroken = FALSE;
		}
	}
}

/** Look for vehicles touching the cable. */
simulated function Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	if(bBroken)
	{
		return;
	}

	if( Vehicle(Other) != None )
	{
		BreakCable();
	}
};

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=MySkeletalMeshComponent ObjName=MySkeletalMeshComponent Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'Envy_Level_Effects_2.DM_HeatRay.SK_PowerWire'
      Begin Object Class=AnimNodeSequence Name=MySeqNode ObjName=MySeqNode Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         AnimSeqName="Break"
         Name="MySeqNode"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTBreakablePowerCables:MySeqNode'
      AnimSets(0)=AnimSet'Envy_Level_Effects_2.DM_HeatRay.K_PowerWire_Anims'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTBreakablePowerCables:MyLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      Name="MySkeletalMeshComponent"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=MySkeletalMeshComponent
   Begin Object Class=StaticMeshComponent Name=MyCollisionComp ObjName=MyCollisionComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'UN_SimpleMeshes.TexPropCube_Dup'
      HiddenGame=True
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=244.000000)
      Scale3D=(X=4.000000,Y=0.050000,Z=0.130000)
      Name="MyCollisionComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   BoxComp=MyCollisionComp
   Begin Object Class=ParticleSystemComponent Name=MySparkComponent0 ObjName=MySparkComponent0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'Envy_Level_Effects_2.DM_HeatRay.P_PowerWire_Sparks_01'
      bAutoActivate=False
      Name="MySparkComponent0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   SparkComponent0=MySparkComponent0
   Begin Object Class=ParticleSystemComponent Name=MySparkComponent1 ObjName=MySparkComponent1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'Envy_Level_Effects_2.DM_HeatRay.P_PowerWire_Sparks_01'
      bAutoActivate=False
      Name="MySparkComponent1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   SparkComponent1=MySparkComponent1
   Begin Object Class=PointLightComponent Name=MySparkLight ObjName=MySparkLight Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      FalloffExponent=4.000000
      Brightness=8.000000
      bEnabled=False
      CastShadows=False
      Name="MySparkLight"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   SparkLight=MySparkLight
   Begin Object Class=AudioComponent Name=MySparkNoise ObjName=MySparkNoise Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Ambient_NonLoops.HiTech.spark_large_LargeRadius_Cue'
      VolumeMultiplier=5.000000
      Name="MySparkNoise"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   SparkNoise=MySparkNoise
   BreakEffect=ParticleSystem'Envy_Level_Effects_2.DM_HeatRay.P_PowerWireBreak_Spark'
   ReSparkInterval=(X=1.000000,Y=2.000000)
   Components(0)=MyCollisionComp
   Components(1)=MySparkNoise
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bDynamic=False
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(2)=MyLightEnvironment
   Components(3)=MySkeletalMeshComponent
   RemoteRole=ROLE_SimulatedProxy
   bNoDelete=True
   bCollideActors=True
   CollisionComponent=MyCollisionComp
   Name="Default__UTBreakablePowerCables"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
