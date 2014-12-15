//=============================================================================
// Simplified version of ambient sound used to enhance workflow.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class AmbientSoundSimple extends AmbientSound
	hidecategories(Audio)
	native(Sound);

/** Mirrored property for easier editability, set in Spawned.		*/
var()	editinline editconst	SoundNodeAmbient	AmbientProperties;
/** Dummy sound cue property to force instantiation of subobject.	*/
var		editinline export const SoundCue			SoundCueInstance;
/** Dummy sound node property to force instantiation of subobject.	*/
var		editinline export const SoundNodeAmbient	SoundNodeInstance;

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
   Begin Object Class=SoundCue Name=SoundCue0 ObjName=SoundCue0 Archetype=SoundCue'Engine.Default__SoundCue'
      SoundGroup="Ambient"
      Name="SoundCue0"
      ObjectArchetype=SoundCue'Engine.Default__SoundCue'
   End Object
   SoundCueInstance=SoundCue'Engine.Default__AmbientSoundSimple:SoundCue0'
   Begin Object Class=SoundNodeAmbient Name=SoundNodeAmbient0 ObjName=SoundNodeAmbient0 Archetype=SoundNodeAmbient'Engine.Default__SoundNodeAmbient'
      Begin Object Class=DistributionFloatUniform Name=DistributionMinRadius ObjName=DistributionMinRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbient:DistributionMinRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionMinRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionMaxRadius ObjName=DistributionMaxRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbient:DistributionMaxRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionMaxRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionLPFMinRadius ObjName=DistributionLPFMinRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbient:DistributionLPFMinRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionLPFMinRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionLPFMaxRadius ObjName=DistributionLPFMaxRadius Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbient:DistributionLPFMaxRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionLPFMaxRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionVolume ObjName=DistributionVolume Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbient:DistributionVolume'
         ObjectArchetype=DistributionFloatUniform'DistributionVolume'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionPitch ObjName=DistributionPitch Archetype=DistributionFloatUniform'Engine.Default__SoundNodeAmbient:DistributionPitch'
         ObjectArchetype=DistributionFloatUniform'DistributionPitch'
      End Object
      Name="SoundNodeAmbient0"
      ObjectArchetype=SoundNodeAmbient'Engine.Default__SoundNodeAmbient'
   End Object
   SoundNodeInstance=SoundNodeAmbient'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0'
   Begin Object Class=AudioComponent Name=AudioComponent0 ObjName=AudioComponent0 Archetype=AudioComponent'Engine.Default__AmbientSound:AudioComponent0'
      PreviewSoundRadius=DrawSoundRadiusComponent'Engine.Default__AmbientSoundSimple:DrawSoundRadius0'
      ObjectArchetype=AudioComponent'Engine.Default__AmbientSound:AudioComponent0'
   End Object
   AudioComponent=AudioComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__AmbientSound:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__AmbientSound:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=AudioComponent0
   Begin Object Class=DrawSoundRadiusComponent Name=DrawSoundRadius0 ObjName=DrawSoundRadius0 Archetype=DrawSoundRadiusComponent'Engine.Default__DrawSoundRadiusComponent'
      Name="DrawSoundRadius0"
      ObjectArchetype=DrawSoundRadiusComponent'Engine.Default__DrawSoundRadiusComponent'
   End Object
   Components(2)=DrawSoundRadius0
   Name="Default__AmbientSoundSimple"
   ObjectArchetype=AmbientSound'Engine.Default__AmbientSound'
}
