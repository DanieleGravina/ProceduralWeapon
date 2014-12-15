/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTProj_SpiderMineBlue extends UTProj_SpiderMine;

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=SkeletalMeshComponent'UTGameContent.Default__UTProj_SpiderMine:MeshComponentA'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'UTGameContent.Default__UTProj_SpiderMine:MeshSequenceA'
         ObjectArchetype=AnimNodeSequence'UTGameContent.Default__UTProj_SpiderMine:MeshSequenceA'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTProj_SpiderMineBlue:MeshComponentA.MeshSequenceA'
      Materials(0)=Material'PICKUPS.Deployables.Materials.M_Deployables_Spider_VBlue'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTProj_SpiderMine:MeshComponentA'
   End Object
   Mesh=MeshComponentA
   Begin Object Class=AudioComponent Name=AmbientAudio ObjName=AmbientAudio Archetype=AudioComponent'UTGameContent.Default__UTProj_SpiderMine:AmbientAudio'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTProj_SpiderMine:AmbientAudio'
   End Object
   WalkingSoundComponent=AmbientAudio
   Begin Object Class=AudioComponent Name=AttackScreech ObjName=AttackScreech Archetype=AudioComponent'UTGameContent.Default__UTProj_SpiderMine:AttackScreech'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTProj_SpiderMine:AttackScreech'
   End Object
   AttackScreechSoundComponent=AttackScreech
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTProj_SpiderMine:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTProj_SpiderMine:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_SpiderMine:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTProj_SpiderMine:MyLightEnvironment'
   End Object
   Components(1)=MyLightEnvironment
   Components(2)=MeshComponentA
   Components(3)=AmbientAudio
   Components(4)=AttackScreech
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SpiderMineBlue"
   ObjectArchetype=UTProj_SpiderMine'UTGameContent.Default__UTProj_SpiderMine'
}
