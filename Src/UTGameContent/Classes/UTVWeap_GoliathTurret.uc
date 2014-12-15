/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_GoliathTurret extends UTVehicleWeapon
	HideDropDown;


simulated function Projectile ProjectileFire()
{
	local Projectile P;
	local vector ForceLoc;

	P = Super.ProjectileFire();
	if ( (Role==ROLE_Authority) && (P != None) )
	{
		// apply force to vehicle
		ForceLoc = MyVehicle.GetTargetLocation();
		ForceLoc.Z += 90;
		MyVehicle.Mesh.AddImpulse(-0.5*P.Velocity, ForceLoc);
	}
	return P;
}

defaultproperties
{
   FireTriggerTags(0)="GoliathTurret"
   VehicleClass=Class'UTGameContent.UTVehicle_Goliath_Content'
   bRecommendSplashDamage=True
   FireCameraAnim(0)=CameraAnim'VH_Goliath.PrimaryFireViewShake'
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=40.000000
   ZoomedRate=60.000000
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Fire'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_None
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_TankShell'
   FireInterval(0)=2.500000
   FireInterval(1)=2.500000
   Spread(0)=0.015000
   Spread(1)=0.015000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Goliath"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_GoliathTurret"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
