/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTSpiderMineTrapBlue extends UTSpiderMineTrap;

defaultproperties
{
   MineClass=Class'UTGameContent.UTProj_SpiderMineBlue'
   ActivateSound=SoundCue'A_Pickups_Deployables.SpiderMine.SpiderMine_ActivateCue'
   TeamNum=1
   Begin Object Class=SkeletalMeshComponent Name=ThirdPersonMesh ObjName=ThirdPersonMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SpiderMine'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTSpiderMineTrapBlue:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SpiderMine'
      Materials(0)=Material'PICKUPS.Deployables.Materials.M_Deployables_Spidermine_VBlue'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTSpiderMineTrapBlue:MyLightEnvironment'
      bUseAsOccluder=False
      Name="ThirdPersonMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=ThirdPersonMesh
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeployedLightEnvironment ObjName=DeployedLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTSpiderMineTrap:DeployedLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTSpiderMineTrap:DeployedLightEnvironment'
   End Object
   LightEnvironment=DeployedLightEnvironment
   Components(0)=DeployedLightEnvironment
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTSpiderMineTrap:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTSpiderMineTrap:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      ModShadowFadeoutTime=1.000000
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(2)=MyLightEnvironment
   Components(3)=ThirdPersonMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTSpiderMineTrapBlue"
   ObjectArchetype=UTSpiderMineTrap'UTGame.Default__UTSpiderMineTrap'
}
