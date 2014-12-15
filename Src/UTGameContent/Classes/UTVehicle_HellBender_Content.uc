/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_HellBender_Content extends UTVehicle_HellBender;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	PlayVehicleAnimation('Inactive');
}
simulated function TakeRadiusDamage( Controller InstigatedBy, float BaseDamage, float DamageRadius, class<DamageType> DamageType,
				float Momentum, vector HurtOrigin, bool bFullDamage, Actor DamageCauser )
{
	if ( Role < ROLE_Authority )
		return;

	// don't take damage from own combos
	if (DamageType != class'UTDmgType_VehicleShockChain' || InstigatedBy != Controller)
	{
		Super.TakeRadiusDamage(InstigatedBy, BaseDamage, DamageRadius, DamageType, Momentum, HurtOrigin, bFullDamage, DamageCauser);
	}
}

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local ParticleSystemComponent ShockBeam;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	// Handle Beam Effects for the shock beam

	if (!IsZero(HitLocation))
	{
		ShockBeam = WorldInfo.MyEmitterPool.SpawnEmitter(BeamTemplate, GetEffectLocation(SeatIndex));
		ShockBeam.SetVectorParameter('ShotEnd', HitLocation);
	}
}

defaultproperties
{
   Begin Object Class=AudioComponent Name=HellbenderSusShift ObjName=HellbenderSusShift Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Generic.Vehicle.VehicleCompressC_Cue'
      Name="HellbenderSusShift"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   SuspensionShiftSound=HellbenderSusShift
   ExhaustEffectName="ExhaustVel"
   BrakeLightParameterName="Brake_Light"
   ReverseLightParameterName="Reverse_Light"
   BeamTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_Prim_Altfire'
   PlateBO(0)=MaterialInstanceTimeVarying'VH_Hellbender.Materials.MITV_VH_Hellbender_LP_BO'
   PlateBO(1)=MaterialInstanceTimeVarying'VH_Hellbender.Materials.MITV_VH_Hellbender_LP_BO'
   PlateTeamMaterials(0)=MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_LP_Red'
   PlateTeamMaterials(1)=MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_LP_Blue'
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_HellBender:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_HellBender:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_ShockTurret',GunSocket=("GunnerFireSocket"),GunPivotPoints=("SecondaryTurretYaw"),WeaponEffects=((SocketName="GunnerFireSocket",Offset=(X=-35.000000,Y=0.000000,Z=0.000000),Scale3D=(X=4.000000,Y=6.500000,Z=6.500000))),TurretControls=("GunnerConstraint","GunnerConstraintYaw"),CameraTag="DriverViewSocket",CameraBaseOffset=(X=-50.000000,Y=0.000000,Z=20.000000),CameraOffset=-300.000000,MuzzleFlashLightClass=Class'UTGame.UTShockMuzzleFlashLight',SeatIconPOS=(X=0.440000,Y=0.480000))
   Seats(1)=(GunClass=Class'UTGameContent.UTVWeap_HellBenderPrimary',GunSocket=("TurretFireSocket"),GunPivotPoints=("MainTurretYaw"),TurretVarPrefix="Turret",WeaponEffects=((SocketName="TurretFireSocket",Offset=(X=-36.000000,Y=0.000000,Z=0.000000),Scale3D=(X=6.500000,Y=8.000000,Z=8.000000))),TurretControls=("TurretConstraintPitch","TurretConstraintYaw"),CameraTag="TurretViewSocket",CameraOffset=-256.000000,CameraEyeHeight=20.000000,bSeatVisible=True,SeatBone="MainTurretYaw",SeatOffset=(X=37.000000,Y=0.000000,Z=-12.000000),MuzzleFlashLightClass=Class'UTGame.UTTurretMuzzleFlashLight',ImpactFlashLightClass=Class'UTGame.UTShockMuzzleFlashLight',DriverDamageMult=0.200000,SeatIconPOS=(X=0.440000,Y=0.800000))
   VehicleEffects(0)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Hellbender',EffectSocket="DamageSmoke01")
   VehicleEffects(1)=(EffectStartTag="ShockTurretFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_DriverPrimMuzzleFlash',EffectSocket="GunnerFireSocket")
   VehicleEffects(2)=(EffectStartTag="ShockTurretAltFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_DriverAltMuzzleFlash',EffectSocket="GunnerFireSocket")
   VehicleEffects(3)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_GenericExhaust',EffectSocket="ExhaustLeft")
   VehicleEffects(4)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_GenericExhaust',EffectSocket="ExhaustRight")
   VehicleEffects(5)=(EffectStartTag="BackTurretFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_SecondMuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleAnims(0)=(AnimTag="EngineStart",AnimSeqs=("GetIn"),AnimRate=1.000000,AnimPlayerName="AnimPlayer")
   VehicleAnims(1)=(AnimTag="Idle",AnimSeqs=("Idle"),AnimRate=1.000000,bAnimLoopLastSeq=True,AnimPlayerName="AnimPlayer")
   VehicleAnims(2)=(AnimTag="EngineStop",AnimSeqs=("GetOut"),AnimRate=1.000000,AnimPlayerName="AnimPlayer")
   VehicleAnims(3)=(AnimTag="Inactive",AnimSeqs=("InActiveIdle"),AnimRate=1.000000,bAnimLoopLastSeq=True,AnimPlayerName="AnimPlayer")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=3.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=3.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=3.000000)
   DamageParamScaleLevels(3)=(DamageParamName="Damage6",Scale=3.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_Front",InfluenceBone="FrontBumper",Health=200,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_RearLt",InfluenceBone="Lt_Rear_Suspension",Health=100,DamagePropNames=("Damage3"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeW_RearRt",InfluenceBone="Rt_Rear_Suspension",Health=100,DamagePropNames=("Damage3"))
   DamageMorphTargets(3)=(MorphNodeName="MorphNodeW_Left",InfluenceBone="Lt_Door",Health=150,DamagePropNames=("Damage1"))
   DamageMorphTargets(4)=(MorphNodeName="MorphNodeW_Right",InfluenceBone="Rt_Door",Health=150,DamagePropNames=("Damage1"))
   DamageMorphTargets(5)=(MorphNodeName="MorphNodeW_Top",InfluenceBone="Antenna1",Health=200,DamagePropNames=("Damage6"))
   DamageMorphTargets(6)=(MorphNodeName="MorphNodeW_LtFrontFender",InfluenceBone="Lt_Front_Suspension",Health=75)
   DamageMorphTargets(7)=(MorphNodeName="MorphNodeW_RtFrontFender",InfluenceBone="Rt_Front_Suspension",Health=75)
   TeamMaterials(0)=MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_Explode'
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
   DrivingAnim="Hellbender_Idle_Sitting"
   FlagOffset=(X=9.000000,Y=-44.000000,Z=80.000000)
   IconCoords=(U=886.000000,V=35.000000,UL=19.000000)
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=60.000000)
   PassengerTeamBeaconOffset=(X=-125.000000,Y=0.000000,Z=100.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Hellbender.Materials.MI_VH_Hellbender_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Hellbender.Materials.MITV_VH_Hellbender_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Hellbender.Materials.MITV_VH_Hellbender_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Hellbender_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dirt_Effects.P_Hellbender_Wheel_Dirt')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Hellbender_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Snow_Effects.P_Hellbender_Wheel_Snow')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyHellbender'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyHellbender'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyHellbender'
   HudCoords=(U=826.000000,UL=-81.000000,VL=115.000000)
   Begin Object Class=UTVehicleSimHellbender Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHellbender'UTGame.Default__UTVehicle_HellBender:SimObject'
      ObjectArchetype=UTVehicleSimHellbender'UTGame.Default__UTVehicle_HellBender:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleHellbenderWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:RRWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:RRWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:LRWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:LRWheel'
   End Object
   Wheels(1)=LRWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:RFWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:RFWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleHellbenderWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:LFWheel'
      ObjectArchetype=UTVehicleHellbenderWheel'UTGame.Default__UTVehicle_HellBender:LFWheel'
   End Object
   Wheels(3)=LFWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_11 ObjName=MyStayUprightSetup_11 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_HellBender:MyStayUprightSetup_11'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_HellBender:MyStayUprightSetup_11'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_HellBender_Content:MyStayUprightSetup_11'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_11 ObjName=MyStayUprightConstraintInstance_11 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_HellBender:MyStayUprightConstraintInstance_11'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_HellBender:MyStayUprightConstraintInstance_11'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_HellBender_Content:MyStayUprightConstraintInstance_11'
   Begin Object Class=AudioComponent Name=HellBenderEngineSound ObjName=HellBenderEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_EngineIdle'
      Name="HellBenderEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=HellBenderEngineSound
   Begin Object Class=AudioComponent Name=HellbenderSquealSound ObjName=HellbenderSquealSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_Slide'
      Name="HellbenderSquealSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   SquealSound=HellbenderSquealSound
   CollisionSound=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_EngineStart'
   ExitVehicleSound=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_EngineStop'
   SquealThreshold=0.100000
   SquealLatThreshold=0.020000
   LatAngleVolumeMult=30.000000
   EngineStartOffsetSecs=0.500000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_HellBender:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Hellbender.Mesh.SK_VH_Hellbender'
      AnimTreeTemplate=AnimTree'VH_Hellbender.Anims.AT_VH_Hellbender'
      PhysicsAsset=PhysicsAsset'VH_Hellbender.Mesh.SK_VH_Hellbender_Physics'
      AnimSets(0)=AnimSet'VH_Hellbender.Anims.K_VH_Hellbender'
      MorphSets(0)=MorphTargetSet'VH_Hellbender.Mesh.VH_Hellbender_MorphTargets'
      RBCollideWithChannels=(Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_HellBender:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_HellBender:CollisionCylinder'
      CollisionHeight=65.000000
      CollisionRadius=140.000000
      Translation=(X=0.000000,Y=0.000000,Z=-15.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_HellBender:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=ScorpionTireSound
   Components(5)=HellBenderEngineSound
   Components(6)=HellbenderSquealSound
   Components(7)=HellbenderSusShift
   DrawScale=1.200000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_HellBender_Content"
   ObjectArchetype=UTVehicle_HellBender'UTGame.Default__UTVehicle_HellBender'
}
