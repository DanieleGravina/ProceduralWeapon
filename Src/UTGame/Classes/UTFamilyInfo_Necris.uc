/**
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*/

class UTFamilyInfo_Necris extends UTFamilyInfo_Human
	abstract;

defaultproperties
{
   Faction="Necris"
   ArmMeshPackageName="CH_Necris_Arms"
   ArmMeshName="CH_Necris_Arms.Mesh.SK_CH_Necris_Arms_MaleA_1P"
   ArmSkinPackageName="CH_Necris_Arms"
   RedArmSkinName="CH_Necris_Arms.Materials.MI_CH_Necris_FirstPersonArms_VRed"
   BlueArmSkinName="CH_Necris_Arms.Materials.MI_CH_Necris_FirstPersonArms_VBlue"
   SoundGroupClass=Class'UTGame.UTPawnSoundGroup_NecrisMale'
   NonTeamEmissiveColor=(R=1.500000,G=1.000000,B=0.360000,A=1.000000)
   NonTeamTintColor=(R=3.000000,G=3.000000,B=2.000000,A=1.000000)
   Trustworthiness=-2.500000
   Name="Default__UTFamilyInfo_Necris"
   ObjectArchetype=UTFamilyInfo_Human'UTGame.Default__UTFamilyInfo_Human'
}
