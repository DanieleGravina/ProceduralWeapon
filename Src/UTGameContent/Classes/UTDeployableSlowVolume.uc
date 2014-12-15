/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTDeployableSlowVolume extends UTDeployable;

static function class<Actor> GetTeamDeployable(int TeamNum)
{
	return class'UTSlowVolume_Content';
}

function bool Deploy()
{
	local UTSlowVolume Volume;
	local vector SpawnLocation;
	local vector HitLocation, HitNormal;
	local rotator Aim;
	local float DistSqToObstacle;

	SpawnLocation = GetPhysicalFireStartLoc();

	//Get the Z location of where the visual mesh will be placed
	if (Trace(HitLocation, HitNormal, SpawnLocation, Instigator.GetPawnViewLocation(), false) != None)
	{
		DistSqToObstacle = VSizeSq(HitLocation-Location);
		if (DistSqToObstacle < (60.0 * 60.0))
		{
			//Too close to a wall or something to spawn in front of us
            //the actual deployable will do a Z line check right around here
            //and we want it to be on 'safe' ground
			return false;
		}
	}

	//Start at player height
	SpawnLocation.Z = Instigator.Location.Z;
	Aim = GetAdjustedAim(SpawnLocation);
	Aim.Pitch = 0;
	Aim.Roll = 0;
	Volume = Spawn(class'UTSlowVolume_Content',,, SpawnLocation, Aim);
	if (Volume != None)
	{
		Volume.OnDeployableUsedUp = Factory.DeployableUsed;
		bForceHidden = true;
		Mesh.SetHidden(true);
		return true;
	}
	else
	{
		return false;
	}
}

defaultproperties
{
   DeployFailedSoundCue=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   AttachmentClass=Class'UTGameContent.UTAttachment_SlowVolume'
   ArmsAnimSet=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SlowVolume_1P_Arms'
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabTheStasisFieldGenerator',AnnouncementText="Afferra il generatore campo lento!")
   FireOffset=(X=500.000000,Y=200.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTDeployableSlowVolume:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SlowVolume_1P'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      Scale=0.500000
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Generatore Campo Lento"
   PickupMessage="Generatore Campo Lento"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
      Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTDeployableSlowVolume"
   ObjectArchetype=UTDeployable'UTGame.Default__UTDeployable'
}
