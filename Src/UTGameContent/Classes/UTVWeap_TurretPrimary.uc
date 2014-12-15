/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_TurretPrimary extends UTVehicleWeapon
	HideDropDown;

var float ZoomStep;
var float ZoomMinFOV;

defaultproperties
{
   FireTriggerTags(0)="FireUL"
   FireTriggerTags(1)="FireUR"
   FireTriggerTags(2)="FireLL"
   FireTriggerTags(3)="FireLR"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue',ParticleTemplate=ParticleSystem'VH_Turret.Effects.P_VH_Turret_Impact')
   BulletWhip=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_WhipCue'
   bPlaySoundFromSocket=True
   VehicleClass=Class'UTGameContent.UTVehicle_Turret'
   bFastRepeater=True
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=12.000000
   ZoomedRate=60.000000
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Turret.Cue.AxonTurret_FireCue'
   aimerror=650.000000
   WeaponFireTypes(1)=EWFT_None
   FireInterval(0)=0.220000
   InstantHitDamage(0)=34.000000
   InstantHitMomentum(0)=50000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_TurretPrimary'
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Torretta"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_TurretPrimary"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
