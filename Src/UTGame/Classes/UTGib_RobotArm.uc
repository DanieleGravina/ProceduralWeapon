/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_RobotArm extends UTGib_Robot;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Robot:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Robot:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   GibMeshesData(0)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gibs_Corrupt_Part01',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gibs_Corrupt_Part01_Physics',DrawScale=1.000000)
   GibMeshesData(1)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gibs_Corrupt_Part03',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gibs_Corrupt_Part03_Physics',DrawScale=1.000000)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_RobotArm"
   ObjectArchetype=UTGib_Robot'UTGame.Default__UTGib_Robot'
}
