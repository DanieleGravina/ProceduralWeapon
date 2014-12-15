/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

//@FIXME: class should be removed after maps have switched to Content version
class UTWeap_BioRifle extends UTWeapon
	HideDropDown
	abstract;

defaultproperties
{
   bExportMenuData=False
   bWarnIfInLocker=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_BioRifle"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
