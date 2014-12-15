/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Goliath_Content extends UTVehicle_Goliath;

var MaterialInterface BurnOutMaterialTread[2];

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( bDeleteMe )
		return;

	if (WorldInfo.NetMode != NM_DedicatedServer && Mesh != None)
	{
		// set up material instance (for overlay effects)
		LeftTreadMaterialInstance = Mesh.CreateAndSetMaterialInstanceConstant(1);
		RightTreadMaterialInstance = Mesh.CreateAndSetMaterialInstanceConstant(2);
	}

	Mesh.AttachComponentToSocket(AntennaMesh,'AntennaSocket');

	AntennaBeamControl = UTSkelControl_CantileverBeam(AntennaMesh.FindSkelControl('Beam'));

	if(AntennaBeamControl != none)
	{
		AntennaBeamControl.EntireBeamVelocity = GetVelocity;
	}
}

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local ParticleSystemComponent E;
	local rotator HitDir;
	local vector EffectLocation;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	if (SeatIndex == 1)
	{
		EffectLocation = GetEffectLocation(SeatIndex);

		HitDir = rotator(HitLocation - EffectLocation);

		E = WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'VH_Goliath.Effects.P_MiniGun_Tracer', EffectLocation, HitDir);
		E.SetVectorParameter('BeamEndPoint', HitLocation);
	}
}

simulated function TeamChanged()
{
	local int MaterialIndex;

	Super.TeamChanged();

	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		MaterialIndex = (Team == 1) ? 1 : 0;
		AntennaMesh.SetMaterial(0, TeamMaterials[MaterialIndex]);
	}
}

protected simulated function StartLinkedEffect()
{
	local LinearColor LinkColor;

	LinkColor = (Team == 1) ? MakeLinearColor(0,1,4,1) : MakeLinearColor(4,0.1,0,1);

	if(LeftTreadMaterialInstance != none)
	{
		LeftTreadMaterialInstance.SetVectorParameterValue('Veh_OverlayColor',LinkColor);
	}
	if(RightTreadMaterialInstance != none)
	{
		RightTreadMaterialInstance.SetVectorParameterValue('Veh_OverlayColor',LinkColor);
	}
	super.StartLinkedEffect();
}

protected simulated function StopLinkedEffect()
{
	local LinearColor Black;

	if(LeftTreadMaterialInstance != none)
	{
		LeftTreadMaterialInstance.SetVectorParameterValue('Veh_OverlayColor',Black);
	}
	if(RightTreadMaterialInstance != none)
	{
		RightTreadMaterialInstance.SetVectorParameterValue('Veh_OverlayColor',Black);
	}
	super.StopLinkedEffect();
}

simulated function CauseMuzzleFlashLight(int SeatIndex)
{
	Super.CauseMuzzleFlashLight(SeatIndex);
	if (SeatIndex==0)
		VehicleEvent('GoliathTurret');
	else if (SeatIndex==1)
		VehicleEvent('GoliathMachineGun');
}

simulated function SetBurnOut()
{
	local int TeamNum;
	local BurnOutDatum BOD;

	TeamNum = GetTeamNum();

	if( TeamNum > 1 )
	{
		TeamNum = 0;
	}

	// set our specific Tread BurnOut Material
	// material 1 = left tread, 2 = right tread
	if (BurnOutMaterialTread[TeamNum] != None)
	{
		Mesh.SetMaterial(1,BurnOutMaterialTread[TeamNum]);
		Mesh.SetMaterial(2,BurnOutMaterialTread[TeamNum]);
	}

	if (BurnOutMaterial[TeamNum] != None)
	{
		AntennaMesh.SetMaterial(0,BurnOutMaterial[TeamNum]);

		// set up the antenna BurnOut
		BOD.MITV = AntennaMesh.CreateAndSetMaterialInstanceTimeVarying(0);
		BurnOutMaterialInstances[BurnOutMaterialInstances.length] = BOD;
	}

	// sets the MIC
	super.SetBurnOut();
}

defaultproperties
{
   BurnOutMaterialTread(0)=MaterialInstanceTimeVarying'VH_Goliath.Materials.MITV_VH_Goliath01_Red_Tread_BO'
   BurnOutMaterialTread(1)=MaterialInstanceTimeVarying'VH_Goliath.Materials.MITV_VH_Goliath01_Blue_Tread_BO'
   LeftTeamMaterials(0)=MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath02_Treads_Red'
   LeftTeamMaterials(1)=MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath02_Treads_Blue'
   RightTeamMaterials(0)=MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath03_Treads_Red'
   RightTeamMaterials(1)=MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath03_Treads_Blue'
   TreadSpeedParameterName="Veh_Tread_Speed"
   Begin Object Class=AudioComponent Name=AmbientSoundComponent ObjName=AmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_TurretFire_Cue'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="AmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   MachineGunAmbient=AmbientSoundComponent
   MachineGunStopSound=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_TurretFireStop_Cue'
   Begin Object Class=AudioComponent Name=MyTrackSound ObjName=MyTrackSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_EngineTreadLoop'
      Name="MyTrackSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TrackSound=MyTrackSound
   TrackSoundParamScale=0.000035
   Begin Object Class=SkeletalMeshComponent Name=SAntennaMesh ObjName=SAntennaMesh Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      SkeletalMesh=SkeletalMesh'VH_Goliath.Mesh.SK_VH_Goliath_Antenna'
      AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath_Antenna'
      bUpdateSkelWhenNotRendered=False
      bIgnoreControllersWhenNotRendered=True
      ShadowParent=SkeletalMeshComponent'UTGameContent.Default__UTVehicle_Goliath_Content:SVehicleMesh'
      LightEnvironment=DynamicLightEnvironmentComponent'UTGameContent.Default__UTVehicle_Goliath_Content:MyLightEnvironment'
      CullDistance=1300.000000
      CachedCullDistance=1300.000000
      bUseAsOccluder=False
      TickGroup=TG_PostAsyncWork
      Name="SAntennaMesh"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   AntennaMesh=SAntennaMesh
   bHasTurretExplosion=True
   bHasEnemyVehicleSound=True
   AIPurpose=AIP_Any
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Goliath:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Goliath:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   NeedToPickUpAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_ManTheGoliath')
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_GoliathTurret',GunSocket=("TurretFireSocket"),GunPivotPoints=("Object01"),WeaponEffects=((SocketName="TurretFireSocket",Offset=(X=-125.000000,Y=0.000000,Z=0.000000),Scale3D=(X=14.000000,Y=10.000000,Z=10.000000))),TurretControls=("TurretPitch","TurretRotate"),CameraTag="GunViewSocket",CameraOffset=-420.000000,MuzzleFlashLightClass=Class'UTGameContent.UTTankMuzzleFlash',SeatIconPOS=(X=0.330000,Y=0.350000))
   Seats(1)=(GunClass=Class'UTGameContent.UTVWeap_GoliathMachineGun',GunSocket=("GunFireSocket"),GunPivotPoints=("Object10"),TurretVarPrefix="Gunner",WeaponEffects=((SocketName="GunFireSocket",Offset=(X=-36.000000,Y=0.000000,Z=0.000000),Scale3D=(X=6.500000,Y=6.000000,Z=6.000000))),TurretControls=("gun_rotate","gun_pitch"),CameraTag="GunViewSocket",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=30.000000),CameraOffset=16.000000,MuzzleFlashLightClass=Class'UTGameContent.UTTankeMinigunMuzzleFlashLight',SeatIconPOS=(X=0.460000,Y=0.650000))
   VehicleEffects(0)=(EffectStartTag="GoliathTurret",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Cannon_MuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleEffects(1)=(EffectStartTag="GoliathMachineGun",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Goliath.Effects.P_Goliath_MiniGun_MuzzleFlash',EffectSocket="GunFireSocket")
   VehicleEffects(2)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Exhaust_Smoke',EffectSocket="Exhaust_Smoke01")
   VehicleEffects(3)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Goliath.Effects.PS_Goliath_Exhaust_Smoke',EffectSocket="Exhaust_Smoke02")
   VehicleEffects(4)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Goliath',EffectSocket="DamageSmoke01")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=5.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=5.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=5.000000)
   DamageParamScaleLevels(3)=(DamageParamName="Damage6",Scale=2.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_Front",InfluenceBone="b_FrontDamage",Health=190,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_Back",InfluenceBone="b_RearDamage",Health=190,DamagePropNames=("Damage3"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeW_LHS",InfluenceBone="Suspension_LHS_02",Health=190,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(MorphNodeName="MorphNodeW_RHS",InfluenceBone="Suspension_RHS_02",Health=190,DamagePropNames=("Damage1"))
   DamageMorphTargets(4)=(MorphNodeName="MorphNodeW_Turret",InfluenceBone="Object01",Health=190,DamagePropNames=("Damage6"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath01_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath01_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'VH_Goliath.Effects.P_VH_Goliath_DeathExplode')
   DestroyedTurretTemplate=StaticMesh'VH_Goliath.Mesh.VH_Goliath_Turret_top'
   TurretExplosiveForce=15000.000000
   ExplosionSound=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Explode'
   FlagOffset=(X=-95.000000,Y=59.000000,Z=50.000000)
   FlagBone="Object01"
   IconCoords=(V=0.000000,UL=27.000000,VL=38.000000)
   PassengerTeamBeaconOffset=(X=-100.000000,Y=0.000000,Z=125.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath01_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Goliath.Materials.MI_VH_Goliath01_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Goliath.Materials.MITV_VH_Goliath01_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Goliath.Materials.MITV_VH_Goliath01_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Goliath_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Goliath_Wheel_Dust')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Goliath_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Goliath_Wheel_Dust')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyGoliath'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyGoliath'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyGoliath'
   VehicleDestroyedSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyGoliathDestroyed'
   VehicleDestroyedSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyGoliathDestroyed'
   VehicleDestroyedSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyGoliathDestroyed'
   HudCoords=(U=322.000000,V=143.000000,UL=-90.000000,VL=127.000000)
   Begin Object Class=UTVehicleSimTank Name=SimObject ObjName=SimObject Archetype=UTVehicleSimTank'UTGame.Default__UTVehicle_Goliath:SimObject'
      ObjectArchetype=UTVehicleSimTank'UTGame.Default__UTVehicle_Goliath:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:RRWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:RRWheel'
   End Object
   Wheels(0)=RRWheel
   Begin Object Class=UTVehicleWheel Name=RMWheel ObjName=RMWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:RMWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:RMWheel'
   End Object
   Wheels(1)=RMWheel
   Begin Object Class=UTVehicleWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:RFWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:RFWheel'
   End Object
   Wheels(2)=RFWheel
   Begin Object Class=UTVehicleWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:LRWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:LRWheel'
   End Object
   Wheels(3)=LRWheel
   Begin Object Class=UTVehicleWheel Name=LMWheel ObjName=LMWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:LMWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:LMWheel'
   End Object
   Wheels(4)=LMWheel
   Begin Object Class=UTVehicleWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:LFWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_Goliath:LFWheel'
   End Object
   Wheels(5)=LFWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_10 ObjName=MyStayUprightSetup_10 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Goliath:MyStayUprightSetup_10'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Goliath:MyStayUprightSetup_10'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Goliath_Content:MyStayUprightSetup_10'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_10 ObjName=MyStayUprightConstraintInstance_10 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Goliath:MyStayUprightConstraintInstance_10'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Goliath:MyStayUprightConstraintInstance_10'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Goliath_Content:MyStayUprightConstraintInstance_10'
   Begin Object Class=AudioComponent Name=ScorpionEngineSound ObjName=ScorpionEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_EngineLoop'
      Name="ScorpionEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=ScorpionEngineSound
   CollisionSound=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Start'
   ExitVehicleSound=SoundCue'A_Vehicle_Goliath.SoundCues.A_Vehicle_Goliath_Stop'
   BaseEyeHeight=60.000000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Goliath:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Goliath.Mesh.SK_VH_Goliath01'
      AnimTreeTemplate=AnimTree'VH_Goliath.Anims.AT_VH_Goliath'
      PhysicsAsset=PhysicsAsset'VH_Goliath.Mesh.PA_VH_Goliath'
      MorphSets(0)=MorphTargetSet'VH_Goliath.Mesh.SK_VH_Goliath_Morph'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Goliath:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Goliath:CollisionCylinder'
      CollisionHeight=60.000000
      CollisionRadius=260.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Goliath:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=AmbientSoundComponent
   Components(5)=ScorpionEngineSound
   Components(6)=MyTrackSound
   DrawScale=1.350000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Goliath_Content"
   ObjectArchetype=UTVehicle_Goliath'UTGame.Default__UTVehicle_Goliath'
}
