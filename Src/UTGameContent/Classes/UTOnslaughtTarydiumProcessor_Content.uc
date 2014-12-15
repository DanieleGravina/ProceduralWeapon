/**
* Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
*/
class UTOnslaughtTarydiumProcessor_Content extends UTOnslaughtTarydiumProcessor;

defaultproperties
{
   OreEventThreshold=100.000000
   MiningBotClass=Class'UTGameContent.UTOnslaughtMiningRobot_Content'
   Begin Object Class=SkeletalMeshComponent Name=ProcComp ObjName=ProcComp Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'GP_Conquest.Mesh.SK_GP_Con_Processing_Plant'
      Begin Object Class=AnimNodeSequence Name=SeqNode ObjName=SeqNode Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         AnimSeqName="PP_Loop"
         Rate=0.000000
         bPlaying=True
         bLooping=True
         Name="SeqNode"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTOnslaughtTarydiumProcessor_Content:SeqNode'
      PhysicsAsset=PhysicsAsset'GP_Conquest.Mesh.SK_GP_Con_Processing_Plant_Physics'
      AnimSets(0)=AnimSet'GP_Conquest.Anims.K_GP_Con_Processing_Plant'
      bHasPhysicsAssetInstance=True
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtTarydiumProcessor_Content:ProcLightEnvironment'
      CollideActors=True
      BlockActors=True
      BlockZeroExtent=True
      BlockNonZeroExtent=True
      BlockRigidBody=True
      Translation=(X=0.000000,Y=0.000000,Z=-190.000000)
      Name="ProcComp"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   Mesh=ProcComp
   Begin Object Class=StaticMeshComponent Name=SMComp ObjName=SMComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Conquest.Mesh.SM_Processing_Plant'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtTarydiumProcessor_Content:ProcLightEnvironment'
      Translation=(X=46.900002,Y=-18.639999,Z=-178.000000)
      Name="SMComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   StaticMesh=SMComp
   ProcColor=(X=0.000000,Y=1.000000,Z=1.000000)
   bDestinationOnly=True
   bMustTouchToReach=False
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:CollisionCylinder'
      CollisionRadius=300.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:Sprite2'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTOnslaughtTarydiumProcessor:PathRenderer'
   End Object
   Components(4)=PathRenderer
   Begin Object Class=DynamicLightEnvironmentComponent Name=ProcLightEnvironment ObjName=ProcLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="ProcLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(5)=ProcLightEnvironment
   Components(6)=ProcComp
   Components(7)=SMComp
   bPushedByEncroachers=False
   bMovable=True
   bProjTarget=True
   bPathColliding=True
   CollisionComponent=ProcComp
   SupportedEvents(4)=Class'UTGame.UTSeqEvent_MinedOre'
   Name="Default__UTOnslaughtTarydiumProcessor_Content"
   ObjectArchetype=UTOnslaughtTarydiumProcessor'UTGame.Default__UTOnslaughtTarydiumProcessor'
}
