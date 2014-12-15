/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_HumanTorso extends UTGib_Human;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   HitSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_BodyImpact_GibLarge_Cue'
   GibMeshesData(0)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gib_Torso',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gib_Torso_Physics',DrawScale=1.300000,bUseSecondaryGibMeshMITV=True)
   GibMeshesData(1)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gib_Ribs',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gib_Ribs_Physics',DrawScale=1.300000,bUseSecondaryGibMeshMITV=True)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_HumanTorso"
   ObjectArchetype=UTGib_Human'UTGame.Default__UTGib_Human'
}
