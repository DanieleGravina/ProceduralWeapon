/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGib_HumanHead extends UTGib_Human;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib_Human:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   HitSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_BodyImpact_GibMedium_Cue'
   GibMeshesData(0)=(TheStaticMesh=StaticMesh'CH_Gore.S_CH_Head_Chunk11',DrawScale=1.000000)
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_HumanHead"
   ObjectArchetype=UTGib_Human'UTGame.Default__UTGib_Human'
}
