/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTAttachment_Redeemer extends UTWeaponAttachment;

simulated function AttachTo(UTPawn OwnerPawn)
{
	Super.AttachTo(OwnerPawn);

	Mesh.PlayAnim('WeaponEquip');
	// for some reason we need this otherwise the first frame is still in the default pose
	Mesh.ForceSkelUpdate();
}

simulated function SetPuttingDownWeapon(bool bNowPuttingDown)
{
	Mesh.PlayAnim((bNowPuttingDown) ? 'WeaponPutDown' : 'WeaponEquip');
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'WP_Redeemer.Mesh.SK_WP_Redeemer_3P_Mid'
      Animations=UTAnimNodeSequence'UTGameContent.Default__UTAttachment_Redeemer:SkeletalMeshComponent0.MeshSequenceA'
      AnimSets(0)=AnimSet'WP_Redeemer.Anims.K_WP_Redeemer_3P_Base'
      bForceRefpose=0
      Translation=(X=11.000000,Y=-10.000000,Z=5.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   MuzzleFlashSocket="MuzzleFlashSocket"
   MuzzleFlashPSCTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_FX_MuzzleFlash'
   MuzzleFlashColor=(B=64,G=64,R=200,A=255)
   MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
   MuzzleFlashDuration=0.330000
   WeaponClass=Class'UTGameContent.UTWeap_Redeemer_Content'
   WeapAnimType=EWAT_ShoulderRocket
   Name="Default__UTAttachment_Redeemer"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
