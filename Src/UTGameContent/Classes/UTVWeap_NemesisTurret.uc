/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_NemesisTurret extends UTVehicleWeapon
		HideDropDown;

defaultproperties
{
   DefaultImpactEffect=(Sound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_TurretFireImpactCue',ParticleTemplate=ParticleSystem'VH_Nemesis.Effects.PS_Nemesis_Gun_Impact')
   BulletWhip=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_WhipCue'
   VehicleClass=Class'UTGameContent.UTVehicle_Nemesis'
   bSniping=True
   bFastRepeater=True
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=33.000000
   ZoomedRate=60.000000
   ZoomInSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_TurretZoomCue'
   ZoomOutSound=None
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_TurretFireCue'
   WeaponFireTypes(1)=EWFT_None
   FireInterval(0)=0.360000
   InstantHitDamage(0)=50.000000
   InstantHitMomentum(0)=75000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_NemesisBeam'
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Nemesis"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_NemesisTurret"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
