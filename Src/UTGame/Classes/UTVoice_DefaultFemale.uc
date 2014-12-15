/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVoice_DefaultFemale extends UTVoice
	abstract;

/**
UNUSED TAUNTS

WeveTakenTheLeadHoldThemOff
WhatsTakingSoLong
WhereAreYou
WhereTheHellAreYou
ProfessionalQuality_a-01

*/


static function int GetEncouragementMessageIndex(Controller Sender, PlayerReplicationInfo Recipient, Name Messagetype)
{
	local int R;
	
	if ( default.EncouragementSounds.Length == 0)
	{
		return -1;
	}
	R = Rand(default.EncouragementSounds.Length);
	if ( ( R == 1) || (R == 5) )
	{ 
		R -= 1;
	} 
	return ENCOURAGEMENTINDEXSTART + R;
}

defaultproperties
{
   TauntSounds(0)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_AndAnotherThankYouVeryMuch'
   TauntSounds(1)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_AndILookGoodDoingItToo'
   TauntSounds(2)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_AndStayDown'
   TauntSounds(3)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_BeatenByAGirl'
   TauntSounds(4)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_BetterLuckNextTime'
   TauntSounds(5)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_BoomBaby'
   TauntSounds(6)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_BooYa'
   TauntSounds(7)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_DamnImGood'
   TauntSounds(8)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_DeathWarrantEnforced'
   TauntSounds(9)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_Eliminated'
   TauntSounds(10)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_HoldStillDamnit'
   TauntSounds(11)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IAmazeMyself'
   TauntSounds(12)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IDontWantThatShitInMyHair'
   TauntSounds(13)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IHateItWhenThatHappens'
   TauntSounds(14)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatsOneMoreForTheGirl'
   TauntSounds(15)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_NextTimeTryNotToSuck'
   TauntSounds(16)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_OhYeah'
   TauntSounds(17)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatsJustWrong'
   TauntSounds(18)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_SeeYa'
   TauntSounds(19)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_StepAside'
   TauntSounds(20)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_WhoWantsSome'
   TauntSounds(21)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_YoullFeelTheImpactOfThatOne'
   TauntSounds(22)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_TopThat'
   TauntSounds(23)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_FreezeFrameMoment'
   TauntSounds(24)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IsThatYourBest'
   TauntSounds(25)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ItDoesntGetAnyBetterThanThat'
   TauntSounds(26)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatsOneMoreForTheGirl'
   TauntSounds(27)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IThinkIveMadeMyPoint'
   TauntSounds(28)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_OhSmack'
   TauntSounds(29)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatsOneForTheCameras'
   TauntSounds(30)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatsSoEmbarassing'
   WeaponTauntSounds(0)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_Biohazard'
   WeaponTauntSounds(1)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_GreenIsDefinitelyYourColor'
   WeaponTauntSounds(2)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_OneShotOneKill'
   WeaponTauntSounds(3)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IJustSlaughteredThatGuy'
   WeaponTauntSounds(4)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_Shocking'
   WeaponTauntSounds(5)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatWasAMess'
   WeaponTauntSounds(6)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_FlakAttack'
   EncouragementSounds(0)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_GoodOne'
   EncouragementSounds(1)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_HatingYou'
   EncouragementSounds(2)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_NiceMove'
   EncouragementSounds(3)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_KeepItUp'
   EncouragementSounds(4)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_OhYeah'
   EncouragementSounds(5)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatHadToHurt'
   EncouragementSounds(6)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_NoWay'
   EncouragementSounds(7)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_Damn'
   ManDownSounds(0)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_AnyoneOutThere'
   ManDownSounds(1)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_Bullshit'
   ManDownSounds(2)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_IllRememberThat'
   ManDownSounds(3)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_NotOneOfMyBetterMoments'
   ManDownSounds(4)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_WellThatJustSucked'
   ManDownSounds(5)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_ThatPlanFailed'
   ManDownSounds(6)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_WhyAmIAlwaysFirstToGetShot'
   FlagKillSounds(0)=SoundNodeWave'A_Character_Jester.Taunts.A_Taunt_Jester_NailedTheFlagCarrier'
   FlagKillSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyFlagCarrierDown'
   OrbKillSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyOrbCarrierDown'
   AckSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_Acknowledged'
   AckSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_Affirmative'
   AckSounds(2)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_GotIt'
   AckSounds(3)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_OnIt'
   AckSounds(4)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_Roger'
   AckSounds(5)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_RogerThat'
   AckSounds(6)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_ImOnIt'
   FriendlyFireSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_YourTeam'
   FriendlyFireSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_SameTeam'
   FriendlyFireSounds(2)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_ImOnYourTeam'
   FriendlyFireSounds(3)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_ImOnYourTeamIdiot'
   FriendlyFireSounds(4)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_FriendlyFire'
   GotYourBackSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_IveGotYourBack'
   GotYourBackSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_GotYourBack'
   GotYourBackSounds(2)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_CoveringYou'
   NeedOurFlagSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_SomebodyGetOurFlagBack'
   SniperSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_Sniper'
   SniperSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_SuppressTheSniper'
   InPositionSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_ImInPosition'
   InPositionSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_InPosition'
   HaveFlagSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_IHaveTheFlag'
   HaveFlagSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_IveGotTheFlag'
   HaveOrbSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_IHaveTheOrb'
   HaveOrbSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_IveGotTheOrb'
   UnderAttackSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_UnderHeavyAttack'
   UnderAttackSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_ImBeingOverrun'
   UnderAttackSounds(2)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_ImTakingHeavyFire'
   UnderAttackSounds(3)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_INeedBackup'
   UnderAttackSounds(4)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_INeedSomeBackup'
   AreaSecureSounds(0)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_AllClear'
   AreaSecureSounds(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_AreaSecure'
   IncomingSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_Incoming'
   EnemyOrbCarrierSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyOrbCarrier'
   EnemyFlagCarrierSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyFlagCarrier'
   EnemyFlagCarrierHereSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyFlagCarrier'
   EnemyFlagCarrierHighSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyFlagCarrierGoingHigh'
   EnemyFlagCarrierLowSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyFlagCarrierGoingLow'
   MidfieldSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_Midfield'
   GotOurFlagSound=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_IveGotOurFlag'
   TauntAnimSoundMap(0)=(EmoteTag="TauntA",TauntSoundIndex=(3,5,16,14,20))
   TauntAnimSoundMap(1)=(EmoteTag="TauntB",TauntSoundIndex=(0,6,11,19))
   TauntAnimSoundMap(2)=(EmoteTag="TauntC",TauntSoundIndex=(1,7,14,28,29,26))
   TauntAnimSoundMap(3)=(EmoteTag="TauntD",TauntSoundIndex=(4,8,18,21))
   TauntAnimSoundMap(4)=(EmoteTag="TauntE",TauntSoundIndex=(10,24))
   TauntAnimSoundMap(5)=(EmoteTag="TauntF",TauntSoundIndex=(2,9,15))
   LocationSpeechOffset=1
   Name="Default__UTVoice_DefaultFemale"
   ObjectArchetype=UTVoice'UTGame.Default__UTVoice'
}
