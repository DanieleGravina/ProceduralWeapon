/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtPowerCore_Content extends UTOnslaughtPowerCore;

defaultproperties
{
   bNoCoreSwitch=True
   Begin Object Class=SkeletalMeshComponent Name=CoreBaseMesh ObjName=CoreBaseMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'GP_Onslaught.Mesh.SK_GP_Ons_Power_Core'
      AnimTreeTemplate=AnimTree'GP_Onslaught.Anims.AT_GP_Ons_Power_Core'
      PhysicsAsset=PhysicsAsset'GP_Onslaught.Mesh.SK_GP_Ons_Power_Core_Physics'
      AnimSets(0)=AnimSet'GP_Onslaught.Anims.K_GP_Ons_Power_Core'
      MorphSets(0)=MorphTargetSet'GP_Onslaught.Mesh.SK_GP_Ons_Power_Core_MorphTargets'
      bUpdateSkelWhenNotRendered=False
      bIgnoreControllersWhenNotRendered=True
      bHasPhysicsAssetInstance=True
      bSkelCompFixed=True
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTOnslaughtPowerCore_Content:PowerCoreLightEnvironment'
      bUseAsOccluder=False
      CastShadow=False
      bCastDynamicShadow=False
      CollideActors=True
      BlockActors=True
      BlockZeroExtent=True
      BlockNonZeroExtent=True
      BlockRigidBody=True
      RBChannel=RBCC_Nothing
      RBCollideWithChannels=(Default=True,Pawn=True,Vehicle=True,GameplayPhysics=True,EffectPhysics=True)
      Translation=(X=0.000000,Y=0.000000,Z=-325.000000)
      Name="CoreBaseMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   BaseMesh=CoreBaseMesh
   BaseMaterialColors(0)=(R=50.000000,G=3.000000,B=1.500000,A=1.000000)
   BaseMaterialColors(1)=(R=4.000000,G=12.000000,B=50.000000,A=1.000000)
   Begin Object Class=UTParticleSystemComponent Name=ParticleComponent3 ObjName=ParticleComponent3 Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Center_Blue'
      Translation=(X=0.000000,Y=0.000000,Z=110.000000)
      Name="ParticleComponent3"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   InnerCoreEffect=ParticleComponent3
   InnerCoreEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Center_Red'
   InnerCoreEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Center_Blue'
   MaxEnergyEffectDist=150.000000
   EnergyEndPointParameterNames(0)="Elec_End"
   EnergyEndPointParameterNames(1)="Elec_End2"
   EnergyEndPointBonePrefix="Column"
   EnergyEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Electricity_Red01'
   EnergyEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Electricity01'
   DestructionEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Death_Red01'
   DestructionEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Death_Blue01'
   DestroyedPhysicsAsset=PhysicsAsset'GP_Onslaught.Mesh.SK_GP_Ons_Power_Core_Destroyed_Physics'
   ShieldEffectTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Shielded_Red'
   ShieldEffectTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Shielded_Blue'
   EnergyLightColors(0)=(B=32,G=64,R=247,A=255)
   EnergyLightColors(1)=(B=247,G=96,R=64,A=255)
   Begin Object Class=PointLightComponent Name=LightComponent0 ObjName=LightComponent0 Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Brightness=20.000000
      LightColor=(B=32,G=64,R=247,A=255)
      CastShadows=False
      LightingChannels=(Dynamic=False,CompositeDynamic=False)
      LightShadowMode=LightShadow_Modulate
      Name="LightComponent0"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   EnergyEffectLight=LightComponent0
   ShieldOnSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreUnshieldToShieldCue'
   ShieldOffSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreShieldToUnshieldCue'
   ShieldedAmbientSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreAmbientShieldedCue'
   UnshieldedAmbientSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreAmbientUnshieldedCue'
   DamageWarningSound=SoundCue'A_Gameplay.ONS.Cue.A_Gameplay_ONS_OnsCoreDamage_Cue'
   RedMessageClass=Class'UTGameContent.UTOnslaughtRedCoreMessage'
   BlueMessageClass=Class'UTGameContent.UTOnslaughtBlueCoreMessage'
   DefendingLocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_DefendingOurCore'
   DefendingLocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_DefendingOurCore'
   DefendingLocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_DefendingOurCore'
   EnemyLocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingTowardEnemyCore'
   EnemyLocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingTowardEnemyCore'
   EnemyLocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingTowardEnemyCore'
   AttackingOurCoreSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_AttackingOurCore'
   AttackingOurCoreSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_AttackingOurCore'
   AttackingOurCoreSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_AttackingOurCore'
   DefendingEnemyCoreSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_DefendingEnemyCore'
   DefendingEnemyCoreSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_DefendingEnemyCore'
   DefendingEnemyCoreSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_DefendingEnemyCore'
   AlternateTargetLocOffset=(X=0.000000,Y=0.000000,Z=200.000000)
   PanelExplosionTemplates(0)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Expl_Red01'
   PanelExplosionTemplates(1)=ParticleSystem'GP_Onslaught.Effects.P_Ons_Power_Core_Expl_Blue01'
   PanelMesh=CoreBaseMesh
   PanelGibClass=Class'UTGameContent.UTPowerCorePanel_Content'
   bNeverCalledPrimeNode=True
   DestroyedSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreExplodeCue'
   ConstructedSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeBuilt01Cue'
   StartConstructionSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeBuild01Cue'
   HealingSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeStartBuild01Cue'
   HealedSound=SoundCue'A_Gameplay.A_Gameplay_Onslaught_PowerNodeBuilt01Cue'
   Begin Object Class=AudioComponent Name=AmbientComponent ObjName=AmbientComponent Archetype=AudioComponent'UTGame.Default__UTOnslaughtPowerCore:AmbientComponent'
      ObjectArchetype=AudioComponent'UTGame.Default__UTOnslaughtPowerCore:AmbientComponent'
   End Object
   AmbientSoundComponent=AmbientComponent
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent9 ObjName=StaticMeshComponent9 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'Onslaught_Effects.Meshes.S_Onslaught_FX_GodBeam'
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
   AttackingLocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_AttackingEnemyCore'
   AttackingLocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_AttackingEnemyCore'
   AttackingLocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_AttackingEnemyCore'
   DamageCapacity=5000.000000
   bAllowRemoteUse=True
   bAllowOnlyShootable=True
   bHasLocationSpeech=True
   DefensePriority=10
   IconCoords=(U=488.000000,V=266.000000,UL=48.000000,VL=42.000000)
   MaxSensorRange=4000.000000
   CameraViewDistance=800.000000
   AttackAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_AttackTheEnemyCore')
   DefendAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_DefendYourCore')
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingTowardOurCore'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingTowardOurCore'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingTowardOurCore'
   bMustTouchToReach=False
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtPowerCore:CollisionCylinder'
      CollisionHeight=200.000000
      CollisionRadius=240.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtPowerCore:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtPowerCore:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtPowerCore:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTOnslaughtPowerCore:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTOnslaughtPowerCore:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=LinkRenderingComponent Name=LinkRenderer ObjName=LinkRenderer Archetype=LinkRenderingComponent'UTGame.Default__UTOnslaughtPowerCore:LinkRenderer'
      ObjectArchetype=LinkRenderingComponent'UTGame.Default__UTOnslaughtPowerCore:LinkRenderer'
   End Object
   Components(3)=LinkRenderer
   Components(4)=AmbientComponent
   Begin Object Class=DynamicLightEnvironmentComponent Name=PowerCoreLightEnvironment ObjName=PowerCoreLightEnvironment Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      bCastShadows=False
      bDynamic=False
      Name="PowerCoreLightEnvironment"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   Components(5)=PowerCoreLightEnvironment
   Components(6)=CoreBaseMesh
   Components(7)=ParticleComponent3
   Components(8)=LightComponent0
   Components(9)=StaticMeshComponent9
   DrawScale=0.600000
   CollisionComponent=CoreBaseMesh
   MessageClass=Class'UTGameContent.UTOnslaughtMessage'
   SupportedEvents(5)=Class'UTGame.UTSeqEvent_PowerCoreDestructionEffect'
   Name="Default__UTOnslaughtPowerCore_Content"
   ObjectArchetype=UTOnslaughtPowerCore'UTGame.Default__UTOnslaughtPowerCore'
}
