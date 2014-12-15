/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_Avril_Content extends UTWeap_Avril;

defaultproperties
{
   NoAmmoWeaponPutDownAnim="weaponputdownempty"
   WeaponReloadAnim="weaponreload"
   ReloadCue=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRiL_Reload01Cue'
   Begin Object Class=UTParticleSystemComponent Name=LaserComp ObjName=LaserComp Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      FOV=65.000000
      Template=ParticleSystem'WP_AVRiL.Particles.P_WP_AVRiL_TargetBeam'
      bAutoActivate=False
      bUpdateComponentInTick=True
      DepthPriorityGroup=SDPG_Foreground
      bIgnoreOwnerHidden=True
      TickGroup=TG_PostAsyncWork
      Name="LaserComp"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   LaserEffect=LaserComp
   TargetingLaserStartSound=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRIL_FireAltStartCue'
   TargetingLaserStopSound=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRIL_FireAltStopCue'
   TargetingLaserAmbientSound=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRIL_FireAltLoopCue'
   LockAcquiredSound=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRiL_Lock01Cue'
   AttachmentClass=Class'UTGameContent.UTAttachment_Avril'
   WeaponFireAnim(1)=
   ArmsAnimSet=AnimSet'WP_AVRiL.Anims.K_WP_Avril_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Weapon_Avril.WAV.A_Weapon_AVRiL_Fire01Cue'
   WeaponPutDownSnd=SoundCue'A_Weapon_Avril.Weapons.A_Avril_LowerCue'
   WeaponEquipSnd=SoundCue'A_Weapon_Avril.Weapons.A_Avril_RaiseCue'
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_AvrilRocket'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeap_Avril:FirstPersonMesh'
      FOV=65.000000
      SkeletalMesh=SkeletalMesh'WP_AVRiL.Mesh.SK_WP_Avril_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTWeap_Avril_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_AVRiL.Anims.K_WP_Avril_1P_Base'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeap_Avril:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_AVRiL_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeap_Avril:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_AVRiL.Mesh.SK_WP_Avril_3P_Mid'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeap_Avril:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_Avril_Content"
   ObjectArchetype=UTWeap_Avril'UTGame.Default__UTWeap_Avril'
}
