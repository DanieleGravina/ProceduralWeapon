/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_KrallTorso extends UTGib_Krall;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Krall:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Krall:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   HitSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_BodyImpact_GibLarge_Cue'
   GibMeshesData(0)=(TheStaticMesh=StaticMesh'CH_Gibs.Mesh.S_CH_Krall_V01_Gibs_Chest',DrawScale=1.300000)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_KrallTorso"
   ObjectArchetype=UTGib_Krall'UTGame.Default__UTGib_Krall'
}
