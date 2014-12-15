/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_NightShade_Content extends UTVehicle_NightShade;

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=HoverDust ObjName=HoverDust Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'VH_Nightshade.Effects.P_VH_Nightshade_Ground_Effect'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=-70.000000)
      TickGroup=TG_PostAsyncWork
      Name="HoverDust"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   HoverDustPSC=HoverDust
   TurretName="DeployYaw"
   Begin Object Class=AudioComponent Name=NightShadeStealthResSound ObjName=NightShadeStealthResSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.Portal.Portal_WalkThrough01Cue'
      bStopWhenOwnerDestroyed=True
      Name="NightShadeStealthResSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   StealthResSound=NightShadeStealthResSound
   CloakedSkin=Material'VH_Nightshade.Materials.M_VH_NightShade_Skin'
   SkinTranslucencyName="skintranslucency"
   TeamSkinParamName="SkinColor"
   HitEffectName="HitEffect"
   OverlayColorName="Veh_OverlayColor"
   DeployablePositionOffsets(0)=(X=0.000000,Y=0.000000,Z=0.000000)
   DeployablePositionOffsets(1)=(X=0.000000,Y=0.000000,Z=0.000000)
   DeployablePositionOffsets(2)=(X=0.000000,Y=0.000000,Z=0.000000)
   DeployablePositionOffsets(3)=(X=0.000000,Y=0.000000,Z=0.000000)
   BeamTemplate=ParticleSystem'VH_Nightshade.Effects.P_VH_Nightshade_Maingun_Beam'
   BeamSockets="TurretFireSocket"
   EndPointParamName="LinkBeamEnd"
   Begin Object Class=AudioComponent Name=BeamAmbientSoundComponent ObjName=BeamAmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="BeamAmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BeamAmbientSound=BeamAmbientSoundComponent
   BeamFireSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_FireLoop01_Cue'
   BeamStartSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_FireStart01_Cue'
   BeamStopSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_FireStop01_Cue'
   LinkBeamColors(0)=(B=64,G=64,R=255,A=255)
   LinkBeamColors(1)=(B=255,G=64,R=64,A=255)
   LinkBeamColors(2)=(B=32,G=255,R=32,A=255)
   Begin Object Class=AudioComponent Name=ArmSound ObjName=ArmSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_ArmsMove01_Cue'
      Name="ArmSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TurretArmMoveSound=ArmSound
   DeployTime=3.200000
   UnDeployTime=0.700000
   IdleAnim(0)="Idle"
   IdleAnim(1)="Idle"
   DeployAnim(0)="ArmExtend"
   DeployAnim(1)="ArmRetract"
   DeploySound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_ArmsExtend01_Cue'
   UndeploySound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_ArmsRetract01_Cue'
   ToolTipIconCoords=(U=146.000000,V=317.000000,UL=140.000000,VL=60.000000)
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_NightShade:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_NightShade:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_ManTheNightshade')
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_NightshadeGun_Content',GunSocket=("TurretFireSocket"),GunPivotPoints=("Turret_Pitch"),WeaponEffects=((SocketName="TurretFireSocket",Offset=(X=50.000000,Y=0.000000,Z=0.000000),Scale3D=(X=6.000000,Y=6.000000,Z=6.000000))),TurretControls=("TurretConstraintPitch","TurretConstraintYaw","DeployYaw"),CameraTag="DriverViewSocket",CameraBaseOffset=(X=-70.000000,Y=0.000000,Z=20.000000),CameraOffset=-400.000000,SeatIconPOS=(X=0.490000,Y=0.500000))
   VehicleEffects(0)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_NightShade',EffectSocket="DamageSmoke_01")
   VehicleEffects(1)=(EffectStartTag="BackTurretFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_SecondMuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleAnims(0)=(AnimTag="Deployed",AnimSeqs=("ArmExtendIdle"),AnimRate=1.000000,bAnimLoopLastSeq=True,AnimPlayerName="AnimPlayer")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=6.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=2.500000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=3.000000)
   DamageMorphTargets(0)=(InfluenceBone="LtFrontArm2",Health=175,DamagePropNames=("Damage1","Damage2"))
   DamageMorphTargets(1)=(InfluenceBone="RtFrontArm2",Health=175,DamagePropNames=("Damage1","Damage2"))
   DamageMorphTargets(2)=(InfluenceBone="UpperArm_LtPaddle",Health=175,DamagePropNames=("Damage1","Damage3"))
   DamageMorphTargets(3)=(InfluenceBone="UpperArm_RtPaddle",Health=175,DamagePropNames=("Damage1","Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Nightshade.Materials.MI_VH_NightShade_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Nightshade.Materials.MI_VH_NightShade_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   SpawnInSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeInNecris01Cue'
   SpawnOutSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeOutNecris01Cue'
   IconCoords=(U=909.000000,V=76.000000,UL=27.000000,VL=39.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Nightshade.Materials.MI_VH_NightShade_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Nightshade.Materials.MI_VH_NightShade_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Nightshade.Materials.MITV_VH_NightShade_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Nightshade.Materials.MITV_VH_NightShade_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyNightshade'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyNightshade'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyNightshade'
   HudCoords=(U=95.000000,UL=-95.000000,VL=119.000000)
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicle_NightShade:SimObject'
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicle_NightShade:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=LFThruster ObjName=LFThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:LFThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:LFThruster'
   End Object
   Wheels(0)=LFThruster
   Begin Object Class=UTHoverWheel Name=RFThruster ObjName=RFThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:RFThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:RFThruster'
   End Object
   Wheels(1)=RFThruster
   Begin Object Class=UTHoverWheel Name=LRThruster ObjName=LRThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:LRThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:LRThruster'
   End Object
   Wheels(2)=LRThruster
   Begin Object Class=UTHoverWheel Name=RRThruster ObjName=RRThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:RRThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_NightShade:RRThruster'
   End Object
   Wheels(3)=RRThruster
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_6 ObjName=MyStayUprightSetup_6 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_NightShade:MyStayUprightSetup_6'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_NightShade:MyStayUprightSetup_6'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_NightShade_Content:MyStayUprightSetup_6'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_6 ObjName=MyStayUprightConstraintInstance_6 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_NightShade:MyStayUprightConstraintInstance_6'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_NightShade:MyStayUprightConstraintInstance_6'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_NightShade_Content:MyStayUprightConstraintInstance_6'
   Begin Object Class=AudioComponent Name=NightShadeEngineSound ObjName=NightShadeEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_EngineLoop01_Cue'
      Name="NightShadeEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=NightShadeEngineSound
   CollisionSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_Impact_Cue'
   EnterVehicleSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_EngineStart01_Cue'
   ExitVehicleSound=SoundCue'A_Vehicle_Nightshade.Nightshade.A_Vehicle_Nightshade_EngineStop01_Cue'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_NightShade:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Nightshade.Mesh.SK_VH_NightShade'
      AnimTreeTemplate=AnimTree'VH_Nightshade.Anims.AT_VH_NightShade'
      PhysicsAsset=PhysicsAsset'VH_Nightshade.Mesh.SK_VH_NightShade_Physics'
      AnimSets(0)=AnimSet'VH_Nightshade.Anims.K_VH_NightShade'
      Materials(0)=Material'VH_Nightshade.Materials.M_VH_NightShade'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_NightShade:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_NightShade:CollisionCylinder'
      CollisionHeight=40.000000
      CollisionRadius=140.000000
      Translation=(X=-40.000000,Y=0.000000,Z=40.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_NightShade:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=HoverDust
   Components(5)=NightShadeEngineSound
   Components(6)=ArmSound
   Components(7)=NightShadeStealthResSound
   Components(8)=BeamAmbientSoundComponent
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_NightShade_Content"
   ObjectArchetype=UTVehicle_NightShade'UTGame.Default__UTVehicle_NightShade'
}
