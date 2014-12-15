/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_HumanChunk extends UTGib_Human;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   GibMeshesData(0)=(TheStaticMesh=StaticMesh'CH_Gore.S_CH_Head_Chunk1',DrawScale=2.000000)
   GibMeshesData(1)=(TheStaticMesh=StaticMesh'CH_Gore.S_CH_Head_Chunk3',DrawScale=2.000000)
   GibMeshesData(2)=(TheStaticMesh=StaticMesh'CH_Gore.S_CH_Head_Chunk4',DrawScale=2.000000)
   GibMeshesData(3)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Gibs_Slab03',DrawScale=1.300000)
   GibMeshesData(4)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Gibs_Slab04',DrawScale=1.300000)
   GibMeshesData(5)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Gibs_Slab05',DrawScale=1.300000)
   GibMeshesData(6)=(TheSkelMesh=SkeletalMesh'CH_Gibs.Mesh.SK_CH_Gib_Chunk1',ThePhysAsset=PhysicsAsset'CH_Gibs.Mesh.SK_CH_Gib_Chunk2_Physics',DrawScale=1.300000,bUseSecondaryGibMeshMITV=True)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_HumanChunk"
   ObjectArchetype=UTGib_Human'UTGame.Default__UTGib_Human'
}
