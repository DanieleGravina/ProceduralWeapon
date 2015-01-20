/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_KrallLeg extends UTGib_Krall;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Krall:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Krall:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   GibMeshesData(0)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Krall_V01_Gibs_Leg',DrawScale=1.000000)
   GibMeshesData(1)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Krall_V01_Gibs_Thigh',DrawScale=1.000000)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_KrallLeg"
   ObjectArchetype=UTGib_Krall'UTGame.Default__UTGib_Krall'
}