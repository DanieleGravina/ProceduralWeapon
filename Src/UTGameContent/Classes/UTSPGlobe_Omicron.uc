/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTSPGlobe_Omicron extends UTSPGlobe;

defaultproperties
{
   GlobeTag="Omicron"
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent0 ObjName=SkeletalMeshComponent0 Archetype=SkeletalMeshComponent'UTGame.Default__UTSPGlobe:SkeletalMeshComponent0'
      Begin Object Class=AnimNodeSequence Name=AnimNodeSeq0 ObjName=AnimNodeSeq0 Archetype=AnimNodeSequence'UTGame.Default__UTSPGlobe:SkeletalMeshComponent0.AnimNodeSeq0'
         ObjectArchetype=AnimNodeSequence'UTGame.Default__UTSPGlobe:SkeletalMeshComponent0.AnimNodeSeq0'
      End Object
      SkeletalMesh=SkeletalMesh'UI_SinglePlayer_World.Skeletal.Sk_UI_SP_Omicron'
      Animations=AnimNodeSequence'UTGameContent.Default__UTSPGlobe_Omicron:SkeletalMeshComponent0.AnimNodeSeq0'
      Scale=3.000000
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTSPGlobe:SkeletalMeshComponent0'
   End Object
   SkeletalMeshComponent=SkeletalMeshComponent0
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTSPGlobe:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTSPGlobe:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Begin Object Class=AudioComponent Name=FaceAudioComponent ObjName=FaceAudioComponent Archetype=AudioComponent'UTGame.Default__UTSPGlobe:FaceAudioComponent'
      ObjectArchetype=AudioComponent'UTGame.Default__UTSPGlobe:FaceAudioComponent'
   End Object
   FacialAudioComp=FaceAudioComponent
   Components(0)=MyLightEnvironment
   Components(1)=SkeletalMeshComponent0
   Components(2)=FaceAudioComponent
   CollisionComponent=SkeletalMeshComponent0
   Name="Default__UTSPGlobe_Omicron"
   ObjectArchetype=UTSPGlobe'UTGame.Default__UTSPGlobe'
}
