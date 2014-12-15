/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtPowernode_Content extends UTOnslaughtPowernode
	PerObjectLocalized;


simulated event PreBeginPlay()
{
	Super.PreBeginPlay();

	MITV_NecrisCapturePipesLarge = NecrisCapturePipesLarge.CreateAndSetMaterialInstanceTimeVarying(0);
	MITV_NecrisCapturePipesLarge.SetScalarCurveParameterValue( 'Nec_TubeFadeOut', NecrisCapturePipes_FadeOut_Fast );
	MITV_NecrisCapturePipesLarge.SetScalarStartTime( 'Nec_TubeFadeOut', 0.0f );

	MITV_NecrisCapturePipesSmall = NecrisCapturePipesSmall.CreateAndSetMaterialInstanceTimeVarying(0);
	MITV_NecrisCapturePipesSmall.SetScalarCurveParameterValue( 'Nec_TubeFadeOut', NecrisCapturePipes_FadeOut_Fast );
	MITV_NecrisCapturePipesSmall.SetScalarStartTime( 'Nec_TubeFadeOut', 0.0f );

	MITV_NecrisCaptureGoo = new(Outer) class'MaterialInstanceTimeVarying';
	MITV_NecrisCaptureGoo.SetParent( MaterialInstance'GP_Onslaught.Materials.M_GP_Ons_NecrisNode_GooAnimate' );
	PSC_NecrisGooPuddle.SetMaterialParameter( 'Nec_PuddleOpacity', MITV_NecrisCaptureGoo );
}

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Power_Node_Base'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      bUseAsOccluder=False
      bCastDynamicShadow=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   NodeBase=StaticMeshComponent0
   Begin Object Class=StaticMeshComponent Name=StaticMeshSpinner ObjName=StaticMeshSpinner Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Power_Node_spinners'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bCastDynamicShadow=False
      CollideActors=False
      BlockActors=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Name="StaticMeshSpinner"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   NodeBaseSpinner=StaticMeshSpinner
   TeamGlowColors(0)=(R=30.000000,G=2.250000,B=0.950000,A=1.000000)
   TeamGlowColors(1)=(R=0.900000,G=3.750000,B=40.000000,A=1.000000)
   NeutralGlowColor=(R=7.000000,G=7.000000,B=4.500000,A=1.000000)
   Begin Object Class=CylinderComponent Name=CollisionCylinder2 ObjName=CollisionCylinder2 Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=70.000000
      CollisionRadius=90.000000
      CollideActors=True
      BlockActors=True
      Translation=(X=0.000000,Y=0.000000,Z=400.000000)
      Name="CollisionCylinder2"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   EnergySphereCollision=CollisionCylinder2
   YawRotationRate=20000.000000
   NeutralEffectTemplate=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Neutral'
   ConstructingEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Constructing_Red'
   ConstructingEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Constructing_Blue'
   ActiveEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Center_Red'
   ActiveEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Center_Blue'
   ShieldedActiveEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Center_Red_Shielded'
   ShieldedActiveEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Center_Blue_Shielded'
   Begin Object Class=ParticleSystemComponent Name=CaptureSystem ObjName=CaptureSystem Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      Name="CaptureSystem"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   OrbCaptureComponent=CaptureSystem
   OrbCaptureTemplate(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Orb_Capture_Red'
   OrbCaptureTemplate(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Orb_Capture_Blue'
   ShieldedEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Shielded_Red'
   ShieldedEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Shielded_Blue'
   VulnerableEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Vulnerable_Red'
   VulnerableEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Vulnerable_Blue'
   Begin Object Class=ParticleSystemComponent Name=InvulnerableSystem ObjName=InvulnerableSystem Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      bAutoActivate=False
      HiddenGame=True
      Name="InvulnerableSystem"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   InvulnerableToOrbEffect=InvulnerableSystem
   InvulnerableToOrbTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_GP_Ons_Powernode_OrbShield_Red'
   InvulnerableToOrbTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_GP_Ons_Powernode_OrbShield_Blue'
   DamagedEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Damaged_Red'
   DamagedEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Damaged_Blue'
   DestroyedEffectTemplate=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Destroyed'
   PanelTravelTime=4.000000
   InvulnerableRadius=1000.000000
   FlagLinkEffectTemplates(0)=ParticleSystem'PICKUPS.PowerCell.Effects.P_LinkOrbAndNode_Red'
   FlagLinkEffectTemplates(1)=ParticleSystem'PICKUPS.PowerCell.Effects.P_LinkOrbAndNode_Blue'
   CaptureReturnRadius=500.000000
   Begin Object Class=AudioComponent Name=OrbNearbySoundComponent ObjName=OrbNearbySoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.ONS.OrbNearConduitCue'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="OrbNearbySoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   OrbNearbySound=OrbNearbySoundComponent
   InvEffectZOffset=16.000000
   OrbHealingPerSecond=100
   OrbCaptureInvulnerabilityDuration=12.000000
   Begin Object Class=StaticMeshComponent Name=NecrisCapturePipesLargeComp ObjName=NecrisCapturePipesLargeComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Power_Node_PipeTightLarge'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bCastDynamicShadow=False
      CollideActors=False
      BlockActors=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Name="NecrisCapturePipesLargeComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   NecrisCapturePipesLarge=NecrisCapturePipesLargeComp
   MITV_NecrisCapturePipes_FadeIn=(Points=(,(InVal=4.000000,OutVal=6.000000)))
   MITV_NecrisCapturePipes_FadeIn2=(Points=(,(InVal=0.010000,OutVal=1.000000)))
   NecrisCapturePipes_FadeOut_Fast=(Points=(,(InVal=0.100000)))
   NecrisCapturePuddle_FadeIn50=(Points=(,(InVal=5.000000,OutVal=0.750000)))
   NecrisCapturePuddle_FadeIn100=(Points=((OutVal=0.750000),(InVal=4.000000,OutVal=1.000000)))
   NecrisCapturePuddle_FadeOut=(Points=((OutVal=1.000000),(InVal=4.000000)))
   Begin Object Class=StaticMeshComponent Name=NecrisCapturePipesSmallComp ObjName=NecrisCapturePipesSmallComp Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'GP_Onslaught.Mesh.S_GP_Ons_Power_Node_PipeTightSmall'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bCastDynamicShadow=False
      CollideActors=False
      BlockActors=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Name="NecrisCapturePipesSmallComp"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   NecrisCapturePipesSmall=NecrisCapturePipesSmallComp
   Begin Object Class=UTParticleSystemComponent Name=NecrisCaptureComp ObjName=NecrisCaptureComp Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'GP_Onslaught.Effects.P_GP_Ons_NecrisNode_Wispy'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Name="NecrisCaptureComp"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   PSC_NecrisCapture=NecrisCaptureComp
   Begin Object Class=UTParticleSystemComponent Name=NecrisGoodPuddleComp ObjName=NecrisGoodPuddleComp Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'GP_Onslaught.Effects.P_GP_Ons_PowerNode_NecrisPuddle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=-34.000000)
      Scale=2.500000
      Name="NecrisGoodPuddleComp"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   PSC_NecrisGooPuddle=NecrisGoodPuddleComp
   LinkToSockets(0)="Link01"
   LinkToSockets(1)="Link02"
   PrimeAttackAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_AttackThePrimeNode',AnnouncementText="Attacca il Nodo Primario!")
   PrimeDefendAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_DefendThePrimeNode',AnnouncementText="Difendi il Nodo Primario!")
   EnemyPrimeAttackAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_AttackTheEnemyPrimeNode',AnnouncementText="Attacca il Nodo Primario Nemico!")
   EnemyPrimeDefendAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_DefendThePrimeNode',AnnouncementText="Difendi il Nodo Primario!")
   PanelExplosionTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Expl_Red01'
   PanelExplosionTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Expl_Blue01'
   PanelHealthMax=60
   PanelBonePrefix="NodePanel"
   Begin Object Class=SkeletalMeshComponent Name=SkeletalMeshComponent1 ObjName=SkeletalMeshComponent1 Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'GP_Onslaught.Mesh.SK_GP_Ons_Power_Node_Panels'
      AnimTreeTemplate=AnimTree'GP_Onslaught.Anims.AT_GP_Ons_Power_Node_Panels'
      bUpdateSkelWhenNotRendered=False
      bIgnoreControllersWhenNotRendered=True
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bCastDynamicShadow=False
      Translation=(X=0.000000,Y=0.000000,Z=240.000000)
      Scale3D=(X=1.500000,Y=1.500000,Z=1.250000)
      Name="SkeletalMeshComponent1"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   PanelMesh=SkeletalMeshComponent1
   PanelHealEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Panel_Red'
   PanelHealEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Node_Panel_Blue'
   PanelGibClass=Class'UTGameContent.UTPowerNodePanel'
   DestroyedSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerCoreExplode01Cue'
   ConstructedSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeBuilt01Cue'
   StartConstructionSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeBuild01Cue'
   ActiveSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeNotActive01Cue'
   HealingSound=SoundCue'A_Gameplay.ONS.A_Gameplay_ONS_ConduitAmbient'
   HealedSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeBuilt01Cue'
   DestructionMessageIndex=16
   DestroyedEvent(0)="red_powernode_destroyed"
   DestroyedEvent(1)="blue_powernode_destroyed"
   DestroyedEvent(2)="red_constructing_powernode_destroyed"
   DestroyedEvent(3)="blue_constructing_powernode_destroyed"
   ConstructedEvent(0)="red_powernode_constructed"
   ConstructedEvent(1)="blue_powernode_constructed"
   Begin Object Class=AudioComponent Name=AmbientComponent ObjName=AmbientComponent Archetype=AudioComponent'UTGame.Default__UTOnslaughtPowernode:AmbientComponent'
      ObjectArchetype=AudioComponent'UTGame.Default__UTOnslaughtPowernode:AmbientComponent'
   End Object
   AmbientSoundComponent=AmbientComponent
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent9 ObjName=StaticMeshComponent9 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'Onslaught_Effects.Meshes.S_Onslaught_FX_GodBeam'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowernode_Content:PowerNodeLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bAcceptsLights=False
      CollideActors=False
      BlockActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-1166.000000)
      Scale3D=(X=0.939400,Y=0.939400,Z=3.317000)
      Name="StaticMeshComponent9"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   NodeBeamEffect=StaticMeshComponent9
   ShieldHitSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   HealEffectClasses(0)=Class'UTGameContent.UTOnslaughtNodeHealEffectRed'
   HealEffectClasses(1)=Class'UTGameContent.UTOnslaughtNodeHealEffectBlue'
   CapturedPrimeSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_PrimeNodeCaptured'
   CapturedPrimeSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_PrimeNodeCaptured'
   CapturedPrimeSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_PrimeNodeCaptured'
   CapturedEnemyPrimeSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyPrimeNodeCaptured'
   CapturedEnemyPrimeSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyPrimeNodeCaptured'
   CapturedEnemyPrimeSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyPrimeNodeCaptured'
   AttackingPrimeSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_AttackingPrimeNode'
   AttackingPrimeSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_AttackingPrimeNode'
   AttackingPrimeSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_AttackingPrimeNode'
   AttackingEnemyPrimeSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_AttackingEnemyPrimeNode'
   AttackingEnemyPrimeSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_AttackingEnemyPrimeNode'
   AttackingEnemyPrimeSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_AttackingEnemyPrimeNode'
   HeadingPrimeSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingTowardPrimeNode'
   HeadingPrimeSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingTowardPrimeNode'
   HeadingPrimeSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingTowardPrimeNode'
   HeadingEnemyPrimeSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingTowardEnemyPrimeNode'
   HeadingEnemyPrimeSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingTowardEnemyPrimeNode'
   HeadingEnemyPrimeSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingTowardEnemyPrimeNode'
   DamageCapacity=2000.000000
   LinkHealMult=1.000000
   bHasLocationSpeech=True
   Score=5
   AttackAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_AttackTheNode')
   DefendAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_DefendTheNode')
   bDestinationOnly=False
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtPowernode:CollisionCylinder'
      CollisionHeight=30.000000
      CollisionRadius=160.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtPowernode:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtPowernode:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtPowernode:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTOnslaughtPowernode:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTOnslaughtPowernode:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=LinkRenderingComponent Name=LinkRenderer ObjName=LinkRenderer Archetype=LinkRenderingComponent'UTGame.Default__UTOnslaughtPowernode:LinkRenderer'
      ObjectArchetype=LinkRenderingComponent'UTGame.Default__UTOnslaughtPowernode:LinkRenderer'
   End Object
   Components(3)=LinkRenderer
   Components(4)=AmbientComponent
   Begin Object Class=DynamicLightEnvironmentComponent Name=PowerNodeLightEnvironment ObjName=PowerNodeLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="PowerNodeLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(5)=PowerNodeLightEnvironment
   Components(6)=StaticMeshComponent0
   Components(7)=StaticMeshSpinner
   Components(8)=SkeletalMeshComponent1
   Components(9)=CollisionCylinder2
   Begin Object Class=UTParticleSystemComponent Name=AmbientEffectComponent ObjName=AmbientEffectComponent Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Translation=(X=0.000000,Y=0.000000,Z=128.000000)
      Name="AmbientEffectComponent"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   Components(10)=AmbientEffectComponent
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent1 ObjName=ParticleSystemComponent1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      bAutoActivate=False
      bOverrideLODMethod=True
      SecondsBeforeInactive=1.000000
      LODMethod=PARTICLESYSTEMLODMETHOD_DirectSet
      Translation=(X=0.000000,Y=0.000000,Z=370.000000)
      Name="ParticleSystemComponent1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   Components(11)=ParticleSystemComponent1
   Components(12)=StaticMeshComponent9
   Components(13)=OrbNearbySoundComponent
   Components(14)=CaptureSystem
   Components(15)=InvulnerableSystem
   Components(16)=NecrisGoodPuddleComp
   Components(17)=NecrisCaptureComp
   Components(18)=NecrisCapturePipesLargeComp
   Components(19)=NecrisCapturePipesSmallComp
   bPathColliding=False
   CollisionComponent=CollisionCylinder
   MessageClass=Class'UTGameContent.UTOnslaughtMessage'
   Name="Default__UTOnslaughtPowernode_Content"
   ObjectArchetype=UTOnslaughtPowernode'UTGame.Default__UTOnslaughtPowernode'
}
