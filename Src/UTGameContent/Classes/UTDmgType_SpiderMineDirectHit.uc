/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTDmgType_SpiderMineDirectHit extends UTDmgType_SpiderMine
	dependson(UTEmitterPool)
	abstract;

var SkeletalMeshComponent DeathCameraMesh;
var CameraAnim DeathCameraAnim;
var ParticleSystem ExplosionTemplate;
var SoundCue ExplosionSound;

var SoundCue HumanDrillingCue;
var SoundCue RobotDrillingCue;

var() Vector MeshOffset;

/** Return the DeathCameraEffect that will be played on the instigator that was caused by this damagetype and the Pawn type (e.g. robot) */
simulated static function class<UTEmitCameraEffect> GetDeathCameraEffectInstigator( UTPawn UTP )
{
	// robots need to splatter oil instead of blood
	if( ( UTP != none ) && ( ClassIsChildOf( UTP.GetFamilyInfo(), class'UTFamilyInfo_Liandri' ) == TRUE ) )
	{
		return class'UTEmitCameraEffect_OilSplatter';
	}
	else
	{
		return default.DeathCameraEffectInstigator;
	}
}

simulated static function SoundCue GetDrillingSoundCue( UTPawn UTP )
{
	// robots are metal and not fleshy
	if( ( UTP != none ) && ( ClassIsChildOf( UTP.GetFamilyInfo(), class'UTFamilyInfo_Liandri' ) == TRUE ) )
	{
		return default.RobotDrillingCue;
	}
	else
	{
		return default.HumanDrillingCue;
	}
}

simulated static function CalcDeathCamera(UTPawn P, float DeltaTime, out vector CameraLocation, out rotator CameraRotation, out float CameraFOV)
{
	local AnimNodeSequence AnimNode;
	local UTPlayerController MyPC;
	local SoundCue DrillSound;

	if (P.FirstPersonDeathVisionMesh == None)
	{
		P.FirstPersonDeathVisionMesh = new(P) default.DeathCameraMesh.Class(default.DeathCameraMesh);
		P.AttachComponent(P.FirstPersonDeathVisionMesh);
		P.FirstPersonDeathVisionMesh.PlayAnim('FaceAttack');

		DrillSound = GetDrillingSoundCue(P);
		if (DrillSound != None)
		{
			P.PlaySound(DrillSound);
		}

		// Find the player controller
		ForEach P.LocalPlayerControllers(class'UTPlayerController', MyPC)
		{
			if( MyPC.ViewTarget == P && default.DeathCameraAnim != None )
			{
				MyPC.PlayCameraAnim(default.DeathCameraAnim, 1.0f, 1.0f, 0.1f, 0.1f, false, true);
				break;
			}
		}
	}

	P.GetActorEyesViewPoint(CameraLocation, CameraRotation);

	P.FirstPersonDeathVisionMesh.SetTranslation(P.GetEyeHeight() * default.MeshOffset);
	P.FirstPersonDeathVisionMesh.SetRotation(P.Rotation);
	
	//Play some added death effect stuff at the appropriate time
	AnimNode = AnimNodeSequence(P.FirstPersonDeathVisionMesh.Animations);
	if (AnimNode != None && AnimNode.bPlaying)
	{
		//Give it some time to get drilling
		if (!class'GameInfo'.static.UseLowGore(P.WorldInfo) && AnimNode.CurrentTime > 2.0f && AnimNode.CurrentTime < 0.99f * AnimNode.AnimSeq.SequenceLength)
		{
			// Find the player controller
			ForEach P.LocalPlayerControllers(class'UTPlayerController', MyPC)
			{
				if( MyPC.ViewTarget == P )
				{
					MyPC.ClientSpawnCameraEffect(GetDeathCameraEffectInstigator(P));
					break;
				}
			}
		}

		//Blow up the mine with great fanfare
		if (AnimNode.CurrentTime > 0.98f * AnimNode.AnimSeq.SequenceLength)
		{
			P.FirstPersonDeathVisionMesh.StopAnim();
			P.DetachComponent(P.FirstPersonDeathVisionMesh);
			
			UTEmitterPool(P.WorldInfo.MyEmitterPool).SpawnEmitter(default.ExplosionTemplate, CameraLocation + P.FirstPersonDeathVisionMesh.Translation, CameraRotation);
			P.PlaySound(default.ExplosionSound);
		}
	}
}

defaultproperties
{
   Begin Object Class=UTSkeletalMeshComponent Name=DeathVisionMesh ObjName=DeathVisionMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTSkeletalMeshComponent'
      FOV=55.000000
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_Spider_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceC ObjName=MeshSequenceC Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceC"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTDmgType_SpiderMineDirectHit:MeshSequenceC'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_Spider_1P'
      bSyncActorLocationToRootRigidBody=False
      bOnlyOwnerSee=True
      CastShadow=False
      Scale=3.000000
      AbsoluteRotation=True
      AbsoluteScale=True
      Name="DeathVisionMesh"
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTSkeletalMeshComponent'
   End Object
   DeathCameraMesh=DeathVisionMesh
   DeathCameraAnim=CameraAnim'Camera_FX.Gameplay.C_SpiderMine_FaceDrill_Shake_Constant'
   ExplosionTemplate=ParticleSystem'PICKUPS.Deployables.Effects.P_Deployables_SpiderMine_FaceDrill_Explo'
   ExplosionSound=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMines_ExplodesCue'
   HumanDrillingCue=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMine_DrillDeath_HumanCue'
   RobotDrillingCue=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMine_DrillDeath_RobotCue'
   MeshOffset=(X=-0.100000,Y=0.250000,Z=0.900000)
   bSpecialDeathCamera=True
   DeathCameraEffectInstigator=Class'UTGame.UTEmitCameraEffect_BloodDrilling'
   bNeverGibs=True
   bLocationalHit=False
   Name="Default__UTDmgType_SpiderMineDirectHit"
   ObjectArchetype=UTDmgType_SpiderMine'UTGameContent.Default__UTDmgType_SpiderMine'
}
