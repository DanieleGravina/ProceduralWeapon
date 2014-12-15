/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_Translocator_Content extends UTWeap_Translocator
	HideDropDown;



simulated function WeaponEmpty()
{
	local AnimNodeSequence ANS;
	super.WeaponEmpty();
	WeaponIdleAnims[0] = EmptyIdleAnim;
	ANS = GetWeaponAnimNodeSeq();
	if(ANS != none && ANS.AnimSeq != none && ANS.AnimSeq.SequenceName == EmptyIdleAnim)
	{
		PlayWeaponAnimation(WeaponIdleAnims[0],0.001);
	}
}

simulated function ReAddAmmo()
{
	local AnimNodeSequence ANS;
	super.ReAddAmmo();
	if(AmmoCount > 0 && WeaponIdleAnims[0] == EmptyIdleAnim && (TransDisc == None || TransDisc.bDeleteMe))
	{
		WeaponIdleAnims[0] = default.WeaponIdleAnims[0];
		ANS = GetWeaponAnimNodeSeq();
		if(ANS != none && ANS.AnimSeq != none && ANS.AnimSeq.SequenceName == EmptyIdleAnim)
		{
			PlayWeaponAnimation(WeaponIdleAnims[0],0.001);
		}
	}
}

defaultproperties
{
   EmptyIdleAnim="weaponidleempty"
   EmptyPutDownAnim="weaponputdownempty"
   EmptyEquipAnim="weaponequipempty"
   TransRecalledSound=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Recall_Cue'
   DisruptionDeath=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_DisruptedTeleport_Cue'
   TeamSkins(0)=Material'WP_Translocator.Materials.M_WP_Translocator_1P'
   TeamSkins(1)=Material'WP_Translocator.Materials.M_WP_Translocator_1PBlue'
   SkinColors(0)=(R=3.400000,G=0.500000,B=0.100000,A=1.000000)
   SkinColors(1)=(R=0.200000,G=0.500000,B=3.400000,A=1.000000)
   FailedTranslocationDamageClass=Class'UTGameContent.UTDmgType_FailedTranslocation'
   Begin Object Class=ParticleSystemComponent Name=DiskInEffect ObjName=DiskInEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_idle'
      SecondsBeforeInactive=1.000000
      DepthPriorityGroup=SDPG_Foreground
      Name="DiskInEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   DiskEffect=DiskInEffect
   IconCoordinates=(V=461.000000,UL=122.000000,VL=54.000000)
   CrossHairCoordinates=(U=0.000000,V=0.000000)
   AttachmentClass=Class'UTGameContent.UTAttachment_Translocator'
   WeaponFireAnim(1)=
   ArmFireAnim(1)=
   ArmsAnimSet=AnimSet'WP_Translocator.Anims.K_WP_Translocator_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Fire_Cue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Teleport_Cue'
   WeaponPutDownSnd=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Lower_Cue'
   WeaponEquipSnd=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Raise_Cue'
   MuzzleFlashSocket="MuzzleFlash"
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_Custom
   FiringStatesArray(1)="RecallFire"
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_TransDisc_ContentRed'
   WeaponProjectiles(1)=Class'UTGameContent.UTProj_TransDisc_ContentBlue'
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeap_Translocator:FirstPersonMesh'
      FOV=55.000000
      SkeletalMesh=SkeletalMesh'WP_Translocator.Mesh.SK_WP_Translocator_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTWeap_Translocator_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_Translocator.Anims.K_WP_Translocator_1P_Base'
      Materials(0)=Material'WP_Translocator.Materials.M_Gun_Ark'
      Materials(1)=Material'WP_Translocator.Materials.M_WP_Translocator_1P'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeap_Translocator:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeap_Translocator:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_Translocator.Mesh.SK_WP_Translocator_3P_Mid'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeap_Translocator:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Components(0)=DiskInEffect
   Name="Default__UTWeap_Translocator_Content"
   ObjectArchetype=UTWeap_Translocator'UTGame.Default__UTWeap_Translocator'
}
