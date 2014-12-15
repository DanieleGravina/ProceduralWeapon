/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_GoliathMachineGun extends UTVehicleWeapon
	HideDropDown;

defaultproperties
{
   FireTriggerTags(0)="GoliathMachineGun"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_Enforcer.Cue.A_Weapon_Enforcer_ImpactDirt_Cue',DecalMaterials=(MaterialInstanceConstant'VH_Goliath.Decals.MIC_VH_Goliath_Impact_Decal01'),DecalWidth=16.000000,DecalHeight=16.000000,ParticleTemplate=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Gun_Impact')
   BulletWhip=SoundCue'A_Weapon.Enforcers.Cue.A_Weapon_Enforcers_BulletWhizz_Cue'
   VehicleClass=Class'UTGameContent.UTVehicle_Goliath_Content'
   bFastRepeater=True
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=33.000000
   ZoomedRate=60.000000
   WeaponFireTypes(1)=EWFT_None
   FireInterval(0)=0.100000
   FireInterval(1)=0.100000
   Spread(0)=0.030000
   Spread(1)=0.030000
   InstantHitDamage(0)=18.000000
   InstantHitDamage(1)=16.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_GoliathMachineGun'
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Goliath Cannoniere"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_GoliathMachineGun"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
