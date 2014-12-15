/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_HumanArm extends UTGib_Human;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   GibMeshesData(0)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gib_HandArm1',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gib_HandArm1_Physics',DrawScale=1.300000,bUseSecondaryGibMeshMITV=True)
   GibMeshesData(1)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gib_HandArm2',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gib_HandArm2_Physics',DrawScale=1.300000,bUseSecondaryGibMeshMITV=True)
   GibMeshesData(2)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Gibs_Arm01',DrawScale=1.300000,bUseSecondaryGibMeshMITV=True)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_HumanArm"
   ObjectArchetype=UTGib_Human'UTGame.Default__UTGib_Human'
}
