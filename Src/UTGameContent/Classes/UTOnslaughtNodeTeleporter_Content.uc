/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTOnslaughtNodeTeleporter_Content extends UTOnslaughtNodeTeleporter;

defaultproperties
{
   NeutralEffectTemplate=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle'
   TeamEffectTemplates(0)=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle_Red'
   TeamEffectTemplates(1)=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle_Blue'
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Translation=(X=0.000000,Y=0.000000,Z=-40.000000)
      Name="ParticleSystemComponent0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   AmbientEffect=ParticleSystemComponent0
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent1 ObjName=ParticleSystemComponent1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Name="ParticleSystemComponent1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   PortalEffect=ParticleSystemComponent1
   TeamPortalEffectTemplates(0)=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Idle_Red'
   TeamPortalEffectTemplates(1)=ParticleSystem'PICKUPS.Base_Teleporter.Effects.P_Pickups_Teleporter_Idle_Blue'
   TeamNum=255
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Conduit'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtNodeTeleporter_Content:OnslaughtNodeTeleporterLightEnvironment'
      bUseAsOccluder=False
      bCastDynamicShadow=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Scale=0.500000
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   FloorMesh=StaticMeshComponent0
   NeutralFloorColor=(R=9.000000,G=8.000000,B=4.000000,A=1.000000)
   TeamFloorColors(0)=(R=50.000000,G=5.000000,B=0.000000,A=1.000000)
   TeamFloorColors(1)=(R=0.000000,G=5.000000,B=50.000000,A=1.000000)
   ConstructedSound=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_ConduitActivated'
   ActiveSound=SoundCue'A_Gameplay.Portal.Portal_Loop01Cue'
   Begin Object Class=AudioComponent Name=AmbientSoundComponent0 ObjName=AmbientSoundComponent0 Archetype=AudioComponent'Engine.Default__AudioComponent'
      bAutoPlay=True
      bStopWhenOwnerDestroyed=True
      Name="AmbientSoundComponent0"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   AmbientSoundComponent=AmbientSoundComponent0
   PortalMaterial=Material'PICKUPS.Base_Teleporter.Material.M_T_Pickups_Teleporter_Portal_Destination'
   Begin Object Class=SceneCapture2DComponent Name=SceneCapture2DComponent0 ObjName=SceneCapture2DComponent0 Archetype=SceneCapture2DComponent'Engine.Default__SceneCapture2DComponent'
      NearPlane=10.000000
      FarPlane=-1.000000
      bUpdateMatrices=False
      bSkipUpdateIfOwnerOccluded=True
      FrameRate=15.000000
      MaxUpdateDist=1000.000000
      MaxStreamingUpdateDist=1000.000000
      Name="SceneCapture2DComponent0"
      ObjectArchetype=SceneCapture2DComponent'Engine.Default__SceneCapture2DComponent'
   End Object
   PortalCaptureComponent=SceneCapture2DComponent0
   bCanWalkOnToReach=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtNodeTeleporter:CollisionCylinder'
      CollisionHeight=30.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtNodeTeleporter:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   GoodSprite=None
   BadSprite=None
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtNodeTeleporter:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtNodeTeleporter:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTOnslaughtNodeTeleporter:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTOnslaughtNodeTeleporter:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=DynamicLightEnvironmentComponent Name=OnslaughtNodeTeleporterLightEnvironment ObjName=OnslaughtNodeTeleporterLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="OnslaughtNodeTeleporterLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(3)=OnslaughtNodeTeleporterLightEnvironment
   Components(4)=StaticMeshComponent0
   Components(5)=ParticleSystemComponent0
   Components(6)=ParticleSystemComponent1
   Components(7)=SceneCapture2DComponent0
   Components(8)=AmbientSoundComponent0
   RemoteRole=ROLE_SimulatedProxy
   bStatic=False
   bAlwaysRelevant=True
   bCollideActors=True
   bBlockActors=True
   NetUpdateFrequency=1.000000
   CollisionComponent=CollisionCylinder
   MessageClass=Class'UTGameContent.UTOnslaughtMessage'
   Name="Default__UTOnslaughtNodeTeleporter_Content"
   ObjectArchetype=UTOnslaughtNodeTeleporter'UTGame.Default__UTOnslaughtNodeTeleporter'
}
