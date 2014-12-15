/** 
 * Version of KAsset that can be dynamically spawned and destroyed during gameplay 
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 **/
class KAssetSpawnable extends KAsset
	notplaceable;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=KAssetSkelMeshComponent ObjName=KAssetSkelMeshComponent Archetype=SkeletalMeshComponent'Engine.Default__KAsset:KAssetSkelMeshComponent'
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__KAsset:KAssetSkelMeshComponent'
   End Object
   SkeletalMeshComponent=KAssetSkelMeshComponent
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__KAsset:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__KAsset:MyLightEnvironment'
   End Object
   Components(0)=MyLightEnvironment
   Components(1)=KAssetSkelMeshComponent
   bNoDelete=False
   CollisionComponent=KAssetSkelMeshComponent
   Name="Default__KAssetSpawnable"
   ObjectArchetype=KAsset'Engine.Default__KAsset'
}
