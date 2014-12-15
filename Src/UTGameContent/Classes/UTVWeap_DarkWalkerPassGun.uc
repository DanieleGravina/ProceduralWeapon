/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_DarkWalkerPassGun extends UTVehicleWeapon
	HideDropDown;

defaultproperties
{
   FireTriggerTags(0)="TurretWeapon00"
   FireTriggerTags(1)="TurretWeapon01"
   FireTriggerTags(2)="TurretWeapon02"
   FireTriggerTags(3)="TurretWeapon03"
   VehicleClass=Class'UTGameContent.UTVehicle_DarkWalker_Content'
   bFastRepeater=True
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=20.000000
   ZoomedRate=60.000000
   WeaponFireSnd(0)=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FireCue'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_None
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_DarkWalkerBolt'
   FireInterval(0)=0.150000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="DarkWalker Cannoniere"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_DarkWalkerPassGun"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
