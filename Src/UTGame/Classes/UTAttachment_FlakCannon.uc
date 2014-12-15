/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_FlakCannon extends UTWeaponAttachment;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_FlakCannon.Mesh.SK_WP_FlakCannon_3P_Mid'
      Animations=UTAnimNodeSequence'UTGame.Default__UTAttachment_FlakCannon:SkeletalMeshComponent0.MeshSequenceA'
      AnimSets(0)=AnimSet'WP_FlakCannon.Anims.K_WP_FlakCannon_3P_Base'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MuzzleFlashSocket"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_FlakCannon.Effects.P_WP_FlakCannon_3P_Muzzle_Flash'
   MuzzleFlashAltPSCTemplate=ParticleSystem'WP_FlakCannon.Effects.P_WP_FlakCannon_3P_Muzzle_Flash'
   MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
   MuzzleFlashDuration=0.330000
   WeaponClass=Class'UTGame.UTWeap_FlakCannon'
   FireAnim="WeaponFire"
   Name="Default__UTAttachment_FlakCannon"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
