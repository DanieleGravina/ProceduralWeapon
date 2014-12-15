//=============================================================================
// Version of AmbientSoundSimple that picks a random non-looping sound to play.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class AmbientSoundNonLoop extends AmbientSoundSimple
	native(Sound);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=SoundCue Name=SoundCue0 ObjName=SoundCue0 Archetype=SoundCue'Engine.Default__AmbientSoundSimple:SoundCue0'
      ObjectArchetype=SoundCue'Engine.Default__AmbientSoundSimple:SoundCue0'
   End Object
   SoundCueInstance=SoundCue'Engine.Default__AmbientSoundNonLoop:SoundCue0'
   Begin Object Class=SoundNodeAmbientNonLoop Name=SoundNodeAmbientNonLoop0 ObjName=SoundNodeAmbientNonLoop0 Archetype=SoundNodeAmbientNonLoop'Engine.Default__SoundNodeAmbientNonLoop'
      Begin Object Class=DistributionFloatUniform Name=DistributionDelayTime ObjName=DistributionDelayTime Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionDelayTime'
         ObjectArchetype=DistributionFloatUniform'DistributionDelayTime'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionMinRadius ObjName=DistributionMinRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionMinRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionMinRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionMaxRadius ObjName=DistributionMaxRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionMaxRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionMaxRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionLPFMinRadius ObjName=DistributionLPFMinRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionLPFMinRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionLPFMinRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionLPFMaxRadius ObjName=DistributionLPFMaxRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionLPFMaxRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionLPFMaxRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionVolume ObjName=DistributionVolume Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionVolume'
         ObjectArchetype=DistributionFloatUniform'DistributionVolume'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionPitch ObjName=DistributionPitch Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbientNonLoop:DistributionPitch'
         ObjectArchetype=DistributionFloatUniform'DistributionPitch'
      End Object
      Name="SoundNodeAmbientNonLoop0"
      ObjectArchetype=SoundNodeAmbientNonLoop'Engine.Default__SoundNodeAmbientNonLoop'
   End Object
   SoundNodeInstance=SoundNodeAmbientNonLoop'Engine.Default__AmbientSoundNonLoop:SoundNodeAmbientNonLoop0'
   Begin Object Class=AudioComponent Name=AudioComponent0 ObjName=AudioComponent0 Archetype=AudioComponent'Engine.Default__AmbientSoundSimple:AudioComponent0'
      PreviewSoundRadius=DrawSoundRadiusComponent'Engine.Default__AmbientSoundNonLoop:DrawSoundRadius0'
      ObjectArchetype=AudioComponent'Engine.Default__AmbientSoundSimple:AudioComponent0'
   End Object
   AudioComponent=AudioComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__AmbientSoundSimple:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__AmbientSoundSimple:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=AudioComponent0
   Begin Object Class=DrawSoundRadiusComponent Name=DrawSoundRadius0 ObjName=DrawSoundRadius0 Archetype=DrawSoundRadiusComponent'Engine.Default__AmbientSoundSimple:DrawSoundRadius0'
      SphereColor=(B=50,G=50,R=240,A=255)
      ObjectArchetype=DrawSoundRadiusComponent'Engine.Default__AmbientSoundSimple:DrawSoundRadius0'
   End Object
   Components(2)=DrawSoundRadius0
   Name="Default__AmbientSoundNonLoop"
   ObjectArchetype=AmbientSoundSimple'Engine.Default__AmbientSoundSimple'
}
