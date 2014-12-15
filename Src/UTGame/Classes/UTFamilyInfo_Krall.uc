/**
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*/

class UTFamilyInfo_Krall extends UTFamilyInfo
	abstract;

defaultproperties
{
   Faction="Krall"
   PortraitExtraOffset=(X=35.000000,Y=0.000000,Z=2.000000)
   SoundGroupClass=Class'UTGame.UTPawnSoundGroup_Krall'
   VoiceClass=Class'UTGame.UTVoice_Krall'
   NonTeamEmissiveColor=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   NonTeamTintColor=(R=4.000000,G=3.000000,B=2.000000,A=1.000000)
   Gibs(0)=(BoneName="b_LeftForeArm",GibClass=Class'UTGame.UTGib_KrallArm')
   Gibs(1)=(BoneName="b_RightForeArm",GibClass=Class'UTGame.UTGib_KrallHand',bHighDetailOnly=True)
   Gibs(2)=(BoneName="b_LeftLeg",GibClass=Class'UTGame.UTGib_KrallLeg')
   Gibs(3)=(BoneName="b_RightLeg",GibClass=Class'UTGame.UTGib_KrallLeg')
   Gibs(4)=(BoneName="b_Spine",GibClass=Class'UTGame.UTGib_KrallTorso')
   Gibs(5)=(BoneName="b_RightClav",GibClass=Class'UTGame.UTGib_KrallBone')
   HeadGib=(BoneName="b_Head",GibClass=Class'UTGame.UTGib_KrallHead')
   DefaultMeshScale=1.000000
   BaseTranslationOffset=2.000000
   CameraXOffset=0.300000
   CameraYOffset=-1.600000
   HeroFireOffset=(X=180.000000,Y=-15.000000,Z=-70.000000)
   SuperHeroFireOffset=(X=420.000000,Y=-15.000000,Z=-100.000000)
   HeroMeleeAnimSet=AnimSet'CH_AnimKrall_Hero.Anims.K_AnimKrall_Hero'
   Trustworthiness=-2.500000
   Name="Default__UTFamilyInfo_Krall"
   ObjectArchetype=UTFamilyInfo'UTGame.Default__UTFamilyInfo'
}
