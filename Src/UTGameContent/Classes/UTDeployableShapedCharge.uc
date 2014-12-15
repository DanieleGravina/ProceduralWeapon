/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDeployableShapedCharge extends UTDeployable;

var array< class<UTShapedCharge> > TeamShapedChargeClasses;

static function class<Actor> GetTeamDeployable(int TeamNum)
{
	if (TeamNum >= default.TeamShapedChargeClasses.length)
	{
		TeamNum = 0;
	}
	return default.TeamShapedChargeClasses[TeamNum];
}

function bool Deploy()
{
	local UTPlayerController PC;

	DeployedActorClass = class<UTShapedCharge>(GetTeamDeployable(Instigator.GetTeamNum()));
	if ( Super.Deploy() )
	{
		PC = UTPlayerController(Instigator.Controller);
		if ( PC != None )
		{
			 PC.CheckAutoObjective(true);
		}
		return true;
	}
	else
	{
		return false;
	}
}

/** Recommend an objective for player carrying this deployable */
function UTGameObjective RecommendObjective(Controller C)
{
	local UTWarfareBarricade B, Best;
	local float NewDist, BestDist;

	if ( AmmoCount <= 0 )
	{
		return None;
	}

	// if you've got a shaped charge, you're going to want to find a barricade
	ForEach WorldInfo.AllNavigationPoints(class'UTWarfareBarricade', B)
	{
		if ( ((Best == None) || (Best.DefensePriority <= B.DefensePriority))
				&& (B.ValidTargetFor(C)) )
		{
			// prioritize by defensepriority, then proximity
			NewDist = VSize(C.Pawn.Location - B.Location);
			if ( (Best == None) || (Best.DefensePriority < B.DefensePriority) || (NewDist < BestDist) )
			{
				Best = B;
				BestDist = NewDist;
			}
		}
	}
	return Best;
}

function bool ShouldDeploy(UTBot B)
{
	return ( B.Squad != None && B.Squad.SquadObjective != None && !WorldInfo.GRI.OnSameTeam(B.Squad.SquadObjective, B) &&
		CanAttack(B.Squad.SquadObjective) );
}

function bool CanAttack(Actor Other)
{
	local float OtherRadius, OtherHeight;

	if (Instigator == None || Instigator.Controller == None)
	{
		return false;
	}

	// check that target is within range
	Other.GetBoundingCylinder(OtherRadius, OtherHeight);
	if (VSize(Instigator.Location - Other.Location) > OtherRadius + 100.0)
	{
		return false;
	}

	// check that can see target
	return Instigator.Controller.LineOfSightTo(Other);
}

defaultproperties
{
   TeamShapedChargeClasses(0)=Class'UTGameContent.UTShapedCharge_Red'
   TeamShapedChargeClasses(1)=Class'UTGameContent.UTShapedCharge_Blue'
   DeployedActorClass=Class'UTGameContent.UTShapedCharge'
   bDelayRespawn=False
   DeployFailedSoundCue=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   bCanDestroyBarricades=True
   bHasLocationSpeech=True
   AttachmentClass=Class'UTGameContent.UTAttachment_ShapedCharge'
   ArmsAnimSet=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_ShapeCharge_1P_Arms'
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_GrabTheShapedCharge',AnnouncementText="Afferra la carica modellata!")
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheShapedCharge'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheShapedCharge'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheShapedCharge'
   FireOffset=(X=20.000000,Y=0.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_ShapeCharge_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTDeployableShapedCharge:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_ShapeCharge_1P'
      bUseAsOccluder=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      Scale=0.500000
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTDeployable:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Testata Esplosiva Det Pack"
   RespawnTime=60.000000
   PickupMessage="Testata Esplosiva Det Pack"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_ShapeCharge_1P'
      Translation=(X=0.000000,Y=0.000000,Z=-30.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTDeployable:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTDeployableShapedCharge"
   ObjectArchetype=UTDeployable'UTGame.Default__UTDeployable'
}
