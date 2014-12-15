/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDeployableSpiderMineTrap extends UTDeployable;

var array< class<UTSpiderMineTrap> > TeamSpiderTrapClasses;

static function class<Actor> GetTeamDeployable(int TeamNum)
{
	if (TeamNum >= default.TeamSpiderTrapClasses.length)
	{
		TeamNum = 0;
	}
	return default.TeamSpiderTrapClasses[TeamNum];
}

function bool Deploy()
{
	DeployedActorClass = class<UTSpiderMineTrap>(GetTeamDeployable(Instigator.GetTeamNum()));
	return Super.Deploy();
}

function bool CanAttack(Actor Other)
{
	if (Instigator == None || Instigator.Controller == None)
	{
		return false;
	}

	// check that target is within range
	if (VSize(Instigator.Location - Other.Location) > (Pawn(Other) != None ? 2000.0 : MaxRange()))
	{
		return false;
	}

	// check that can see target
	return Instigator.Controller.LineOfSightTo(Other);
}

defaultproperties
{
   TeamSpiderTrapClasses(0)=Class'UTGameContent.UTSpiderMineTrapRed'
   TeamSpiderTrapClasses(1)=Class'UTGameContent.UTSpiderMineTrapBlue'
   DeployFailedSoundCue=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   DroppedPickupOffsetZ=15.000000
   AttachmentClass=Class'UTGameContent.UTAttachment_SpiderMineTrap'
   ArmsAnimSet=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SpiderMine_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMine_DropCue'
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabTheSpiderMineTrap',AnnouncementText="Afferra la trappola mina ragno!")
   FireOffset=(X=25.000000,Y=0.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SpiderMine'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTDeployableSpiderMineTrap:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SpiderMine_1P'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      Scale=0.500000
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Trappola Mina Ragno"
   PickupMessage="Trappola Mina Ragno"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SpiderMine'
      Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTDeployableSpiderMineTrap"
   ObjectArchetype=UTDeployable'UTGame.Default__UTDeployable'
}
