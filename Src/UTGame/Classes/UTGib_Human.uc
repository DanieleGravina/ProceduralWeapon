/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTGib_Human extends UTGib
	abstract;

defaultproperties
{
   Begin Object Class=DynamicLightEnvironmentComponent Name=GibLightEnvironmentComp ObjName=GibLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib:GibLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTGib:GibLightEnvironmentComp'
   End Object
   GibLightEnvironment=GibLightEnvironmentComp
   HitSound=SoundCue'A_Character_BodyImpacts.BodyImpacts.A_Character_BodyImpact_GibMix_Cue'
   MITV_DecalTemplate=MaterialInstanceTimeVarying'CH_Gibs.Decals.BloodSplatter'
   MITV_GibMeshTemplate=MaterialInstanceTimeVarying'CH_Gibs.Materials.MITV_CH_Gibs_Gore01'
   MITV_GibMeshTemplateSecondary=MaterialInstanceTimeVarying'CH_Gibs.Materials.MITV_CH_Gibs_Gore01'
   Components(0)=GibLightEnvironmentComp
   Name="Default__UTGib_Human"
   ObjectArchetype=UTGib'UTGame.Default__UTGib'
}
