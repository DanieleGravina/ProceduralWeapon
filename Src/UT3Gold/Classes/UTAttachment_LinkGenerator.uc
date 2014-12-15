/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_LinkGenerator extends UTWeaponAttachment;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Shield'
      Animations=UTAnimNodeSequence'UT3Gold.Default__UTAttachment_LinkGenerator:SkeletalMeshComponent0.MeshSequenceA'
      CullDistance=5000.000000
      Translation=(X=14.000000,Y=0.000000,Z=-4.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   WeaponClass=Class'UTGameContent.UTDeployableEnergyShield'
   WeapAnimType=EWAT_ShoulderRocket
   Name="Default__UTAttachment_LinkGenerator"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
