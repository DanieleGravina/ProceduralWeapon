/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVoice_Krall extends UTVoice
	abstract;

/** 
HonorableDeath
*/

static function bool SendLocationUpdate(Controller Sender, PlayerReplicationInfo Recipient, Name Messagetype, UTGame G, Pawn StatusPawn, optional bool bDontSendMidfield)
{
	return false;
}

defaultproperties
{
   TauntSounds(0)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_Bleed'
   TauntSounds(1)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_AngryRoar_alt'
   TauntSounds(2)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_DieEnemy'
   TauntSounds(3)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_ForTribe'
   TauntSounds(4)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_FreshMeat'
   TauntSounds(5)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_Hatred'
   TauntSounds(6)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_HunterBecomesPrey'
   TauntSounds(7)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_ItFearsUs'
   TauntSounds(8)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_ItHasNoEscape'
   TauntSounds(9)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_PraiseOurSkill'
   TauntSounds(10)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_Punished'
   TauntSounds(11)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_Shame'
   TauntSounds(12)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_SmellBurningMeatMakeHungry'
   TauntSounds(13)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_Useless'
   WeaponTauntSounds(0)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_Slime'
   WeaponTauntSounds(2)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_OneShot'
   WeaponTauntSounds(5)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_HammerMessy'
   WeaponTauntSounds(7)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_RocketsGoBoom'
   EncouragementSounds(0)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_AngryRoar_alt'
   EncouragementSounds(1)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_Nice'
   ManDownSounds(0)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_AngryRoar_alt'
   FlagKillSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyFlagCarrierDown'
   OrbKillSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyOrbCarrierDown'
   AckSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_GotIt'
   FriendlyFireSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_SameTeam'
   GotYourBackSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_GotYourBack'
   NeedOurFlagSounds(0)=SoundNodeWave'A_Character_CorruptEnigma.Mean_Taunts.A_Taunt_Corrupt_BeginSearchRoutine'
   SniperSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_Sniper'
   InPositionSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_InPosition'
   HaveFlagSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_WeCarryFlag'
   HaveOrbSounds(0)=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_WeCarryOrb'
   UnderAttackSounds(0)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_AngryRoar_alt'
   AreaSecureSounds(0)=SoundNodeWave'A_Character_KrallScythe.Taunts.A_Taunt_Scythe_AngryRoar_alt'
   IncomingSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_Incoming'
   EnemyOrbCarrierSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyOrbCarrier'
   EnemyFlagCarrierSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyFlagCarrier'
   EnemyFlagCarrierHereSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyFlagCarrierHere'
   EnemyFlagCarrierHighSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyFlagCarrierGoingHigh'
   EnemyFlagCarrierLowSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_EnemyFlagCarrierGoingLow'
   MidfieldSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_Midfield'
   GotOurFlagSound=SoundNodeWave'A_Character_KrallGrobar.BotStatus.A_BotStatus_Krall_WeSeeFlag'
   TauntAnimSoundMap(0)=(EmoteTag="TauntA",TauntSoundIndex=(1,7,12))
   TauntAnimSoundMap(1)=(EmoteTag="TauntB",TauntSoundIndex=(6,9))
   TauntAnimSoundMap(2)=(EmoteTag="TauntC",TauntSoundIndex=(5,11))
   TauntAnimSoundMap(3)=(EmoteTag="TauntD",TauntSoundIndex=(2,13))
   TauntAnimSoundMap(4)=(EmoteTag="TauntE",TauntSoundIndex=(4,8))
   TauntAnimSoundMap(5)=(EmoteTag="TauntF",TauntSoundIndex=(0,10))
   LocationSpeechOffset=3
   Name="Default__UTVoice_Krall"
   ObjectArchetype=UTVoice'UTGame.Default__UTVoice'
}
