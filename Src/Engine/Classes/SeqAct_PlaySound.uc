/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_PlaySound extends SeqAct_Latent
	native(Sequence);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Sound cue to play on the targeted actor(s) */
var() SoundCue PlaySound;

/** Additional dead space to append to SoundDuration */
var() float ExtraDelay;

/** Remaining duration of sound, for timing activation of 'Finished' output */
var transient float SoundDuration;

/** Time taken for sound to fade in when action is activated. */
var()	float	FadeInTime;

/** Time take for sound to fade out when Stop input is fired. */
var()	float	FadeOutTime;

/** Volume multiplier propagated to audio component */
var()	float	VolumeMultiplier;

/** Pitch multiplier propagated to audio component */
var()	float	PitchMultiplier;

/** TRUE to suppress display of any subtitles the soundcue may have.  FALSE for normal subtitle behavior. */
var()	bool	bSuppressSubtitles;

/** Was this sound stopped? */
var transient bool bStopped;

defaultproperties
{
   VolumeMultiplier=1.000000
   PitchMultiplier=1.000000
   InputLinks(0)=(LinkDesc="Play")
   InputLinks(1)=(LinkDesc="Stop")
   OutputLinks(0)=(LinkDesc="Out")
   OutputLinks(1)=(LinkDesc="Finished")
   OutputLinks(2)=(LinkDesc="Stopped")
   ObjClassVersion=2
   ObjName="Play Sound"
   ObjCategory="Sound"
   Name="Default__SeqAct_PlaySound"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
