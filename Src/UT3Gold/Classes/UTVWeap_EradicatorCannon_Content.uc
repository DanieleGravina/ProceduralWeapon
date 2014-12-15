/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_EradicatorCannon_Content extends UTVWeap_SPMACannon_Content
	hidedropdown;

simulated function Projectile ProjectileFire()
{
	local Projectile Proj;

	Proj = Super.ProjectileFire();
	if ( (Proj != None) && ClassIsChildOf(Proj.Class, class'UTProj_SPMACamera') )
	{
		Proj.MyDamageType = class'UTDmgType_EradicatorCameraCrush';
	}
	return Proj;
}

defaultproperties
{
   VehicleClass=Class'UTGame.UTVehicle_Eradicator'
   WeaponProjectiles(0)=Class'UT3Gold.UTProj_EradicatorShell_Content'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_SPMACannon_Content:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGameContent.Default__UTVWeap_SPMACannon_Content:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Sradicatore"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_SPMACannon_Content:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTVWeap_SPMACannon_Content:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_EradicatorCannon_Content"
   ObjectArchetype=UTVWeap_SPMACannon_Content'UTGameContent.Default__UTVWeap_SPMACannon_Content'
}
