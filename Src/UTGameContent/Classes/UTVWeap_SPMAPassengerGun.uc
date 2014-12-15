/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_SPMAPassengerGun extends UTVWeap_ShockTurretBase
		HideDropDown;

defaultproperties
{
   VehicleClass=Class'UTGameContent.UTVehicle_SPMA_Content'
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_SPMAShockBall'
   InstantHitDamageTypes(1)=Class'UTGameContent.UTDmgType_SPMAShockBeam'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Hellfire SPMA"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_SPMAPassengerGun"
   ObjectArchetype=UTVWeap_ShockTurretBase'UTGameContent.Default__UTVWeap_ShockTurretBase'
}
