/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SeqAct_CrossFadeMusicTracks extends SeqAct_Latent
	native(Sequence);

/**
 * This is the TrackBank that should be used if there is one not attached.
 * This would be used to have the CrossFade on a lower level that doesn't have the TrackBank attached
 * and that we know that the music has already been stopped.
 **/
var() name TrackBankName;

// internal
var name CurrTrackType;
var AudioComponent CurrPlayingTrack;

var float AdjustVolumeDuration;
var float AdjustVolumeLevel;

var float				NextTrackToPlayAt;
var MusicTrackStruct	NextTrackToPlay;

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

/** crossfades to the specified track */
native final function CrossFadeTrack(const out MusicTrackStruct TrackToPlay);

/** crossfades to the specified track immediately without any delay*/
native final function ClientSideCrossFadeTrackImmediately(const out MusicTrackStruct TrackToPlay);

/** This will stop all of the music that is currently playing via SeqAct_CrossFadeMusicTracks SeqActs **/
native static function StopAllMusicManagerSounds();

defaultproperties
{
   NextTrackToPlay=(Params=(FadeInTime=5.000000,FadeInVolumeLevel=1.000000,FadeOutTime=5.000000))
   InputLinks(0)=(LinkDesc="CrossFade")
   InputLinks(1)=(LinkDesc="CrossFade To Custom")
   InputLinks(2)=(LinkDesc="CrossFade To Track's FadeOutVolumeLevel")
   InputLinks(3)=(LinkDesc="Adjust Volume of Currently Playing Track")
   OutputLinks(0)=(LinkDesc="Out")
   VariableLinks(0)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="TrackTypeToFadeTo",PropertyName=,MaxVars=1)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_MusicTrackBank',LinkDesc="MusicTrackBank",MinVars=1,MaxVars=1)
   VariableLinks(2)=(ExpectedType=Class'Engine.SeqVar_MusicTrack',LinkDesc="CustomMusicTrack",MinVars=1,MaxVars=1)
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="AdjustVolumeDuration",MinVars=1,MaxVars=1)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="AdjustVolumeLevel",MinVars=1,MaxVars=1)
   ObjClassVersion=5
   ObjName="CrossFadeMusicTracks"
   ObjCategory="Sound"
   Name="Default__SeqAct_CrossFadeMusicTracks"
   ObjectArchetype=SeqAct_Latent'Engine.Default__SeqAct_Latent'
}
