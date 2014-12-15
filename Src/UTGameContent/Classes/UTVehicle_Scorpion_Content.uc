/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Scorpion_Content extends UTVehicle_Scorpion;

simulated function TeamChanged()
{
	local color newColor;

	Super.TeamChanged();

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		newColor = (Team == 1) ? MakeColor(96,64,255) : MakeColor(255,64,96);
		RightBoosterLight.SetLightProperties(,newColor);
		LeftBoosterLight.SetLightProperties(,newColor);
	}
}

defaultproperties
{
   BrakeLightParameterName="Brake_Light"
   ReverseLightParameterName="Reverse_Light"
   HeadLightParameterName="Green_Glows_Headlights"
   RightBladeStartSocket="Blade_R_Start"
   RightBladeEndSocket="Blade_R_End"
   LeftBladeStartSocket="Blade_L_Start"
   LeftBladeEndSocket="Blade_L_End"
   BladeDamageType=Class'UTGameContent.UTDmgType_ScorpionBlade'
   BladeBreakSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_BladeBreakOff'
   BladeExtendSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_BladeExtend'
   BladeRetractSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_BladeRetract'
   Begin Object Class=AudioComponent Name=ScorpionBoosterSound ObjName=ScorpionBoosterSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_EngineLoop'
      Name="ScorpionBoosterSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BoosterSound=ScorpionBoosterSound
   BoostToolTipIconCoords=(V=841.000000,UL=101.000000,VL=49.000000)
   EjectToolTipIconCoords=(U=93.000000,V=316.000000,UL=46.000000,VL=52.000000)
   SelfDestructDamageType=Class'UTGame.UTDmgType_ScorpionSelfDestruct'
   SelfDestructSoundCue=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Fire'
   SelfDestructReadyCue=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_EjectReadyBeep_Cue'
   SelfDestructWarningSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_DestructionWarning_Cue'
   SelfDestructEnabledSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_EngineThrustStart_Cue'
   SelfDestructEnabledLoop=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_EngineThrustLoop_Cue'
   RedBoostCamAnim=CameraAnim'Camera_FX.VH_Scorpion.C_VH_Scorpion_Boost_Red'
   BlueBoostCamAnim=CameraAnim'Camera_FX.VH_Scorpion.C_VH_Scorpion_Boost_Blue'
   SuspensionShiftSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleCompressD_Cue'
   EjectSoundCue=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Eject_Cue'
   Begin Object Class=PointLightComponent Name=LeftRocketLight ObjName=LeftRocketLight Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Radius=100.000000
      Translation=(X=20.000000,Y=0.000000,Z=0.000000)
      Brightness=3.000000
      LightColor=(B=255,G=64,R=96,A=0)
      bEnabled=False
      CastShadows=False
      Name="LeftRocketLight"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   LeftBoosterLight=LeftRocketLight
   Begin Object Class=PointLightComponent Name=RightRocketLight ObjName=RightRocketLight Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Radius=100.000000
      Translation=(X=20.000000,Y=0.000000,Z=0.000000)
      Brightness=3.000000
      LightColor=(B=255,G=64,R=96,A=0)
      bEnabled=False
      CastShadows=False
      Name="RightRocketLight"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   RightBoosterLight=RightRocketLight
   ScorpionHood=StaticMesh'VH_Scorpion.Mesh.S_VH_Scorpion_Hood_Damaged'
   SelfDestructExplosionTemplate=ParticleSystem'VH_Scorpion.Effects.P_VH_Scorpion_SelfDestruct'
   HatchGibClass=Class'UTGameContent.UTGib_ScorpionHatch'
   BrokenBladeMesh=StaticMesh'VH_Scorpion.Mesh.S_VH_Scorpion_Broken_Blade'
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Scorpion:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Scorpion:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_ScorpionTurret',GunSocket=("TurretFireSocket"),GunPivotPoints=("gun_rotate"),WeaponEffects=((SocketName="TurretFireSocket",Offset=(X=-14.000000,Y=5.000000,Z=0.000000),Scale3D=(X=2.000000,Y=3.000000,Z=3.000000)),(SocketName="TurretFireSocket",Offset=(X=-14.000000,Y=-5.000000,Z=0.000000),Scale3D=(X=2.000000,Y=3.000000,Z=3.000000))),TurretControls=("TurretRotate"),CameraTag="GunViewSocket",CameraBaseOffset=(X=-50.000000,Y=0.000000,Z=0.000000),CameraOffset=-175.000000,SeatIconPOS=(X=0.415000,Y=0.500000))
   VehicleEffects(0)=(EffectStartTag="BoostStart",EffectEndTag="BoostStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Booster_Red',EffectTemplate_Blue=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Booster',EffectSocket="Booster01")
   VehicleEffects(1)=(EffectStartTag="BoostStart",EffectEndTag="BoostStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Booster_Red',EffectTemplate_Blue=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Booster',EffectSocket="Booster02")
   VehicleEffects(2)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Scorpion',EffectSocket="DamageSmoke01")
   VehicleEffects(3)=(EffectStartTag="MuzzleFlash",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Gun_MuzzleFlash_Red',EffectTemplate_Blue=ParticleSystem'VH_Scorpion.Effects.PS_Scorpion_Gun_MuzzleFlash',EffectSocket="TurretFireSocket")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=1.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=1.000000)
   DamageParamScaleLevels(3)=(DamageParamName="Damage5",Scale=1.000000)
   DamageParamScaleLevels(4)=(DamageParamName="Damage6",Scale=1.000000)
   DamageParamScaleLevels(5)=(DamageParamName="Damage7",Scale=1.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_LtFrontFender",LinkedMorphNodeName="MorphNodeW_Hood",InfluenceBone="LtFront_Fender",Health=30,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_RtFrontFender",LinkedMorphNodeName="MorphNodeW_Hood",InfluenceBone="RtFront_Fender",Health=30,DamagePropNames=("Damage2"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeW_LtRearFender",LinkedMorphNodeName="MorphNodeW_Hatch",InfluenceBone="LtRear_Fender",Health=40,DamagePropNames=("Damage1","Damage5"))
   DamageMorphTargets(3)=(MorphNodeName="MorphNodeW_RtRearFender",LinkedMorphNodeName="MorphNodeW_Hatch",InfluenceBone="RtRear_Fender",Health=40,DamagePropNames=("Damage1","Damage5"))
   DamageMorphTargets(4)=(MorphNodeName="MorphNodeW_Hood",LinkedMorphNodeName="MorphNodeW_Hatch",InfluenceBone="Hood",Health=100,DamagePropNames=("Damage3","Damage1"))
   DamageMorphTargets(5)=(MorphNodeName="MorphNodeW_Hatch",LinkedMorphNodeName="MorphNodeW_Body",InfluenceBone="Hatch_Slide",Health=125,DamagePropNames=("Damage1"))
   DamageMorphTargets(6)=(MorphNodeName="MorphNodeW_Body",InfluenceBone="Main_Root",Health=175,DamagePropNames=("Damage6","Damage7"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Scorpion.Materials.MI_VH_Scorpion_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Scorpion.Materials.MI_VH_Scorpion_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Explode'
   Begin Object Class=AudioComponent Name=ScorpionTireSound ObjName=ScorpionTireSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue'
      Name="ScorpionTireSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TireAudioComp=ScorpionTireSound
   TireSoundList(0)=(MaterialType="Dirt",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireDirt01Cue')
   TireSoundList(1)=(MaterialType="Foliage",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireFoliage01Cue')
   TireSoundList(2)=(MaterialType="Grass",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireGrass01Cue')
   TireSoundList(3)=(MaterialType="Metal",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMetal01Cue')
   TireSoundList(4)=(MaterialType="Mud",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireMud01Cue')
   TireSoundList(5)=(MaterialType="Snow",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireSnow01Cue')
   TireSoundList(6)=(MaterialType="Stone",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireStone01Cue')
   TireSoundList(7)=(MaterialType="Wood",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWood01Cue')
   TireSoundList(8)=(MaterialType="Water",Sound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleSurface_TireWater01Cue')
   FlagOffset=(X=-60.000000,Y=25.000000,Z=40.000000)
   IconCoords=(V=39.000000,UL=21.000000,VL=29.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Scorpion.Materials.MI_VH_Scorpion_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Scorpion.Materials.MI_VH_Scorpion_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Scorpion.Materials.MITV_VH_Scorpion_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Scorpion.Materials.MITV_VH_Scorpion_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Scorpion_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'VH_Scorpion.Effects.PS_Wheel_Rocks')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Scorpion_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Snow_Effects.P_Scorpion_Wheel_Snow')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_Reaper.BotStatus.A_BotStatus_Reaper_EnemyScorpion'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyScorpion'
   HudCoords=(U=410.000000,V=112.000000,UL=-86.000000,VL=109.000000)
   Begin Object Class=UTVehicleSimCar Name=SimObject ObjName=SimObject Archetype=UTVehicleSimCar'UTGame.Default__UTVehicle_Scorpion:SimObject'
      ObjectArchetype=UTVehicleSimCar'UTGame.Default__UTVehicle_Scorpion:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleScorpionWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:RRWheel'
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:RRWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleScorpionWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:LRWheel'
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:LRWheel'
   End Object
   Wheels(1)=LRWheel
   Begin Object Class=UTVehicleScorpionWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:RFWheel'
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:RFWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleScorpionWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:LFWheel'
      ObjectArchetype=UTVehicleScorpionWheel'UTGame.Default__UTVehicle_Scorpion:LFWheel'
   End Object
   Wheels(3)=LFWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_12 ObjName=MyStayUprightSetup_12 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Scorpion:MyStayUprightSetup_12'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Scorpion:MyStayUprightSetup_12'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Scorpion_Content:MyStayUprightSetup_12'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_12 ObjName=MyStayUprightConstraintInstance_12 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Scorpion:MyStayUprightConstraintInstance_12'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Scorpion:MyStayUprightConstraintInstance_12'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Scorpion_Content:MyStayUprightConstraintInstance_12'
   Begin Object Class=AudioComponent Name=ScorpionEngineSound ObjName=ScorpionEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_EngineLoop'
      Name="ScorpionEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=ScorpionEngineSound
   Begin Object Class=AudioComponent Name=ScorpionSquealSound ObjName=ScorpionSquealSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Slide'
      Name="ScorpionSquealSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   SquealSound=ScorpionSquealSound
   CollisionSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Start'
   ExitVehicleSound=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Stop'
   SquealThreshold=0.100000
   SquealLatThreshold=0.020000
   LatAngleVolumeMult=30.000000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Scorpion:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Scorpion.Mesh.SK_VH_Scorpion_001'
      AnimTreeTemplate=AnimTree'VH_Scorpion.Anims.AT_VH_Scorpion_001'
      PhysicsAsset=PhysicsAsset'VH_Scorpion.Mesh.SK_VH_Scorpion_001_Physics'
      AnimSets(0)=AnimSet'VH_Scorpion.Anims.K_VH_Scorpion'
      MorphSets(0)=MorphTargetSet'VH_Scorpion.Mesh.VH_Scorpion_MorphTargets'
      RBCollideWithChannels=(Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Scorpion:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Scorpion:CollisionCylinder'
      CollisionHeight=40.000000
      CollisionRadius=100.000000
      Translation=(X=-25.000000,Y=0.000000,Z=0.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Scorpion:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=ScorpionEngineSound
   Components(5)=ScorpionTireSound
   Components(6)=ScorpionSquealSound
   Components(7)=ScorpionBoosterSound
   DrawScale=1.200000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Scorpion_Content"
   ObjectArchetype=UTVehicle_Scorpion'UTGame.Default__UTVehicle_Scorpion'
}
