/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDeployableEnergyShield extends UTDeployable;

defaultproperties
{
   DeployedActorClass=Class'UTGameContent.UTEnergyShield'
   DeployFailedSoundCue=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   AttachmentClass=Class'UTGameContent.UTAttachment_EnergyShield'
   ArmsAnimSet=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_Shield_1P_Arms'
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabTheEnergyShield',AnnouncementText="Afferra lo scudo di energia!")
   FireOffset=(X=20.000000,Y=0.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Shield'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTDeployableEnergyShield:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_Shield_1P'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Scudo di Energia Attivabile"
   PickupMessage="Scudo di Energia Attivabile"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Shield'
      Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTDeployableEnergyShield"
   ObjectArchetype=UTDeployable'UTGame.Default__UTDeployable'
}
