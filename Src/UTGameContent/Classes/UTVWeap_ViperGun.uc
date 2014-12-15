/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_ViperGun extends UTVehicleWeapon
		HideDropDown;

defaultproperties
{
   FireTriggerTags(0)="MantaWeapon01"
   FireTriggerTags(1)="MantaWeapon02"
   MaxFinalAimAdjustment=0.700000
   bIgnoreDownwardPitch=True
   VehicleClass=Class'UTGameContent.UTVehicle_Viper_Content'
   bFastRepeater=True
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_PrimaryFireCue'
   aimerror=750.000000
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_None
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_ViperBolt'
   FireInterval(0)=0.200000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Viper"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_ViperGun"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
