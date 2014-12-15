//=============================================================================
// Ambient sound, sits there and emits its sound.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class AmbientSound extends Keypoint
	native(Sound);

/** Should the audio component automatically play on load? */
var() bool bAutoPlay;

/** Audio component to play */
var(Audio) editconst const AudioComponent AudioComponent;

/** Is the audio component currently playing? */
var private bool bIsPlaying;

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
   bAutoPlay=True
   Begin Object Class=AudioComponent Name=AudioComponent0 ObjName=AudioComponent0 Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AudioComponent0"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   AudioComponent=AudioComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Keypoint:Sprite'
      Sprite=Texture2D'EngineResources.S_Ambient'
      ObjectArchetype=SpriteComponent'Engine.Default__Keypoint:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=AudioComponent0
   Name="Default__AmbientSound"
   ObjectArchetype=Keypoint'Engine.Default__Keypoint'
}
