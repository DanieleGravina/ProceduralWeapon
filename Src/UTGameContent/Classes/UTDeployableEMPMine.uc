/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTDeployableEMPMine extends UTDeployable;

function bool ShouldDeploy(UTBot B)
{
	local UTVehicle V;

	if (B.IsRetreating() && UTVehicleBase(B.Enemy) != None)
	{
		return true;
	}
	else
	{
		// deploy if any enemy vehicles nearby, even if not being driven
		foreach VisibleCollidingActors(class'UTVehicle', V, 1024.0)
		{
			if (!WorldInfo.GRI.OnSameTeam(V, B))
			{
				return true;
			}
		}

		return false;
	}
}

defaultproperties
{
   DeployedActorClass=Class'UTGameContent.UTEMPMine'
   DeployFailedSoundCue=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   AttachmentClass=Class'UTGameContent.UTAttachment_EMPMine'
   ArmsAnimSet=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_EMP_Mine_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Pickups_Deployables.EMPMine.EMPMine_DropCue'
   NeedToPickUpAnnouncement=(AnnouncementText="Afferra la mina EMP!")
   FireOffset=(X=20.000000,Y=0.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_EMP_Mine'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTDeployableEMPMine:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_EMP_Mine_1P'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Mina EMP"
   PickupMessage="Mina EMP"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_EMP_Mine'
      Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTDeployableEMPMine"
   ObjectArchetype=UTDeployable'UTGame.Default__UTDeployable'
}
