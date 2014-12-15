/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class FlockTestActor extends Actor
	native
	placeable;

var()	FlockTest_Spawner	Spawner;

var		NavigationPoint	TargetNav;

var() enum EAgentMoveState
{
	EAMS_Move,
	EAMS_Idle
} AgentState;

var		float	NextChangeTargetTime;
var		float	EndActionTime;
var		float	NextActionTime;
var		float	VelDamping;

var		rotator		ToTargetRot;
var		bool	bRotateToTargetRot;
var		bool	bHadNearbyTarget;

var()	SkeletalMeshComponent			SkeletalMeshComponent;
var()	SkeletalMeshComponent			AttachmentComponent;

var		AnimNodeBlend					SpeedBlendNode;
var		AnimNodeBlend					ActionBlendNode;
var		AnimNodeSequence				ActionSeqNode;
var		AnimNodeSequence				WalkSeqNode;
var		AnimNodeSequence				RunSeqNode;

var() const editconst LightEnvironmentComponent LightEnvironment;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event Destroyed()
{
	Super.Destroyed();

	// Decrement counter on the spawner, so more can spawn.
	Spawner.NumSpawned--;
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__FlockTestActor:MyLightEnvironment'
      bCastDynamicShadow=False
      CollideActors=True
      BlockZeroExtent=True
      RBChannel=RBCC_GameplayPhysics
      RBCollideWithChannels=(Default=True,GameplayPhysics=True,EffectPhysics=True)
      Name="SkeletalMeshComponent0"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   SkeletalMeshComponent=SkeletalMeshComponent0
   Begin Object Class=SkeletalMeshComponent Name=AttachmentComponent0 ObjName=AttachmentComponent0 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      bCastDynamicShadow=False
      Name="AttachmentComponent0"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   AttachmentComponent=AttachmentComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bEnabled=False
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   LightEnvironment=MyLightEnvironment
   Components(0)=MyLightEnvironment
   Components(1)=SkeletalMeshComponent0
   Physics=PHYS_Flying
   bDestroyInPainVolume=True
   bCollideActors=True
   bProjTarget=True
   bNoEncroachCheck=True
   CollisionComponent=SkeletalMeshComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__FlockTestActor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
