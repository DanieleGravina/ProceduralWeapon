/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class AudioDevice extends Subsystem
	config( engine )
	native( AudioDevice )
	transient;

struct native Listener
{
	var const PortalVolume PortalVolume;
	var vector Location;
	var vector Up;
	var vector Right;
	var vector Front;
};

/**
 * Enum describing the sound modes available for use in game.
 */
enum ESoundMode
{
	/** Normal - No EQ applied */
	SOUNDMODE_NORMAL,
	/** Slowmo */
	SOUNDMODE_SLOWMOTION,
	/** Death - Death EQ applied */
	SOUNDMODE_DEATH,
	/** Cover - EQ applied to indicate player is in cover */
	SOUNDMODE_COVER,
	/** Roadie Run - Accentuates high-pitched bullet whips, etc. */
	SOUNDMODE_ROADIE_RUN,
	/** TacCom - Tactical command EQ lowers game volumes */
	SOUNDMODE_TACCOM,
	/** Applied to the radio effect */
	SOUNDMODE_RADIO,
};

/**
 * Structure defining a sound mode (used for EQ and volume ducking)
 */
struct native ModeSettings
{
	var	ESoundMode Mode;
	var	float FadeTime;

	structdefaultproperties
	{
		Mode=SOUNDMODE_NORMAL
		FadeTime=0.1
	}
};

/**
 * Structure containing configurable properties of a sound group.
 */
struct native SoundGroupProperties
{
	/** Volume multiplier. */
	var() float Volume;
	/** Pitch multiplier. */
	var() float Pitch;
	/** Voice center channel volume - Not a multiplier (no propagation)	*/
	var() float VoiceCenterChannelVolume;
	/** Radio volume multiplier - Not a multiplier (no propagation) */
	var() float VoiceRadioVolume;

	/** Sound mode voice - whether to apply audio effects */
	var() bool bApplyEffects;
	/** Whether to artificially prioritise the component to play */
	var() bool bAlwaysPlay;
	/** Whether or not this sound plays when the game is paused in the UI */
	var() bool bIsUISound;
	/** Whether or not this is music (propagates only if parent is TRUE) */
	var() bool bIsMusic;
	/** Whether or not this sound group is excluded from reverb EQ */
	var() bool bNoReverb;

	structdefaultproperties
	{
		Volume=1
		Pitch=1
		VoiceCenterChannelVolume=0
		VoiceRadioVolume=0
		bApplyEffects=FALSE
		bAlwaysPlay=FALSE
		bIsUISound=FALSE
		bIsMusic=FALSE
		bNoReverb=FALSE
	}

	structcpptext
	{
		/** Interpolate the data in sound groups */
		void Interpolate( FLOAT InterpValue, FSoundGroupProperties& Start, FSoundGroupProperties& End );
	}
};

/**
 * Structure containing information about a sound group.
 */
struct native SoundGroup
{
	/** Configurable properties like volume and priority. */
	var() SoundGroupProperties	Properties;
	/** Name of this sound group. */
	var() name					GroupName;
	/** Array of names of child sound groups. Empty for leaf groups. */
	var() array<name>			ChildGroupNames;
};

/**
 * Elements of data for sound group volume control
 */
struct native SoundGroupAdjuster
{
	var	name	GroupName;
	var	float	VolumeAdjuster;
	var float	PitchAdjuster;

	structdefaultproperties
	{
		GroupName="Master"
		VolumeAdjuster=1
		PitchAdjuster=1
	}
};

/**
 * Group of adjusters
 */
struct native SoundGroupEffect
{
	var array<SoundGroupAdjuster>	GroupEffect;
};

var		config const	int							MaxChannels;
var		config const	bool						UseEffectsProcessing;

var		transient const	array<AudioComponent>		AudioComponents;
var		native const	array<pointer>				Sources{FSoundSource};
var		native const	array<pointer>				FreeSources{FSoundSource};
var		native const	DynamicMap_Mirror			WaveInstanceSourceMap{TDynamicMap<FWaveInstance*, FSoundSource*>};

var		native const	bool						bGameWasTicking;

var		native const	array<Listener>				Listeners;
var		native const	QWORD						CurrentTick;

/** Map from name to the sound group index - used to index the following 4 arrays */
var		native const	Map_Mirror					NameToSoundGroupIndexMap{TMap<FName, INT>};

/** The sound group constants that we are interpolating from */
var		native const	array<SoundGroup>			SourceSoundGroups;
/** The current state of sound group constants */
var		native const	array<SoundGroup>			CurrentSoundGroups;
/** The sound group constants that we are interpolating to */
var		native const	array<SoundGroup>			DestinationSoundGroups;

/** Array of sound groups read from ini file */
var()	config			array<SoundGroup>			SoundGroups;

/** Array of presets that modify sound groups */
var()	config			array<SoundGroupEffect>		SoundGroupEffects;

/** Interface to audio effects processing */
var		native const	pointer						Effects{class FAudioEffectsManager};

var		native const	ESoundMode					CurrentMode;
var		native const	double						SoundModeStartTime;
var		native const	double						SoundModeEndTime;

/** Interface to text to speech processor */
var		native const	pointer						TextToSpeech{class FTextToSpeech};

var		native const	bool						bTestLowPassFilter;
var		native const	bool						bTestEQFilter;

/** transient master volume multiplier that can be modified at runtime without affecting user settings
 * automatically reset to 1.0 on level change
 */
var transient float TransientMasterVolume;

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
   SoundGroups(0)=(Properties=(Volume=0.240000,Pitch=1.000000),GroupName="Ambient")
   SoundGroups(1)=(Properties=(Volume=1.000000,Pitch=1.000000,bAlwaysPlay=True,bNoReverb=True),GroupName="Announcer")
   SoundGroups(2)=(Properties=(Volume=1.000000,Pitch=1.000000,bAlwaysPlay=True,bIsUISound=True),GroupName="Briefing")
   SoundGroups(3)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Character")
   SoundGroups(4)=(Properties=(Volume=1.000000,Pitch=1.000000,bNoReverb=True),GroupName="Cinematic")
   SoundGroups(5)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="CinematicDialog")
   SoundGroups(6)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Dialog",ChildGroupNames=("StoryDialog","CinematicDialog","Taunts","Briefing"))
   SoundGroups(7)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Item")
   SoundGroups(8)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Master",ChildGroupNames=("SFX","Cinematic","Music","Announcer","VoiceChat","Dialog","MovieEffects","MovieVoice","UI"))
   SoundGroups(9)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="MovieEffects")
   SoundGroups(10)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="MovieVoice")
   SoundGroups(11)=(Properties=(Volume=1.000000,Pitch=1.000000,bAlwaysPlay=True,bNoReverb=True),GroupName="Music")
   SoundGroups(12)=(Properties=(Volume=1.000000,Pitch=1.000000,bNoReverb=True),GroupName="SFX",ChildGroupNames=("Character","Item","Stinger","Vehicle","Weapon"))
   SoundGroups(13)=(Properties=(Volume=1.000000,Pitch=1.000000,bNoReverb=True),GroupName="Stinger")
   SoundGroups(14)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="StoryDialog")
   SoundGroups(15)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Taunts")
   SoundGroups(16)=(Properties=(Volume=1.000000,Pitch=1.000000,bIsUISound=True,bNoReverb=True),GroupName="UI")
   SoundGroups(17)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Vehicle")
   SoundGroups(18)=(Properties=(Volume=1.000000,Pitch=1.000000,bNoReverb=True),GroupName="VoiceChat")
   SoundGroups(19)=(Properties=(Volume=1.000000,Pitch=1.000000),GroupName="Weapon")
   SoundGroupEffects(0)=
   SoundGroupEffects(1)=(GroupEffect=((GroupName="Weapon",PitchAdjuster=0.400000),(GroupName="Ambient",PitchAdjuster=0.400000),(GroupName="Character",PitchAdjuster=0.400000),(GroupName="Item",PitchAdjuster=0.400000),(GroupName="Vehicle",PitchAdjuster=0.400000)))
   Name="Default__AudioDevice"
   ObjectArchetype=Subsystem'Core.Default__Subsystem'
}
