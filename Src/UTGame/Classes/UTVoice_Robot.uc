/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVoice_Robot extends UTVoice
	abstract;

/** 
BeginSearchRoutine
PlasmaCleanerBurningMoreEfficient

Zap_Alt
TacticalAssessmentComplete
UndesirableLosses
*/

static function bool SendLocationUpdate(Controller Sender, PlayerReplicationInfo Recipient, Name Messagetype, UTGame G, Pawn StatusPawn, optional bool bDontSendMidfield)
{
	return false;
}

defaultproperties
{
   TauntSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_AllVectorsProjectedSuccessfully'
   TauntSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_AnotherFlawedDesign'
   TauntSounds(2)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_BlameTheCoders'
   TauntSounds(3)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_CleanerBurningMoreEfficient'
   TauntSounds(4)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_CollateralDamage'
   TauntSounds(5)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_EndOfLine'
   TauntSounds(6)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_YourProgrammingIsInferior'
   TauntSounds(7)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_IAmTheAlphaAndOmega'
   TauntSounds(8)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_IAmUnstoppable'
   TauntSounds(9)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_IncrementDeathCount'
   TauntSounds(10)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_LiandryBringsYouTomorrowToday'
   TauntSounds(11)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_Llama'
   TauntSounds(12)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_LowestCommonDenominator'
   TauntSounds(13)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_RogueProcessTerminated'
   TauntSounds(14)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_SurvivalOfTheFittest'
   TauntSounds(15)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_TacticsPrevail'
   TauntSounds(16)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_TheTimeForFleshHasEnded'
   WeaponTauntSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_Goo_alt'
   EncouragementSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_Unreal'
   EncouragementSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_Nice'
   ManDownSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_ReroutingCriticalSystems'
   ManDownSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_ISeeTheBlueScreen'
   ManDownSounds(2)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_LoggingCrashDump'
   ManDownSounds(3)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_SystemFailure'
   ManDownSounds(4)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_UnitNeedsRepair'
   FlagKillSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_FlagUnitTerminated'
   FlagKillSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyFlagCarrierDown'
   OrbKillSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyOrbCarrierDown'
   AckSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_Acknowledged'
   AckSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_Affirmative'
   FriendlyFireSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_IncorrectTarget'
   FriendlyFireSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_SameTeam'
   GotYourBackSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_IveGotYourBack'
   GotYourBackSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_GotYourBack'
   GotYourBackSounds(2)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_CoveringYou'
   NeedOurFlagSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_BeginSearchRoutine'
   SniperSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_SurpressTheSniper'
   InPositionSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_UnitInPosition'
   HaveFlagSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_FlagInPossession'
   HaveOrbSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_OrbInPossession'
   UnderAttackSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_UnitBeingOverrun'
   UnderAttackSounds(1)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_MaintainDevense'
   UnderAttackSounds(2)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_UnitRequiresBackup'
   AreaSecureSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_AreaSecure'
   IncomingSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_Incoming'
   EnemyOrbCarrierSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyOrbCarrier'
   EnemyFlagCarrierSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyFlagCarrier'
   EnemyFlagCarrierHereSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyFlagCarrierHere'
   EnemyFlagCarrierHighSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyFlagCarrierGoingHigh'
   EnemyFlagCarrierLowSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_EnemyFlagCarrierGoingLow'
   MidfieldSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_Midfield'
   GotOurFlagSound=SoundNodeWave'A_Character_CorruptEnigma.Mean_BotStatus.A_BotStatus_Corrupt_FlagInPossession'
   TauntAnimSoundMap(0)=(EmoteTag="TauntA",TauntSoundIndex=(3,7,10))
   TauntAnimSoundMap(1)=(EmoteTag="TauntB",TauntSoundIndex=(2,9,12))
   TauntAnimSoundMap(2)=(EmoteTag="TauntC",TauntSoundIndex=(0,13))
   TauntAnimSoundMap(3)=(EmoteTag="TauntD",TauntSoundIndex=(4,5,16))
   TauntAnimSoundMap(4)=(EmoteTag="TauntE",TauntSoundIndex=(6,11,15))
   TauntAnimSoundMap(5)=(EmoteTag="TauntF",TauntSoundIndex=(1,8,14))
   LocationSpeechOffset=3
   Name="Default__UTVoice_Robot"
   ObjectArchetype=UTVoice'UTGame.Default__UTVoice'
}
