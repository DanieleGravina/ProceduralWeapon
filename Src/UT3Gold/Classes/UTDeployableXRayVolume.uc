/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDeployableXRayVolume extends UTDeployableXRayVolumeBase;

defaultproperties
{
   DeployableClass=Class'UT3Gold.UTXRayVolume_Content'
   DeployFailedSoundCue=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   AttachmentClass=Class'UTGameContent.UTAttachment_SlowVolume'
   ArmsAnimSet=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SlowVolume_1P_Arms'
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabTheStasisFieldGenerator',AnnouncementText="Prendi il generatore di campo a Raggi-X !")
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployableXRayVolumeBase:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UT3Gold.Default__UTDeployableXRayVolume:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SlowVolume_1P'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      Scale=0.500000
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployableXRayVolumeBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Generatore di campo a raggi X"
   PickupMessage="Generatore di campo a raggi X"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployableXRayVolumeBase:PickupMesh'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
      Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployableXRayVolumeBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTDeployableXRayVolume"
   ObjectArchetype=UTDeployableXRayVolumeBase'UTGame.Default__UTDeployableXRayVolumeBase'
}
