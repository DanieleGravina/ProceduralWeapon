/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class AmbientSoundSimpleToggleable extends AmbientSoundSimple;

/** used to update status of toggleable level placed ambient sounds on clients */
var repnotify bool bCurrentlyPlaying;

var() bool bFadeOnToggle;
var() float FadeInDuration;
var() float FadeInVolumeLevel;
var() float FadeOutDuration;
var() float FadeOutVolumeLevel;

replication
{
	if (Role == ROLE_Authority)
		bCurrentlyPlaying;
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	bCurrentlyPlaying = AudioComponent.bAutoPlay;
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bCurrentlyPlaying')
	{
		if (bCurrentlyPlaying)
		{
			StartPlaying();
		}
		else
		{
			StopPlaying();
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated function StartPlaying()
{
	if (bFadeOnToggle)
	{
		AudioComponent.FadeIn(FadeInDuration,FadeInVolumeLevel);
	}
	else
	{
		AudioComponent.Play();
	}
	bCurrentlyPlaying = TRUE;
}

simulated function StopPlaying()
{
	if (bFadeOnToggle)
	{
		AudioComponent.FadeOut(FadeOutDuration,FadeOutVolumeLevel);
	}
	else
	{
		AudioComponent.Stop();
	}
	bCurrentlyPlaying = FALSE;
}

/**
 * Handling Toggle event from Kismet.
 */
simulated function OnToggle(SeqAct_Toggle Action)
{
	if (Action.InputLinks[0].bHasImpulse || (Action.InputLinks[2].bHasImpulse && !AudioComponent.bWasPlaying))
	{
		StartPlaying();
	}
	else
	{
		StopPlaying();
	}
	// we now need to replicate this Actor so clients get the updated status
	ForceNetRelevant();
}

defaultproperties
{
   FadeInDuration=1.000000
   FadeInVolumeLevel=1.000000
   FadeOutDuration=1.000000
   Begin Object Class=SoundCue Name=SoundCue0 ObjName=SoundCue0 Archetype=SoundCue'Engine.Default__AmbientSoundSimple:SoundCue0'
      ObjectArchetype=SoundCue'Engine.Default__AmbientSoundSimple:SoundCue0'
   End Object
   SoundCueInstance=SoundCue'Engine.Default__AmbientSoundSimpleToggleable:SoundCue0'
   Begin Object Class=SoundNodeAmbient Name=SoundNodeAmbient0 ObjName=SoundNodeAmbient0 Archetype=SoundNodeAmbient'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0'
      Begin Object Class=DistributionFloatUniform Name=DistributionMinRadius ObjName=DistributionMinRadius Archetype=DistributionFloatUniform'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0.DistributionMinRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionMinRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionMaxRadius ObjName=DistributionMaxRadius Archetype=DistributionFloatUniform'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0.DistributionMaxRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionMaxRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionLPFMinRadius ObjName=DistributionLPFMinRadius Archetype=DistributionFloatUniform'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0.DistributionLPFMinRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionLPFMinRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionLPFMaxRadius ObjName=DistributionLPFMaxRadius Archetype=DistributionFloatUniform'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0.DistributionLPFMaxRadius'
         ObjectArchetype=DistributionFloatUniform'DistributionLPFMaxRadius'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionVolume ObjName=DistributionVolume Archetype=DistributionFloatUniform'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0.DistributionVolume'
         ObjectArchetype=DistributionFloatUniform'DistributionVolume'
      End Object
      Begin Object Class=DistributionFloatUniform Name=DistributionPitch ObjName=DistributionPitch Archetype=DistributionFloatUniform'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0.DistributionPitch'
         ObjectArchetype=DistributionFloatUniform'DistributionPitch'
      End Object
      ObjectArchetype=SoundNodeAmbient'Engine.Default__AmbientSoundSimple:SoundNodeAmbient0'
   End Object
   SoundNodeInstance=SoundNodeAmbient'Engine.Default__AmbientSoundSimpleToggleable:SoundNodeAmbient0'
   bAutoPlay=False
   Begin Object Class=AudioComponent Name=AudioComponent0 ObjName=AudioComponent0 Archetype=AudioComponent'Engine.Default__AmbientSoundSimple:AudioComponent0'
      ObjectArchetype=AudioComponent'Engine.Default__AmbientSoundSimple:AudioComponent0'
   End Object
   AudioComponent=AudioComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__AmbientSoundSimple:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__AmbientSoundSimple:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=AudioComponent0
   Begin Object Class=DrawSoundRadiusComponent Name=DrawSoundRadius0 ObjName=DrawSoundRadius0 Archetype=DrawSoundRadiusComponent'Engine.Default__AmbientSoundSimple:DrawSoundRadius0'
      ObjectArchetype=DrawSoundRadiusComponent'Engine.Default__AmbientSoundSimple:DrawSoundRadius0'
   End Object
   Components(2)=DrawSoundRadius0
   bStatic=False
   bNoDelete=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__AmbientSoundSimpleToggleable"
   ObjectArchetype=AmbientSoundSimple'Engine.Default__AmbientSoundSimple'
}
