/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class SkeletalMeshActorMATSpawnable extends SkeletalMeshActorMAT
	notplaceable;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMAT:SkeletalMeshComponent0'
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshActorMAT:SkeletalMeshComponent0'
   End Object
   SkeletalMeshComponent=SkeletalMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMAT:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActorMAT:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Begin Object Class=AudioComponent Name=FaceAudioComponent ObjName=FaceAudioComponent Archetype=AudioComponent'Engine.Default__SkeletalMeshActorMAT:FaceAudioComponent'
      ObjectArchetype=AudioComponent'Engine.Default__SkeletalMeshActorMAT:FaceAudioComponent'
   End Object
   FacialAudioComp=FaceAudioComponent
   Components(0)=MyLightEnvironment
   Components(1)=SkeletalMeshComponent0
   Components(2)=FaceAudioComponent
   bNoDelete=False
   CollisionComponent=SkeletalMeshComponent0
   Name="Default__SkeletalMeshActorMATSpawnable"
   ObjectArchetype=SkeletalMeshActorMAT'Engine.Default__SkeletalMeshActorMAT'
}
