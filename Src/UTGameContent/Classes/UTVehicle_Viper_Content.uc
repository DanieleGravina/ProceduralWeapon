/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Viper_Content extends UTVehicle_Viper;

defaultproperties
{
   JumpSound=SoundCue'A_Vehicle_Manta.Sounds.A_Vehicle_Manta_JumpCue'
   DuckSound=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_SquishAttackCue'
   SelfDestructDamageType=Class'UTGameContent.UTDmgType_ViperSelfDestruct'
   SelfDestructSoundCue=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_SelfDestructCue'
   EjectSoundCue=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'
   SelfDestructSpinName="SuicideSpin"
   TimeToRiseForSelfDestruct=1.100000
   SelfDestructReadySnd=SoundCue'A_Vehicle_Viper.SoundCues.A_Vehicle_Viper_SelfDestructReady_Cue'
   ExhaustIndex=4
   SelfDestructEffectTemplate=ParticleSystem'VH_NecrisManta.Effects.P_VH_Viper_SelfDestruct_FlareUp'
   ExhaustParamName="ViperExhaust"
   GlideBlendTime=0.500000
   Begin Object Class=AudioComponent Name=CarveSound ObjName=CarveSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_SlideCue'
      Name="CarveSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   CurveSound=CarveSound
   ViperSelfDestructToolTipIcon=(U=93.000000,V=316.000000,UL=46.000000,VL=52.000000)
   GroundEffectIndices(0)=3
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Viper:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Viper:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_ViperGun',GunSocket=("Gun_Socket_01","Gun_Socket_02"),WeaponEffects=((SocketName="Gun_Socket_01",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=6.000000,Y=5.000000,Z=5.000000)),(SocketName="Gun_Socket_02",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=6.000000,Y=5.000000,Z=5.000000))),CameraTag="ViewSocket",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=-20.000000),CameraOffset=-200.000000,bSeatVisible=True,SeatBone="CharacterAttach",SeatOffset=(X=0.000000,Y=0.000000,Z=50.000000),DriverDamageMult=0.750000,SeatIconPOS=(X=0.475000,Y=0.600000))
   VehicleEffects(0)=(EffectStartTag="MantaWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_NecrisManta.Effects.PS_Viper_Gun_MuzzleFlash',EffectSocket="Gun_Socket_02")
   VehicleEffects(1)=(EffectStartTag="MantaWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_NecrisManta.Effects.PS_Viper_Gun_MuzzleFlash',EffectSocket="Gun_Socket_01")
   VehicleEffects(2)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_NecrisManta',EffectSocket="DamageSmoke01")
   VehicleEffects(3)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_NecrisManta.Effects.PS_Viper_Ground_FX',EffectSocket="GroundEffectSocket")
   VehicleEffects(4)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_NecrisManta.Effects.P_VH_Viper_PowerBall',EffectTemplate_Blue=ParticleSystem'VH_NecrisManta.Effects.P_VH_Viper_PowerBall_Blue',EffectSocket="PowerBallSocket")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=3.500000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=10.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=5.000000)
   DamageMorphTargets(0)=(InfluenceBone="LtFront_TopFin",Health=60,DamagePropNames=("Damage3"))
   DamageMorphTargets(1)=(InfluenceBone="Lt_WingB_Damage",Health=60,DamagePropNames=("Damage1"))
   DamageMorphTargets(2)=(InfluenceBone="Rt_WingB_Damage",Health=60,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(InfluenceBone="RearBody",Health=60,DamagePropNames=("Damage2"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_NecrisManta.Materials.MI_VH_Viper_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_NecrisManta.Materials.MI_VH_Viper_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_ExplosionCue'
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.A_Gameplay_Onslaught_MetalScrape01Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   DrivingAnim="viper_idle_sitting"
   SpawnInSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeInNecris01Cue'
   SpawnOutSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeOutNecris01Cue'
   IconCoords=(U=989.000000,V=43.000000,UL=24.000000,VL=48.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_NecrisManta.Materials.MI_VH_Viper_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_NecrisManta.Materials.MI_VH_Viper_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_NecrisManta.Materials.MITV_VH_Viper_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_NecrisManta.Materials.MITV_VH_Viper_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_Reaper.BotStatus.A_BotStatus_Reaper_EnemyViper'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyViper'
   HudCoords=(U=173.000000,UL=-77.000000,VL=125.000000)
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicle_Viper:SimObject'
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicle_Viper:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Viper:RThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Viper:RThruster'
   End Object
   Wheels(0)=RThruster
   Begin Object Class=UTHoverWheel Name=LThruster ObjName=LThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Viper:LThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Viper:LThruster'
   End Object
   Wheels(1)=LThruster
   Begin Object Class=UTHoverWheel Name=FThruster ObjName=FThruster Archetype=UTHoverWheel'UTGame.Default__UTVehicle_Viper:FThruster'
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTVehicle_Viper:FThruster'
   End Object
   Wheels(2)=FThruster
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_5 ObjName=MyStayUprightSetup_5 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Viper:MyStayUprightSetup_5'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Viper:MyStayUprightSetup_5'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Viper_Content:MyStayUprightSetup_5'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_5 ObjName=MyStayUprightConstraintInstance_5 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Viper:MyStayUprightConstraintInstance_5'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Viper:MyStayUprightConstraintInstance_5'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Viper_Content:MyStayUprightConstraintInstance_5'
   Begin Object Class=AudioComponent Name=MantaEngineSound ObjName=MantaEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_EngineLoopCue'
      Name="MantaEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=MantaEngineSound
   CollisionSound=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_CollisionCue'
   EnterVehicleSound=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_StartCue'
   ExitVehicleSound=SoundCue'A_Vehicle_Viper.Cue.A_Vehicle_Viper_StopCue'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Viper:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_NecrisManta.Mesh.SK_VH_NecrisManta'
      AnimTreeTemplate=AnimTree'VH_NecrisManta.Anims.AT_VH_NecrisManta'
      PhysicsAsset=PhysicsAsset'VH_NecrisManta.Mesh.SK_VH_NecrisManta_Physics'
      AnimSets(0)=AnimSet'VH_NecrisManta.Anims.K_VH_NecrisManta'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Viper:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Viper:CollisionCylinder'
      CollisionHeight=40.000000
      CollisionRadius=100.000000
      Translation=(X=-40.000000,Y=0.000000,Z=40.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Viper:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=MantaEngineSound
   Components(5)=BaseScrapeSound
   Components(6)=CarveSound
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Viper_Content"
   ObjectArchetype=UTVehicle_Viper'UTGame.Default__UTVehicle_Viper'
}
