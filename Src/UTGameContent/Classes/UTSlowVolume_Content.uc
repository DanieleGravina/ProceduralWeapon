/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTSlowVolume_Content extends UTSlowVolume;

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=VisualEffect ObjName=VisualEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Deployables.Effects.P_Deployables_SlowVolume_Spawn_Idle'
      bAutoActivate=False
      Translation=(X=-455.000000,Y=-200.000000,Z=0.000000)
      Scale3D=(X=1.020000,Y=1.550000,Z=1.300000)
      Name="VisualEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   SlowEffect=VisualEffect
   Begin Object Class=ParticleSystemComponent Name=VisualEffect2 ObjName=VisualEffect2 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Deployables.Effects.P_Deployables_SlowVolume_Projector'
      bAutoActivate=False
      Translation=(X=-435.000000,Y=-200.000000,Z=-4.000000)
      Name="VisualEffect2"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   GeneratorEffect=VisualEffect2
   Begin Object Class=SkeletalMeshComponent Name=VisualMesh ObjName=VisualMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS.Deployables.Mesh.SK_Deployables_SlowVolume'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTSlowVolume_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SlowVolume'
      bUpdateSkelWhenNotRendered=False
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTSlowVolume_Content:MyLightEnvironment'
      bUseAsOccluder=False
      Translation=(X=-435.000000,Y=-200.000000,Z=-1.000000)
      Name="VisualMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   GeneratorMesh=VisualMesh
   ActivateSound=SoundCue'A_Pickups_Deployables.SlowVolume.SlowVolume_OpenCue'
   DestroySound=SoundCue'A_Pickups_Deployables.SlowVolume.SlowVolume_CloseCue'
   EnterSound=SoundCue'A_Pickups_Deployables.SlowVolume.SlowVolume_EnterCue'
   ExitSound=SoundCue'A_Pickups_Deployables.SlowVolume.SlowVolume_ExitCue'
   OutsideAmbientSound=SoundCue'A_Pickups_Deployables.SlowVolume.SlowVolume_LoopOutsideCue'
   InsideAmbientSound=SoundCue'A_Pickups_Deployables.SlowVolume.SlowVolume_LoopInsideCue'
   Begin Object Class=AudioComponent Name=AmbientAudio ObjName=AmbientAudio Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientAudio"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   AmbientSoundComponent=AmbientAudio
   InsideCameraEffect=Class'UTGameContent.UTEmitCameraEffect_SlowVolume'
   BrushComponent=None
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS.Deployables.Mesh.S_Deployables_SlowVolume_Collision'
      HiddenGame=True
      bUseAsOccluder=False
      CastShadow=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=-455.000000,Y=-200.000000,Z=0.000000)
      Scale3D=(X=1.020000,Y=1.550000,Z=1.300000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(0)=StaticMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      ModShadowFadeoutTime=1.000000
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(1)=MyLightEnvironment
   Components(2)=VisualMesh
   Components(3)=VisualEffect
   Components(4)=VisualEffect2
   Components(5)=AmbientAudio
   CollisionComponent=StaticMeshComponent0
   Name="Default__UTSlowVolume_Content"
   ObjectArchetype=UTSlowVolume'UTGame.Default__UTSlowVolume'
}
