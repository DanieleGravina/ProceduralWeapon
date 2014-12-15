/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Cicada_Content extends UTVehicle_Cicada;

var array<UTDecoy> Decoys;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Mesh != None)
	{
		JetControl = UTSkelControl_JetThruster(Mesh.FindSkelControl('CicadaJet'));
	}
}

function IncomingMissile(Projectile P)
{
	local UTVWeap_CicadaTurret Turret;

	// notify the turret weapon
	if (Seats.length > 1)
	{
		Turret = UTVWeap_CicadaTurret(Seats[1].Gun);
		if (Turret != None)
		{
			Turret.IncomingMissile(P);
		}
	}

	Super.IncomingMissile(P);
}

/** Check all of the active decoys and see if any take effect. */
event Actor GetHomingTarget(UTProjectile Seeker, Controller InstigatedBy)
{
	local int i;
	local UTProj_AvrilRocketBase AvrilRocket;

	for (i = 0; i < Decoys.Length; i++)
	{
		if (Decoys[i].CheckRange(Seeker))
		{
			AvrilRocket = UTProj_AvrilRocketBase(Seeker);

			if ( AvrilRocket != none )
			{
				// switch lock
				AvrilRocket.ForceLock(None);
			}
			return Decoys[i];
		}
	}

	return Super.GetHomingTarget(Seeker, InstigatedBy);
}

defaultproperties
{
   JetEffectIndices(0)=11
   JetEffectIndices(1)=12
   TurretBeamTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_2ndPrim_Beam'
   JetScalingParam="jetscale"
   ContrailEffectIndices(0)=2
   ContrailEffectIndices(1)=3
   ContrailEffectIndices(2)=4
   ContrailEffectIndices(3)=5
   ContrailEffectIndices(4)=13
   ContrailEffectIndices(5)=14
   GroundEffectIndices(0)=10
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Cicada:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Cicada:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_CicadaMissileLauncher',GunSocket=("Gun_Socket_02","Gun_Socket_01"),GunPivotPoints=("Main"),WeaponEffects=((SocketName="Gun_Socket_01",Offset=(X=-80.000000,Y=0.000000,Z=0.000000),Scale3D=(X=12.000000,Y=15.000000,Z=15.000000)),(SocketName="Gun_Socket_02",Offset=(X=-80.000000,Y=0.000000,Z=0.000000),Scale3D=(X=12.000000,Y=15.000000,Z=15.000000))),TurretControls=("LauncherA","LauncherB"),CameraTag="ViewSocket",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=25.000000),CameraOffset=-400.000000,SeatIconPOS=(X=0.480000,Y=0.250000))
   Seats(1)=(GunClass=Class'UTGameContent.UTVWeap_CicadaTurret',GunSocket=("Turret_Gun_Socket_01","Turret_Gun_Socket_02","Turret_Gun_Socket_03","Turret_Gun_Socket_04"),GunPivotPoints=("MainTurret_Pitch"),TurretVarPrefix="Turret",WeaponEffects=((SocketName="Turret_Gun_Socket_04",Offset=(X=-80.000000,Y=0.000000,Z=0.000000),Scale3D=(X=8.000000,Y=10.000000,Z=10.000000)),(SocketName="Turret_Gun_Socket_03",Offset=(X=-80.000000,Y=0.000000,Z=0.000000),Scale3D=(X=8.000000,Y=10.000000,Z=10.000000))),TurretControls=("Turret_Rotate"),CameraTag="Turret_ViewSocket",ViewPitchMin=-14000.000000,ViewPitchMax=1.000000,SeatIconPOS=(X=0.480000,Y=0.560000))
   VehicleEffects(0)=(EffectStartTag="CicadaWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Muzzleflash',EffectSocket="Gun_Socket_01")
   VehicleEffects(1)=(EffectStartTag="CicadaWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Muzzleflash',EffectSocket="Gun_Socket_02")
   VehicleEffects(2)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Contrail',EffectSocket="LeftWingtip")
   VehicleEffects(3)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Contrail',EffectSocket="RightWingtip")
   VehicleEffects(4)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Contrail',EffectSocket="LeftFrtTrail")
   VehicleEffects(5)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Contrail',EffectSocket="RightFrtTrail")
   VehicleEffects(6)=(EffectStartTag="TurretWeapon01",EffectEndTag="STOP_TurretWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_2ndAltFlash',EffectSocket="Turret_Gun_Socket_02")
   VehicleEffects(7)=(EffectStartTag="TurretWeapon02",EffectEndTag="STOP_TurretWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_2ndAltFlash',EffectSocket="Turret_Gun_Socket_03")
   VehicleEffects(8)=(EffectStartTag="TurretWeapon00",EffectEndTag="STOP_TurretWeapon00",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_2ndAltFlash',EffectSocket="Turret_Gun_Socket_01")
   VehicleEffects(9)=(EffectStartTag="TurretWeapon03",EffectEndTag="STOP_TurretWeapon03",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_2ndAltFlash',EffectSocket="Turret_Gun_Socket_04")
   VehicleEffects(10)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_GroundEffect',EffectSocket="GroundEffectBase")
   VehicleEffects(11)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Exhaust',EffectSocket="LeftExhaust")
   VehicleEffects(12)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Exhaust',EffectSocket="RightExhaust")
   VehicleEffects(13)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Contrail',EffectSocket="LeftWingTipB")
   VehicleEffects(14)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_Contrail',EffectSocket="RightWingtipB")
   VehicleEffects(15)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Cicada',EffectSocket="DamageSmoke_01")
   VehicleAnims(0)=(AnimTag="Created",AnimSeqs=("InActiveStill"),AnimRate=1.000000,AnimPlayerName="CicadaPlayer")
   VehicleAnims(1)=(AnimTag="EngineStart",AnimSeqs=("GetIn"),AnimRate=1.000000,AnimPlayerName="CicadaPlayer")
   VehicleAnims(2)=(AnimTag="Idle",AnimSeqs=("Idle"),AnimRate=1.000000,bAnimLoopLastSeq=True,AnimPlayerName="CicadaPlayer")
   VehicleAnims(3)=(AnimTag="EngineStop",AnimSeqs=("GetOut"),AnimRate=1.000000,AnimPlayerName="CicadaPlayer")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=3.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.500000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=2.500000)
   DamageMorphTargets(0)=(InfluenceBone="Lt_Gun_Yaw",Health=150,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(InfluenceBone="Rt_Gun_Yaw",Health=150,DamagePropNames=("Damage2"))
   DamageMorphTargets(2)=(InfluenceBone="FrontGuardDamage",Health=150,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(InfluenceBone="MainTurret_Yaw",Health=150,DamagePropNames=("Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Cicada.Materials.MI_VH_Cicada_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Cicada.Materials.MI_VH_Cicada_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_Explode'
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.A_Gameplay_Onslaught_MetalScrape01Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   IconCoords=(U=988.000000,V=0.000000,UL=33.000000,VL=42.000000)
   PassengerTeamBeaconOffset=(X=-125.000000,Y=0.000000,Z=-105.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Cicada.Materials.MI_VH_Cicada_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Cicada.Materials.MI_VH_Cicada_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Cicada.Materials.MITV_VH_Cicada_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Cicada.Materials.MITV_VH_Cicada_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   ReferenceMovementMesh=StaticMesh'Envy_Effects.Mesh.S_Air_Wind_Ball'
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyCicada'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyCicada'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyCicada'
   HudCoords=(U=106.000000,V=125.000000,UL=-106.000000,VL=124.000000)
   Begin Object Class=UTVehicleSimChopper Name=SimObject ObjName=SimObject Archetype=UTVehicleSimChopper'UTGame.Default__UTVehicle_Cicada:SimObject'
      ObjectArchetype=UTVehicleSimChopper'UTGame.Default__UTVehicle_Cicada:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_0 ObjName=MyStayUprightSetup_0 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Cicada:MyStayUprightSetup_0'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Cicada:MyStayUprightSetup_0'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Cicada_Content:MyStayUprightSetup_0'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_0 ObjName=MyStayUprightConstraintInstance_0 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Cicada:MyStayUprightConstraintInstance_0'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Cicada:MyStayUprightConstraintInstance_0'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Cicada_Content:MyStayUprightConstraintInstance_0'
   Begin Object Class=AudioComponent Name=RaptorEngineSound ObjName=RaptorEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_EngineLoop'
      Name="RaptorEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=RaptorEngineSound
   CollisionSound=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_Start'
   ExitVehicleSound=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_Stop'
   Health=500
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Cicada:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Cicada.Mesh.SK_VH_Cicada'
      AnimTreeTemplate=AnimTree'VH_Cicada.Anims.AT_VH_Cicada'
      PhysicsAsset=PhysicsAsset'VH_Cicada.Mesh.SK_VH_Cicada_Physics'
      AnimSets(0)=AnimSet'VH_Cicada.Anims.VH_Cicada_Anims'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Cicada:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Cicada:CollisionCylinder'
      CollisionHeight=70.000000
      CollisionRadius=240.000000
      Translation=(X=-40.000000,Y=0.000000,Z=40.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Cicada:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=RaptorEngineSound
   Components(5)=BaseScrapeSound
   DrawScale=1.300000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Cicada_Content"
   ObjectArchetype=UTVehicle_Cicada'UTGame.Default__UTVehicle_Cicada'
}
