/**
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*/

class UTFamilyInfo_Necris_Male extends UTFamilyInfo_Necris
	abstract;

defaultproperties
{
   FamilyID="NECM"
   NeckStumpName="SK_CH_Necris_Male_NeckStump01"
   PhysAsset=PhysicsAsset'CH_AnimHuman.Mesh.SK_CH_BaseMale_Physics'
   AnimSets(0)=AnimSet'CH_AnimHuman.Anims.K_AnimHuman_BaseMale'
   VoiceClass=Class'UTGame.UTVoice_NecrisMale'
   BaseMICParent=MaterialInstanceConstant'CH_All.Materials.MI_CH_All_Necris_Base'
   BioDeathMICParent=MaterialInstanceConstant'CH_All.Materials.MI_CH_All_Necris_BioDeath'
   MasterSkeleton=SkeletalMesh'CH_All.Mesh.SK_Master_Skeleton_Human_Male'
   CharEditorIdleAnimName="CC_Human_Male_Idle"
   DefaultMeshScale=1.025000
   BaseTranslationOffset=6.000000
   Name="Default__UTFamilyInfo_Necris_Male"
   ObjectArchetype=UTFamilyInfo_Necris'UTGame.Default__UTFamilyInfo_Necris'
}
