/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class MorphTestActor extends SkeletalMeshActor;

var()	Actor	LookAtActor;
var()	float	MinMorphDistance;
var()	float	MaxMorphDistance;

event Tick(float DeltaSeconds)
{
	local	SkelControlLookAt	LookControl;
	local	MorphNodeWeight		WeightNode;
	local	float				LookAtDist;
	local	float				ResultWeight;
	
	if(LookAtActor != None)
	{
		LookControl = SkelControlLookAt( SkeletalMeshComponent.FindSkelControl('LookAtControl') );
		if(LookControl != None)
		{
			LookControl.TargetLocation = LookAtActor.Location;
		}
		
		WeightNode = MorphNodeWeight( SkeletalMeshComponent.FindMorphNode('WeightNode') );
		if(WeightNode != None)
		{
			LookAtDist = Vsize( Location - LookAtActor.Location );
			ResultWeight = Fclamp( (LookAtDist - MinMorphDistance)/(MaxMorphDistance - MinMorphDistance), 0.0, 1.0 );
		
			WeightNode.SetNodeWeight(1.0 - ResultWeight);
		}
	}
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshActor:SkeletalMeshComponent0'
      Animations=None
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshActor:SkeletalMeshComponent0'
   End Object
   SkeletalMeshComponent=SkeletalMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Begin Object Class=AudioComponent Name=FaceAudioComponent ObjName=FaceAudioComponent Archetype=AudioComponent'Engine.Default__SkeletalMeshActor:FaceAudioComponent'
      ObjectArchetype=AudioComponent'Engine.Default__SkeletalMeshActor:FaceAudioComponent'
   End Object
   FacialAudioComp=FaceAudioComponent
   Components(0)=MyLightEnvironment
   Components(1)=SkeletalMeshComponent0
   Components(2)=FaceAudioComponent
   CollisionComponent=SkeletalMeshComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__MorphTestActor"
   ObjectArchetype=SkeletalMeshActor'Engine.Default__SkeletalMeshActor'
}
