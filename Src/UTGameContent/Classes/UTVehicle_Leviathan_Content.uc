/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Leviathan_Content extends UTVehicle_Leviathan;

/** The set of all MIs for the Leviathan for both teams **/
var array<MaterialInterface> BurnOutMaterialLeviathan;


simulated function SetBurnOut()
{
	local int TeamNum;

	TeamNum = GetTeamNum();

	if( TeamNum > 1 )
	{
		TeamNum = 0;
	}

	if( TeamNum == 0 )
	{
		Mesh.SetMaterial( 0, BurnOutMaterialLeviathan[0] );
		Mesh.SetMaterial( 1, BurnOutMaterialLeviathan[1] );
		Mesh.SetMaterial( 2, BurnOutMaterialLeviathan[2] );
		Mesh.SetMaterial( 3, BurnOutMaterialLeviathan[3] );
		Mesh.SetMaterial( 4, BurnOutMaterialLeviathan[4] );
		Mesh.SetMaterial( 5, BurnOutMaterialLeviathan[5] );
	}
	else
	{
		Mesh.SetMaterial( 0, BurnOutMaterialLeviathan[6] );
		Mesh.SetMaterial( 1, BurnOutMaterialLeviathan[7] );
		Mesh.SetMaterial( 2, BurnOutMaterialLeviathan[8] );
		Mesh.SetMaterial( 3, BurnOutMaterialLeviathan[9] );
		Mesh.SetMaterial( 4, BurnOutMaterialLeviathan[10] );
		Mesh.SetMaterial( 5, BurnOutMaterialLeviathan[11] );
	}


	// call the super which will "Reset" the first material (which is okie as it is just setting the same thing
	// and then it will create all of the MICs which allow us to do our burnout effect
	super.SetBurnOut();
}

simulated function ApplyWeaponEffects(int OverlayFlags, optional int SeatIndex)
{
	Super.ApplyWeaponEffects(OverlayFlags, SeatIndex);

	if (SeatIndex == 0)
	{
		if (Seats[0].WeaponEffects[0].Effect != None)
		{
			Seats[0].WeaponEffects[0].Effect.SetHidden(DeployedState == EDS_Undeployed);
		}
		if (Seats[0].WeaponEffects[1].Effect != None)
		{
			Seats[0].WeaponEffects[1].Effect.SetHidden(DeployedState != EDS_Undeployed);
		}
		if (Seats[0].WeaponEffects[2].Effect != None)
		{
			Seats[0].WeaponEffects[2].Effect.SetHidden(DeployedState != EDS_Undeployed);
		}
	}
}

simulated function DeployedStateChanged()
{
	Super.DeployedStateChanged();

	if (Seats[0].WeaponEffects[0].Effect != None)
	{
		Seats[0].WeaponEffects[0].Effect.SetHidden(DeployedState != EDS_Undeployed);
	}
	if (Seats[0].WeaponEffects[1].Effect != None)
	{
		Seats[0].WeaponEffects[1].Effect.SetHidden(DeployedState == EDS_Undeployed);
	}
	if (Seats[0].WeaponEffects[2].Effect != None)
	{
		Seats[0].WeaponEffects[2].Effect.SetHidden(DeployedState == EDS_Undeployed);
	}
}


/** Stops the big beam from firing. */
simulated function AbortBigBeam()
{
	local UTVWeap_LeviathanPrimary LevGun;

	if(BigBeamEmitter != None)
	{
		BigBeamEmitter.DeactivateSystem();
		BigBeamEmitter.KillParticlesForced();
	}

	if(Role == ROLE_Authority && Seats[0].Gun != None)
	{
		LevGun = UTVWeap_LeviathanPrimary(Seats[0].Gun);
		LevGun.GotoState('WeaponRecharge');
		LevGun.ClientHasFired();
	}
}

simulated function BlowupVehicle()
{
	Super.BlowupVehicle();
	AbortBigBeam();
}

simulated function SetVehicleUndeploying()
{
	Super.SetVehicleUndeploying();
	AbortBigBeam();
}

defaultproperties
{
   BurnOutMaterialLeviathan(0)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_Turret_BO'
   BurnOutMaterialLeviathan(1)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_1_BO'
   BurnOutMaterialLeviathan(2)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_2_BO'
   BurnOutMaterialLeviathan(3)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_Turret_BO'
   BurnOutMaterialLeviathan(4)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_Turret_BO'
   BurnOutMaterialLeviathan(5)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_Turret_BO'
   BurnOutMaterialLeviathan(6)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_Turret_BO'
   BurnOutMaterialLeviathan(7)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_1_BO'
   BurnOutMaterialLeviathan(8)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_2_BO'
   BurnOutMaterialLeviathan(9)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_Turret_BO'
   BurnOutMaterialLeviathan(10)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_Turret_BO'
   BurnOutMaterialLeviathan(11)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_Turret_BO'
   BeamTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_LaserBeam'
   BeamEndpointVarName="ShockBeamEnd"
   BigBeamTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_BigBeam'
   BigBeamEndpointVarName="BigBeamDest"
   BigBeamSocket="BigGunBarrel"
   ShieldClass=Class'UTGameContent.UTLeviathanShield'
   Begin Object Class=CylinderComponent Name=TurretCollisionCylinderLF ObjName=TurretCollisionCylinderLF Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=74.000000
      CollisionRadius=68.000000
      CollideActors=True
      BlockActors=True
      Translation=(X=0.000000,Y=0.000000,Z=48.000000)
      Name="TurretCollisionCylinderLF"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   TurretCollision(0)=TurretCollisionCylinderLF
   Begin Object Class=CylinderComponent Name=TurretCollisionCylinderRF ObjName=TurretCollisionCylinderRF Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=74.000000
      CollisionRadius=68.000000
      CollideActors=True
      BlockActors=True
      Translation=(X=0.000000,Y=0.000000,Z=48.000000)
      Name="TurretCollisionCylinderRF"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   TurretCollision(1)=TurretCollisionCylinderRF
   Begin Object Class=CylinderComponent Name=TurretCollisionCylinderLR ObjName=TurretCollisionCylinderLR Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=74.000000
      CollisionRadius=68.000000
      CollideActors=True
      BlockActors=True
      Translation=(X=0.000000,Y=0.000000,Z=48.000000)
      Name="TurretCollisionCylinderLR"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   TurretCollision(2)=TurretCollisionCylinderLR
   Begin Object Class=CylinderComponent Name=TurretCollisionCylinderRR ObjName=TurretCollisionCylinderRR Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=74.000000
      CollisionRadius=68.000000
      CollideActors=True
      BlockActors=True
      Translation=(X=0.000000,Y=0.000000,Z=48.000000)
      Name="TurretCollisionCylinderRR"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   TurretCollision(3)=TurretCollisionCylinderRR
   BigBeamFireSound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_CannonFire'
   MainTurretPivot="MainTurretPitch"
   DriverTurretPivot="DriverTurretYaw"
   TurretExplosionSound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_BlowSection'
   TurretActivate=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_TurretActivate'
   TurretDeactivate=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_TurretDeactivate'
   TurretExplosionTemplate=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_Leviathan_Guns'
   TeamMatSec(0)=MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Red_2'
   TeamMatSec(1)=MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Blue_2'
   TurretMaterial(0)=MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Red_Turret'
   TurretMaterial(1)=MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Blue_Turret'
   RumbleCameraAnim=CameraAnim'Camera_FX.Leviathan.C_VH_Leviathan_Ground_Rumble'
   RumbleRange=900.000000
   DeployTime=8.366700
   UnDeployTime=6.500000
   IdleAnim(0)="InActiveStill"
   IdleAnim(1)="ActiveStill"
   DeployAnim(0)="Deploying"
   DeployAnim(1)="UnDeploying"
   DeploySound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_Deploy'
   UndeploySound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_Deploy'
   ToolTipIconCoords=(U=1.000000,V=669.000000,UL=152.000000,VL=95.000000)
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Leviathan:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Leviathan:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_ManTheLeviathan')
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_LeviathanPrimary',GunSocket=("Lt_DriverBarrel","Rt_DriverBarrel"),GunPivotPoints=("DriverTurretYaw","MainTurretYaw"),WeaponEffects=((SocketName="BigGunBarrel",Offset=(X=-240.000000,Y=0.000000,Z=0.000000),Scale3D=(X=30.000000,Y=30.000000,Z=30.000000)),(SocketName="Lt_DriverBarrel",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=6.000000,Y=6.000000,Z=6.000000)),(SocketName="Rt_DriverBarrel",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=6.000000,Y=6.000000,Z=6.000000))),TurretControls=("DriverTurret_Yaw","Driverturret_Pitch"),CameraTag="DriverCamera",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=35.000000),CameraOffset=-800.000000,MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight',SeatIconPOS=(X=0.445000,Y=0.450000))
   Seats(1)=(GunClass=Class'UTGameContent.UTVWeap_LeviathanTurretBeam',GunSocket=("LF_TurretBarrel_L","LF_TurretBarrel_R"),GunPivotPoints=("LT_Front_TurretYaw","LT_Front_TurretYaw"),TurretVarPrefix="LFTurret",WeaponEffects=((SocketName="LF_TurretBarrel_R",Offset=(X=-30.000000,Y=-10.000000,Z=3.000000),Scale3D=(X=5.000000,Y=8.000000,Z=8.000000))),TurretControls=("LT_Front_TurretYaw","LT_Front_TurretPitch"),CameraTag="LF_TurretCamera",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=-15.000000),CameraOffset=-25.000000,CameraEyeHeight=50.000000,ViewPitchMin=-10402.000000,bSeatVisible=True,SeatBone="LT_Front_TurretPitch",SeatOffset=(X=4.000000,Y=0.000000,Z=72.000000),MuzzleFlashLightClass=Class'UTGame.UTTurretMuzzleFlashLight',DriverDamageMult=0.100000,SeatIconPOS=(X=0.235000,Y=0.150000))
   Seats(2)=(GunClass=Class'UTGameContent.UTVWeap_LeviathanTurretRocket',GunSocket=("RF_TurretBarrel","RF_TurretBarrel","RF_TurretBarrel"),GunPivotPoints=("RT_Front_TurretYaw","RT_Front_TurretYaw"),TurretVarPrefix="RFTurret",WeaponEffects=((SocketName="RF_TurretBarrel",Offset=(X=-30.000000,Y=0.000000,Z=0.000000),Scale3D=(X=5.000000,Y=8.000000,Z=8.000000))),TurretControls=("RT_Front_TurretYaw","RT_Front_TurretPitch"),CameraTag="RF_TurretCamera",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=-15.000000),CameraOffset=-25.000000,CameraEyeHeight=50.000000,ViewPitchMin=-10402.000000,bSeatVisible=True,SeatBone="RT_Front_TurretPitch",SeatOffset=(X=4.000000,Y=0.000000,Z=72.000000),MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight',DriverDamageMult=0.100000,SeatIconPOS=(X=0.635000,Y=0.150000))
   Seats(3)=(GunClass=Class'UTGameContent.UTVWeap_LeviathanTurretStinger',GunSocket=("LR_TurretBarrel"),GunPivotPoints=("LT_Rear_TurretYaw","LT_Rear_TurretYaw"),TurretVarPrefix="LRTurret",WeaponEffects=((SocketName="LR_TurretBarrel",Offset=(X=-30.000000,Y=0.000000,Z=0.000000),Scale3D=(X=5.000000,Y=8.000000,Z=8.000000))),TurretControls=("LT_Rear_TurretYaw","LT_Rear_TurretPitch"),CameraTag="LR_TurretCamera",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=-15.000000),CameraOffset=-25.000000,CameraEyeHeight=50.000000,ViewPitchMin=-10402.000000,bSeatVisible=True,SeatBone="LT_Rear_TurretPitch",SeatOffset=(X=4.000000,Y=0.000000,Z=72.000000),MuzzleFlashLightClass=Class'UTGame.UTStingerTurretMuzzleFlashLight',DriverDamageMult=0.100000,SeatIconPOS=(X=0.235000,Y=0.750000))
   Seats(4)=(GunClass=Class'UTGameContent.UTVWeap_LeviathanTurretShock',GunSocket=("RR_TurretBarrel"),GunPivotPoints=("RT_Rear_TurretPitch","RT_Rear_TurretPitch"),TurretVarPrefix="RRTurret",WeaponEffects=((SocketName="RR_TurretBarrel",Offset=(X=-30.000000,Y=0.000000,Z=0.000000),Scale3D=(X=5.000000,Y=8.000000,Z=8.000000))),TurretControls=("RT_Rear_TurretYaw","RT_Rear_TurretPitch"),CameraTag="RR_TurretCamera",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=-15.000000),CameraOffset=-25.000000,CameraEyeHeight=50.000000,ViewPitchMin=-10402.000000,bSeatVisible=True,SeatBone="RT_Rear_TurretPitch",SeatOffset=(X=4.000000,Y=0.000000,Z=72.000000),DriverDamageMult=0.100000,SeatIconPOS=(X=0.635000,Y=0.750000))
   VehicleEffects(0)=(EffectStartTag="Damage0Smoke",EffectEndTag="NoDamage0Smoke",EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="LF_TurretDamageSmoke")
   VehicleEffects(1)=(EffectStartTag="Damage1Smoke",EffectEndTag="NoDamage1Smoke",EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="RF_TurretDamageSmoke")
   VehicleEffects(2)=(EffectStartTag="Damage2Smoke",EffectEndTag="NoDamage2Smoke",EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="LR_TurretDamageSmoke")
   VehicleEffects(3)=(EffectStartTag="Damage3Smoke",EffectEndTag="NoDamage3Smoke",EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Vehicle_Damage_1',EffectSocket="RR_TurretDamageSmoke")
   VehicleEffects(4)=(EffectStartTag="StartDeploy",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Deploy',EffectSocket="DeployEffectSocket")
   VehicleEffects(5)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.PS_Leviathan_Exhaust_Smoke',EffectSocket="ExhaustSocket")
   VehicleEffects(6)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.PS_Leviathan_Exhaust_Smoke',EffectSocket="ExhaustSocketB")
   VehicleEffects(7)=(EffectStartTag="TurretBeamMF_L",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretBeamMF',EffectSocket="LF_TurretBarrel_L")
   VehicleEffects(8)=(EffectStartTag="TurretBeamMF_R",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretBeamMF',EffectSocket="LF_TurretBarrel_R")
   VehicleEffects(9)=(EffectStartTag="TurretRocketMF",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretRocketMF',EffectSocket="RF_TurretBarrel")
   VehicleEffects(10)=(EffectStartTag="TurretStingerMF",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretStingerMF',EffectSocket="LR_TurretBarrel")
   VehicleEffects(11)=(EffectStartTag="TurretShockMF",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretShockMF',EffectSocket="RR_TurretBarrel")
   VehicleEffects(12)=(EffectStartTag="DriverMF_L",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.PS_VH_Leviathan_DriverMF',EffectSocket="Lt_DriverBarrel")
   VehicleEffects(13)=(EffectStartTag="DriverMF_R",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.PS_VH_Leviathan_DriverMF',EffectSocket="Rt_DriverBarrel")
   VehicleEffects(14)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Leviathan',EffectSocket="DamageSmoke_01")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=1.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=1.000000)
   DamageMorphTargets(0)=(InfluenceBone="Front_SuspensionAim",Health=4500,DamagePropNames=("Damage3"))
   DamageMorphTargets(1)=(InfluenceBone="Rt_RearSuspension",Health=4500,DamagePropNames=("Damage1"))
   DamageMorphTargets(2)=(InfluenceBone="Lt_Mid_Foot",Health=4500,DamagePropNames=("Damage2"))
   DamageMorphTargets(3)=(InfluenceBone="Rt_Mid_Foot",Health=4500,DamagePropNames=("Damage2"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Red_1'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Blue_1'
   DamageSmokeThreshold=0.900000
   FireDamageThreshold=0.800000
   BigExplosionTemplates(0)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Far',MinDistance=2200.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Mid',MinDistance=1500.000000)
   BigExplosionTemplates(2)=(Template=ParticleSystem'WP_Redeemer.Particles.P_WP_Redeemer_Explo_Near')
   ExplosionDamage=150.000000
   ExplosionRadius=1000.000000
   ExplosionMomentum=125000.000000
   ExplosionSound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_Explode'
   DrivingAnim="leviathan_idle_sitting"
   MapSize=1.150000
   IconCoords=(U=936.000000,V=0.000000,UL=29.000000,VL=47.000000)
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=300.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Red_Turret',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Red_1',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Red_2',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Red_Turret',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Red_Turret',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Red_Turret'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Blue_Turret',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Blue_1',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Blue_2',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Blue_Turret',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Blue_Turret',MaterialInstanceConstant'VH_Leviathan.Materials.MI_VH_Levi_Spawn_Blue_Turret'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Red_Turret_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Leviathan.Materials.MITV_VH_Levi_Blue_Turret_BO'
   LookForwardDist=120.000000
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyLeviathan'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyLeviathan'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyLeviathan'
   VehicleDestroyedSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyLeviathanDestroyed'
   VehicleDestroyedSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyLeviathanDestroyed'
   VehicleDestroyedSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyLeviathanDestroyed'
   HudCoords=(U=743.000000,UL=-97.000000,VL=129.000000)
   Begin Object Class=UTVehicleSimCar Name=SimObject ObjName=SimObject Archetype=UTVehicleSimCar'UTGame.Default__UTVehicle_Leviathan:SimObject'
      ObjectArchetype=UTVehicleSimCar'UTGame.Default__UTVehicle_Leviathan:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleWheel Name=RtRWheel ObjName=RtRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SkelControlName="Rt_Rear_Wheel"
      BoneName="Rt_Rear_Tire"
      BoneOffset=(X=0.000000,Y=40.000000,Z=0.000000)
      WheelRadius=90.000000
      SuspensionTravel=40.000000
      WheelParticleSystem=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Wheel_Snow'
      LongSlipFactor=12000.000000
      Name="RtRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(0)=RtRWheel
   Begin Object Class=UTVehicleWheel Name=LtRWheel ObjName=LtRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SkelControlName="Lt_Rear_Wheel"
      BoneName="Lt_Rear_Tire"
      BoneOffset=(X=0.000000,Y=-40.000000,Z=0.000000)
      WheelRadius=90.000000
      SuspensionTravel=40.000000
      WheelParticleSystem=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Wheel_Snow'
      LongSlipFactor=12000.000000
      Name="LtRWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(1)=LtRWheel
   Begin Object Class=UTVehicleWheel Name=RtMWheel ObjName=RtMWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SkelControlName="Rt_Mid_Wheel"
      BoneName="Rt_Mid_Tire"
      BoneOffset=(X=0.000000,Y=40.000000,Z=0.000000)
      WheelRadius=90.000000
      SuspensionTravel=40.000000
      WheelParticleSystem=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Wheel_Snow'
      LongSlipFactor=12000.000000
      Name="RtMWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(2)=RtMWheel
   Begin Object Class=UTVehicleWheel Name=LtMWheel ObjName=LtMWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SkelControlName="Lt_Mid_Wheel"
      BoneName="Lt_Mid_Tire"
      BoneOffset=(X=0.000000,Y=-40.000000,Z=0.000000)
      WheelRadius=90.000000
      SuspensionTravel=40.000000
      WheelParticleSystem=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Wheel_Snow'
      LongSlipFactor=12000.000000
      Name="LtMWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(3)=LtMWheel
   Begin Object Class=UTVehicleWheel Name=RtFWheel ObjName=RtFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SteerFactor=1.000000
      SkelControlName="Rt_Front_Wheel"
      BoneName="Rt_Front_Tire"
      BoneOffset=(X=0.000000,Y=130.000000,Z=-10.000000)
      WheelRadius=100.000000
      SuspensionTravel=40.000000
      WheelParticleSystem=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Wheel_Snow'
      LongSlipFactor=12000.000000
      Name="RtFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(4)=RtFWheel
   Begin Object Class=UTVehicleWheel Name=LtFWheel ObjName=LtFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SteerFactor=1.000000
      SkelControlName="Lt_Front_Wheel"
      BoneName="Lt_Front_Tire"
      BoneOffset=(X=0.000000,Y=-130.000000,Z=-10.000000)
      WheelRadius=100.000000
      SuspensionTravel=40.000000
      WheelParticleSystem=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Wheel_Snow'
      LongSlipFactor=12000.000000
      Name="LtFWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(5)=LtFWheel
   Begin Object Class=UTVehicleWheel Name=CenterWheel ObjName=CenterWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
      bDisableWheelOnDeath=True
      bPoweredWheel=True
      SkelControlName="Body"
      BoneName="Body"
      BoneOffset=(X=-30.000000,Y=0.000000,Z=-50.000000)
      WheelRadius=75.000000
      SuspensionTravel=200.000000
      LongSlipFactor=12000.000000
      Name="CenterWheel"
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicleWheel'
   End Object
   Wheels(6)=CenterWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_8 ObjName=MyStayUprightSetup_8 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Leviathan:MyStayUprightSetup_8'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Leviathan:MyStayUprightSetup_8'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Leviathan_Content:MyStayUprightSetup_8'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_8 ObjName=MyStayUprightConstraintInstance_8 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Leviathan:MyStayUprightConstraintInstance_8'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Leviathan:MyStayUprightConstraintInstance_8'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Leviathan_Content:MyStayUprightConstraintInstance_8'
   Begin Object Class=AudioComponent Name=EngineIdleSound ObjName=EngineIdleSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_EngineIdle'
      Name="EngineIdleSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=EngineIdleSound
   CollisionSound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_EngineStart'
   ExitVehicleSound=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_EngineStop'
   SquealThreshold=0.050000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Leviathan:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Leviathan.Mesh.SK_VH_Leviathan'
      AnimTreeTemplate=AnimTree'VH_Leviathan.Anims.AT_VH_Leviathan'
      PhysicsAsset=PhysicsAsset'VH_Leviathan.Mesh.SK_VH_Leviathan_Physics'
      AnimSets(0)=AnimSet'VH_Leviathan.Anims.K_VH_Leviathan'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Leviathan:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Leviathan:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=260.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Leviathan:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=EngineIdleSound
   DrawScale=1.250000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Leviathan_Content"
   ObjectArchetype=UTVehicle_Leviathan'UTGame.Default__UTVehicle_Leviathan'
}
