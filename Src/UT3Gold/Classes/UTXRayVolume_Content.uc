/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTXRayVolume_Content extends UTXRayVolume;

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=VisualEffect ObjName=VisualEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'PICKUPS_2.Deployables.Effects.P_Deployables_XRAY_Projector'
      bAutoActivate=False
      Name="VisualEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   GeneratorEffect=VisualEffect
   Begin Object Class=SkeletalMeshComponent Name=VisualMesh ObjName=VisualMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'PICKUPS_2.Deployables.Mesh.SK_Deployables_XRAY'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UT3Gold.Default__UTXRayVolume_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'PICKUPS.Deployables.Anims.K_Deployables_SlowVolume'
      bUpdateSkelWhenNotRendered=False
      Materials(0)=Material'PICKUPS_2.Deployables.Materials.M_Deployables_XRAY'
      LightEnvironment=DynamicLightEnvironmentComponent'UT3Gold.Default__UTXRayVolume_Content:MyLightEnvironment'
      bUseAsOccluder=False
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
   XRayInvisMaterial=Material'PICKUPS.Invis.M_Invis_01'
   DamageType=Class'UT3Gold.UTDmgType_XRay'
   BrushComponent=None
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'PICKUPS_2.Deployables.Mesh.S_Deployables_XrayVolume_Cylinder'
      bUseAsOccluder=False
      CastShadow=False
      BlockActors=False
      BlockRigidBody=False
      Scale3D=(X=1.800000,Y=1.800000,Z=1.300000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(0)=StaticMeshComponent0
   Begin Object Class=CylinderComponent Name=CollisionCylinder0 ObjName=CollisionCylinder0 Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=150.000000
      CollisionRadius=230.000000
      CollideActors=True
      Translation=(X=0.000000,Y=0.000000,Z=150.000000)
      Name="CollisionCylinder0"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   Components(1)=CollisionCylinder0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      ModShadowFadeoutTime=1.000000
      Name="MyLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(2)=MyLightEnvironment
   Components(3)=VisualMesh
   Components(4)=VisualEffect
   Components(5)=AmbientAudio
   CollisionComponent=CollisionCylinder0
   Name="Default__UTXRayVolume_Content"
   ObjectArchetype=UTXRayVolume'UTGame.Default__UTXRayVolume'
}
