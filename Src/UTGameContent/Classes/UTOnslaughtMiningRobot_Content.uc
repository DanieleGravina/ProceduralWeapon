/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtMiningRobot_Content extends UTOnslaughtMiningRobot
	notplaceable;


simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Mesh.PlayAnim('StartIdle',, true);
}

simulated function StartWorking()
{
	Super.StartWorking();

	Mesh.PlayAnim('Open');
}

simulated event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
	if (bIsWorking && SeqNode.AnimSeqName == 'Open')
	{
		Mesh.PlayAnim('Work',, true);
	}
}

simulated function SetCarryingOre(bool bNewValue)
{
	Super.SetCarryingOre(bNewValue);
	Mesh.PlayAnim(bNewValue ? 'EndIdle' : 'StartIdle',, true);
}

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Conquest.SM.Mesh.S_GP_Con_Crystal01'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtMiningRobot_Content:MyLightEnvironment'
      bUseAsOccluder=False
      Translation=(X=25.000000,Y=0.000000,Z=0.000000)
      Scale3D=(X=0.100000,Y=0.100000,Z=0.100000)
      Name="StaticMeshComponent1"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   CarriedOre=StaticMeshComponent1
   ExplosionSound=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Impact_Cue'
   ExplosionTemplate=ParticleSystem'WP_RocketLauncher.Effects.P_WP_RocketLauncher_RocketExplosion'
   OreQuantity=50.000000
   MaxStepHeight=26.000000
   bCanJump=False
   GroundSpeed=200.000000
   JumpZ=100.000000
   ControllerClass=Class'UTGame.UTOnslaughtMiningRobotController'
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'CH_MiningBot.Mesh.SK_CH_MiningBot'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         bCauseActorAnimEnd=True
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTOnslaughtMiningRobot_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'CH_MiningBot.Anims.K_HC_MiningBot'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtMiningRobot_Content:MyLightEnvironment'
      bUseAsOccluder=False
      Name="SkeletalMeshComponent0"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=SkeletalMeshComponent0
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtMiningRobot:CollisionCylinder'
      CollisionHeight=35.000000
      CollisionRadius=21.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtMiningRobot:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtMiningRobot:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtMiningRobot:Arrow'
   End Object
   Components(1)=Arrow
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(2)=MyLightEnvironment
   Components(3)=SkeletalMeshComponent0
   Components(4)=StaticMeshComponent1
   Physics=PHYS_Walking
   CollisionComponent=CollisionCylinder
   Name="Default__UTOnslaughtMiningRobot_Content"
   ObjectArchetype=UTOnslaughtMiningRobot'UTGame.Default__UTOnslaughtMiningRobot'
}
