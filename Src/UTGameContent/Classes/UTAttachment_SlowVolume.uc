/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTAttachment_SlowVolume extends UTWeaponAttachment;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
      Begin Object Class=UTAnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
         ObjectArchetype=UTAnimNodeSequence'UTGame.Default__UTWeaponAttachment:MeshSequenceA'
      End Object
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
      Animations=UTAnimNodeSequence'UTGameContent.Default__UTAttachment_SlowVolume:SkeletalMeshComponent0.MeshSequenceA'
      CullDistance=5000.000000
      Translation=(X=14.000000,Y=0.000000,Z=-15.000000)
      Rotation=(Pitch=0,Yaw=16384,Roll=0)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponAttachment:SkeletalMeshComponent0'
   End Object
   Mesh=SkeletalMeshComponent0
   WeaponClass=Class'UTGameContent.UTDeployableSlowVolume'
   WeapAnimType=EWAT_ShoulderRocket
   Name="Default__UTAttachment_SlowVolume"
   ObjectArchetype=UTWeaponAttachment'UTGame.Default__UTWeaponAttachment'
}
