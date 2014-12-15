/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTFamilyInfo_Liandri extends UTFamilyInfo
	abstract;

defaultproperties
{
   Faction="Liandri"
   SoundGroupClass=Class'UTGame.UTPawnSoundGroup_Liandri'
   VoiceClass=Class'UTGame.UTVoice_Robot'
   BloodSplatterDecalMaterial=MaterialInstanceTimeVarying'T_FX.DecalMaterials.MITV_FX_OilDecal_Small01'
   NonTeamEmissiveColor=(R=8.000000,G=3.000000,B=1.000000,A=1.000000)
   NonTeamTintColor=(R=3.000000,G=2.000000,B=1.400000,A=1.000000)
   Gibs(0)=(BoneName="b_LeftForeArm",GibClass=Class'UTGame.UTGib_RobotArm')
   Gibs(1)=(BoneName="b_RightForeArm",GibClass=Class'UTGame.UTGib_RobotHand',bHighDetailOnly=True)
   Gibs(2)=(BoneName="b_LeftLeg",GibClass=Class'UTGame.UTGib_RobotLeg')
   Gibs(3)=(BoneName="b_RightLeg",GibClass=Class'UTGame.UTGib_RobotLeg')
   Gibs(4)=(BoneName="b_Spine",GibClass=Class'UTGame.UTGib_RobotTorso')
   Gibs(5)=(BoneName="b_Spine1",GibClass=Class'UTGame.UTGib_RobotChunk',bHighDetailOnly=True)
   Gibs(6)=(BoneName="b_Spine2",GibClass=Class'UTGame.UTGib_RobotChunk',bHighDetailOnly=True)
   Gibs(7)=(BoneName="b_LeftClav",GibClass=Class'UTGame.UTGib_RobotChunk',bHighDetailOnly=True)
   Gibs(8)=(BoneName="b_RightClav",GibClass=Class'UTGame.UTGib_RobotArm',bHighDetailOnly=True)
   HeadGib=(BoneName="b_Head",GibClass=Class'UTGame.UTGib_RobotHead')
   HeadShotEffect=ParticleSystem'T_FX.Effects.P_FX_HeadShot_Corrupt'
   BloodEffects(0)=(Template=ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Far')
   BloodEffects(1)=(Template=ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Mid')
   BloodEffects(2)=(Template=ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Near')
   GibExplosionTemplate=ParticleSystem'T_FX.Effects.P_FX_GibExplode_Corrupt'
   BaseTranslationOffset=14.000000
   DeathCameraEffect=Class'UTGame.UTEmitCameraEffect_OilSplatter'
   Name="Default__UTFamilyInfo_Liandri"
   ObjectArchetype=UTFamilyInfo'UTGame.Default__UTFamilyInfo'
}
