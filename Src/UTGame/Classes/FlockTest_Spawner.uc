/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class FlockTest_Spawner extends Actor
	native
	abstract;

// Spawner stuff
var()	bool	bActive;
var()	float	SpawnRate;
var()	int		SpawnNum;
var()	float	Radius;

var		float	Remainder;
var		int		NumSpawned;

// Agent force stuff
var()	float	AwareRadius;


var()	float	ToCentroidStrength;

var()	float	AvoidOtherStrength;
var()	float	AvoidOtherRadius;

var()	float	MatchVelStrength;

var()	float	ToTargetStrength;
var()	float	ChangeTargetInterval;

var()	float	ToPathStrength;
var()	float	FollowPathStrength;

var()	vector	CrowdAcc;

var()	float	MinVelDamping;
var()	float	MaxVelDamping;

// Agent animation stuff
var(Action)		RawDistributionFloat	ActionDuration;
var(Action)		RawDistributionFloat	ActionInterval;
var(Action)		RawDistributionFloat	TargetActionInterval;
var(Action)		array<name>				ActionAnimNames;
var(Action)		array<name>				TargetActionAnimNames;
var(Action)		float					ActionBlendTime;
var(Action)		float					ReActionDelay;
var(Action)		float					RotateToTargetSpeed;

var()	float	SpeedBlendStart;
var()	float	SpeedBlendEnd;

var()	float	WalkVelThresh;

var()	float	AnimVelRate;
var()	float	MaxYawRate;

var()	array<SkeletalMesh>	FlockMeshes;
var()	array<AnimSet>	FlockAnimSets;
var()	name			WalkAnimName;
var()	name			RunAnimName;
var()	AnimTree		FlockAnimTree;

var(AttachMesh)		array<SkeletalMesh> AttachmentMeshes;
var(AttachMesh)		name				AttachmentSocket;

var(Lighting)		LightingChannelContainer	FlockLighting;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event Tick(float DeltaSeconds)
{
	local rotator	Rot;
	local vector	SpawnPos;
	local FlockTestActor	Agent;
	local SkeletalMesh	AttachMesh;

	if(NumSpawned >= SpawnNum || !bActive)
	{
		return;
	}

	Remainder += (DeltaSeconds * SpawnRate);

	while(Remainder > 1.0 && NumSpawned < SpawnNum)
	{
		Rot = RotRand(false);
		Rot.Pitch = 0;

		SpawnPos = Location + ((vect(1,0,0) * FRand() * Radius) >> Rot);
		Agent = Spawn( class'UTGame.FlockTestActor',,,SpawnPos);

		Agent.SkeletalMeshComponent.AnimSets = FlockAnimSets;
		Agent.SkeletalMeshComponent.SetSkeletalMesh( FlockMeshes[Rand(FlockMeshes.length)] );
		Agent.SkeletalMeshComponent.SetAnimTreeTemplate(FlockAnimTree);
		Agent.SkeletalMeshComponent.SetLightingChannels(FlockLighting);

		AttachMesh = AttachmentMeshes[Rand(AttachmentMeshes.length)];
		if(AttachMesh != None)
		{
			Agent.AttachmentComponent.SetSkeletalMesh(AttachMesh);
			Agent.SkeletalMeshComponent.AttachComponentToSocket(Agent.AttachmentComponent, AttachmentSocket);
		}

		// Cache pointers to anim nodes
		Agent.SpeedBlendNode = AnimNodeBlend(Agent.SkeletalMeshComponent.Animations.FindAnimNode('SpeedBlendNode'));
		Agent.ActionBlendNode = AnimNodeBlend(Agent.SkeletalMeshComponent.Animations.FindAnimNode('ActionBlendNode'));
		Agent.ActionSeqNode = AnimNodeSequence(Agent.SkeletalMeshComponent.Animations.FindAnimNode('ActionSeqNode'));
		Agent.WalkSeqNode = AnimNodeSequence(Agent.SkeletalMeshComponent.Animations.FindAnimNode('WalkSeqNode'));
		Agent.RunSeqNode = AnimNodeSequence(Agent.SkeletalMeshComponent.Animations.FindAnimNode('RunSeqNode'));

		Agent.WalkSeqNode.SetAnim(WalkAnimName);
		Agent.RunSeqNode.SetAnim(RunAnimName);

		Agent.VelDamping = MinVelDamping + (FRand() * (MaxVelDamping - MinVelDamping));
		Agent.Spawner = self;

		Remainder -= 1.0;
		NumSpawned++;
	}
}


simulated function OnToggle(SeqAct_Toggle action)
{
	if (!bStatic)
	{
		if (action.InputLinks[0].bHasImpulse)
		{
			// turn on
			bActive = true;
		}
		else if (action.InputLinks[1].bHasImpulse)
		{
			// turn off
			bActive = false;
		}
		else if (action.InputLinks[2].bHasImpulse)
		{
			// toggle
			bActive = !bActive;
		}
	}
}

defaultproperties
{
   bActive=True
   SpawnRate=10.000000
   SpawnNum=100
   Radius=200.000000
   AwareRadius=200.000000
   AvoidOtherStrength=1500.000000
   AvoidOtherRadius=100.000000
   MatchVelStrength=0.600000
   ToTargetStrength=150.000000
   ChangeTargetInterval=30.000000
   ToPathStrength=200.000000
   FollowPathStrength=30.000000
   MinVelDamping=0.001000
   MaxVelDamping=0.003000
   ActionDuration=(Distribution=DistributionActionDuration,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(0.800000,1.200000,0.800000,1.200000,0.800000,1.200000))
   ActionInterval=(Distribution=DistributionActionInterval,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(10.000000,20.000000,10.000000,20.000000,10.000000,20.000000))
   TargetActionInterval=(Distribution=DistributionTargetActionInterval,Op=2,LookupTableNumElements=2,LookupTableChunkSize=2,LookupTable=(1.000000,5.000000,1.000000,5.000000,1.000000,5.000000))
   ActionBlendTime=0.100000
   ReActionDelay=1.000000
   RotateToTargetSpeed=0.100000
   SpeedBlendStart=150.000000
   SpeedBlendEnd=180.000000
   WalkVelThresh=10.000000
   AnimVelRate=0.007000
   MaxYawRate=40000.000000
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EnvyEditorResources.BlueDefense'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(0)=Sprite
   CollisionType=COLLIDE_CustomDefault
   Name="Default__FlockTest_Spawner"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
