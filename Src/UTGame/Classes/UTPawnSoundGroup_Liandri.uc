/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTPawnSoundGroup_Liandri extends UTPawnSoundGroup;



//Sniper headshot caused robot head to be decapitated from body
//A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_Headshot_Cue

defaultproperties
{
   DodgeSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_Dodge_Cue'
   DoubleJumpSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_DoubleJump_Cue'
   LandSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_LandLight_Cue'
   FallingDamageLandSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_LandHeavy_Cue'
   DyingSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_Death_Cue'
   HitSounds(0)=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_PainSmall_Cue'
   HitSounds(1)=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_PainMedium_Cue'
   HitSounds(2)=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_PainLarge_Cue'
   GibSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_DeathInstant_Cue'
   CrushedSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_BodyExplosion_Cue'
   BodyExplosionSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_RobotImpact_BodyExplosion_Cue'
   InstagibSound=SoundCue'A_Character_CorruptEnigma_Cue.Mean_Efforts.A_Effort_EnigmaMean_DeathInstant_Cue'
   Name="Default__UTPawnSoundGroup_Liandri"
   ObjectArchetype=UTPawnSoundGroup'UTGame.Default__UTPawnSoundGroup'
}
