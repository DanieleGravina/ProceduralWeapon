/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_SPMACannon_Content extends UTVWeap_SPMACannon
	hidedropdown;

defaultproperties
{
   BoomSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_DistantSPMA'
   IncomingSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_ShellIncoming'
   FireTriggerTags(0)="CannonFire"
   AltFireTriggerTags(0)="CameraFire"
   VehicleClass=Class'UTGameContent.UTVehicle_SPMA_Content'
   WeaponFireSnd(0)=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Fire'
   WeaponFireSnd(1)=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Fire'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_SPMAShell_Content'
   WeaponProjectiles(1)=Class'UTGameContent.UTProj_SPMACamera_Content'
   FireInterval(0)=4.000000
   FireInterval(1)=1.500000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_SPMACannon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_SPMACannon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   AIRating=1.500000
   ItemName="Hellfire SPMA"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_SPMACannon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_SPMACannon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_SPMACannon_Content"
   ObjectArchetype=UTVWeap_SPMACannon'UTGame.Default__UTVWeap_SPMACannon'
}
