/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGib_HumanBone extends UTGib_Human;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   GibMeshesData(0)=(TheStaticMesh=StaticMesh'CH_Gore.S_CH_Head_Chunk8',DrawScale=1.500000)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_HumanBone"
   ObjectArchetype=UTGib_Human'UTGame.Default__UTGib_Human'
}
