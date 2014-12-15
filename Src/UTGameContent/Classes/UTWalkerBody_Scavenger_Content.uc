/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTWalkerBody_Scavenger_Content extends UTWalkerBody_Scavenger;

/** The template for the leg orb connectors*/
var ParticleSystem OrbConTemplate[2];

function PostBeginPlay()
{
	local int Idx;

	super.PostBeginPlay();
	// attach leg attach beam emitters to the leg
	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		SkeletalMeshComponent.AttachComponentToSocket(LegAttachBeams[Idx], TopLegSocketName[Idx]);
		OrbConnectionEffect[Idx].SetAbsolute(true,true,true);
		SkeletalMeshComponent.AttachComponentToSocket(OrbConnectionEffect[Idx], TopLegSocketName[Idx]);
	}
}

simulated function TeamChanged()
{
	local int i;
	local MaterialInstanceConstant Instance;


	for(i=0;i<3;++i)
	{
		OrbConnectionEffect[i].DeactivateSystem();
		OrbConnectionEffect[i].SetTemplate(OrbConTemplate[WalkerVehicle.Team==1?1:0]);
		OrbConnectionEffect[i].ActivateSystem();
	}

	// Create the material instance for the legs
	Instance = new(self) class'MaterialInstanceConstant';
	Instance.SetParent( SkeletalMeshComponent.GetMaterial( 0 ) );
	SkeletalMeshComponent.SetMaterial( 0, Instance );

	super.TeamChanged();
}

defaultproperties
{
   OrbConTemplate(0)=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink_Endpoint'
   OrbConTemplate(1)=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink_Endpoint_Blue'
   Begin Object Class=ParticleSystemComponent Name=LegAttachPSC_0 ObjName=LegAttachPSC_0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink'
      SecondsBeforeInactive=1.000000
      Name="LegAttachPSC_0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LegAttachBeams(0)=LegAttachPSC_0
   Begin Object Class=ParticleSystemComponent Name=LegAttachPSC_1 ObjName=LegAttachPSC_1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink'
      SecondsBeforeInactive=1.000000
      Name="LegAttachPSC_1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LegAttachBeams(1)=LegAttachPSC_1
   Begin Object Class=ParticleSystemComponent Name=LegAttachPSC_2 ObjName=LegAttachPSC_2 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink'
      SecondsBeforeInactive=1.000000
      Name="LegAttachPSC_2"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LegAttachBeams(2)=LegAttachPSC_2
   Begin Object Class=ParticleSystemComponent Name=AttachmentPSC_0 ObjName=AttachmentPSC_0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink_Endpoint'
      SecondsBeforeInactive=1.000000
      Name="AttachmentPSC_0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   OrbConnectionEffect(0)=AttachmentPSC_0
   Begin Object Class=ParticleSystemComponent Name=AttachmentPSC_1 ObjName=AttachmentPSC_1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink_Endpoint'
      SecondsBeforeInactive=1.000000
      Name="AttachmentPSC_1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   OrbConnectionEffect(1)=AttachmentPSC_1
   Begin Object Class=ParticleSystemComponent Name=AttachmentPSC_2 ObjName=AttachmentPSC_2 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_LegLink_Endpoint'
      SecondsBeforeInactive=1.000000
      Name="AttachmentPSC_2"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   OrbConnectionEffect(2)=AttachmentPSC_2
   TopLegSocketName(0)="Leg1Socket"
   TopLegSocketName(1)="Leg2Socket"
   TopLegSocketName(2)="Leg3Socket"
   LegAttachBeamEndPointParamName="ScavengerLegEnd"
   ShieldRadius=75.000000
   RetractionBlendName="Retracted"
   SphereCenterName="SphereCenter"
   Begin Object Class=SkeletalMeshComponent Name=LegMeshComponent ObjName=LegMeshComponent Archetype=SkeletalMeshComponent'UTGame.Default__UTWalkerBody_Scavenger:LegMeshComponent'
      SkeletalMesh=SkeletalMesh'VH_Scavenger.Mesh.SK_VH_Scavenger_Legs'
      AnimTreeTemplate=AnimTree'VH_Scavenger.Anim.AT_VH_Scavenger_Legs'
      PhysicsAsset=PhysicsAsset'VH_Scavenger.Mesh.SK_VH_Scavenger_Legs_Physics'
      AnimSets(0)=AnimSet'VH_Scavenger.Anim.K_VH_Scavenger_Legs'
      bForceDiscardRootMotion=True
      bUpdateJointsFromAnimation=True
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWalkerBody_Scavenger:LegMeshComponent'
   End Object
   SkeletalMeshComponent=LegMeshComponent
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle0 ObjName=RB_FootHandle0 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody_Scavenger:RB_FootHandle0'
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody_Scavenger:RB_FootHandle0'
   End Object
   FootConstraints(0)=RB_FootHandle0
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle1 ObjName=RB_FootHandle1 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody_Scavenger:RB_FootHandle1'
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody_Scavenger:RB_FootHandle1'
   End Object
   FootConstraints(1)=RB_FootHandle1
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle2 ObjName=RB_FootHandle2 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody_Scavenger:RB_FootHandle2'
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody_Scavenger:RB_FootHandle2'
   End Object
   FootConstraints(2)=RB_FootHandle2
   FootWaterEffect=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_DarkWalker_Water_Splash'
   FootStepEffects(0)=(MaterialType="Dirt",Sound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Footstep_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_FootImpact_Default')
   FootStepEffects(1)=(MaterialType="Snow",Sound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Footstep_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_FootImpact_Default')
   FootStepEffects(2)=(MaterialType="Water",Sound=SoundCue'A_Vehicle_Scavenger.Scavenger.A_Vehicle_Scavenger_Footstep_Cue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_Scavenger.Effects.P_VH_Scavenger_FootImpact_Default')
   Begin Object Class=DynamicLightEnvironmentComponent Name=LegLightEnvironmentComp ObjName=LegLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTWalkerBody_Scavenger:LegLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTWalkerBody_Scavenger:LegLightEnvironmentComp'
   End Object
   LegLightEnvironment=LegLightEnvironmentComp
   Components(0)=LegLightEnvironmentComp
   Components(1)=LegMeshComponent
   Components(2)=RB_FootHandle0
   Components(3)=RB_FootHandle1
   Components(4)=RB_FootHandle2
   DrawScale=0.700000
   CollisionComponent=LegMeshComponent
   Name="Default__UTWalkerBody_Scavenger_Content"
   ObjectArchetype=UTWalkerBody_Scavenger'UTGame.Default__UTWalkerBody_Scavenger'
}
