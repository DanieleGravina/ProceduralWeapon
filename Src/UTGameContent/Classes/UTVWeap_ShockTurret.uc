/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_ShockTurret extends UTVWeap_ShockTurretBase
	HideDropDown;

defaultproperties
{
   VehicleClass=Class'UTGameContent.UTVehicle_HellBender_Content'
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_VehicleShockBall'
   InstantHitDamageTypes(1)=Class'UTGameContent.UTDmgType_VehicleShockBeam'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Hellbender"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_ShockTurretBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_ShockTurret"
   ObjectArchetype=UTVWeap_ShockTurretBase'UTGameContent.Default__UTVWeap_ShockTurretBase'
}
