/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_SPMA_Content extends UTVehicle_SPMA;

/** The Template of the Beam to use */
var ParticleSystem BeamTemplate;
/** sound of the moving turret while deployed*/
var SoundCue TurretMovementSound;

var MaterialInterface BurnOutMaterialTread[2];

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local ParticleSystemComponent ShockBeam;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	// Handle Beam Effects for the shock beam

	if (SeatIndex==0 && !IsZero(HitLocation))
	{
		ShockBeam = WorldInfo.MyEmitterPool.SpawnEmitter(BeamTemplate, GetEffectLocation(SeatIndex));
		ShockBeam.SetVectorParameter('ShockBeamEnd', HitLocation);
	}
}

simulated function CauseMuzzleFlashLight(int SeatIndex)
{
	Super.CauseMuzzleFlashLight(SeatIndex);
	if (SeatIndex==1)
	{
		PlayAnim('Fire');
		VehicleEvent('DriverGun');
	}
	else if (SeatIndex==0)
	{
		VehicleEvent('PassengerGun');
	}
}

simulated function SitDriver( UTPawn UTP, int SeatIndex)
{
	Super.SitDriver(UTP,SeatIndex);
	if (SeatIndex == 0 && DeployedState == EDS_Undeployed )
	{
		PlayAnim( 'GetIn' );
	}
}

function PassengerLeave(int SeatIndex)
{
	Super.PassengerLeave(SeatIndex);
	if (SeatIndex == 0 && DeployedState == EDS_Undeployed)
	{
		PlayAnim( 'GetOut' );
	}
}

simulated function SetVehicleDeployed()
{
	Super.SetVehicleDeployed();

	// add turret motion sound
	if (WorldInfo.NetMode != NM_DedicatedServer && Seats[0].SeatMotionAudio == None && TurretMovementSound != None)
	{
		Seats[1].SeatMotionAudio = CreateAudioComponent(TurretMovementSound, false, true);
	}
}

simulated function SetVehicleUndeployed()
{
	Super.SetVehicleUndeployed();

	// remove turret motion sound/stop sound
	if (Seats[0].SeatMotionAudio != None)
	{
		Seats[0].SeatMotionAudio.Stop();
		Seats[0].SeatMotionAudio = None;
	}
}


simulated function SetBurnOut()
{
	local int TeamNum;

	TeamNum = GetTeamNum();

	if( TeamNum > 1 )
	{
		TeamNum = 0;
	}

	if (BurnOutMaterialTread[TeamNum] != None)
	{
		Mesh.SetMaterial( 1, BurnOutMaterialTread[TeamNum] );
	}

	// sets the MIC
	super.SetBurnOut();
}

simulated function TakeRadiusDamage( Controller InstigatedBy, float BaseDamage, float DamageRadius, class<DamageType> DamageType,
				float Momentum, vector HurtOrigin, bool bFullDamage, Actor DamageCauser )
{
	if ( Role < ROLE_Authority )
		return;

	// don't take damage from own combos
	if (DamageType != class'UTDmgType_SPMAShockChain' || InstigatedBy != Controller)
	{
		Super.TakeRadiusDamage(InstigatedBy, BaseDamage, DamageRadius, DamageType, Momentum, HurtOrigin, bFullDamage, DamageCauser);
	}
}

defaultproperties
{
   BeamTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Beam'
   TurretMovementSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_CannonRotate'
   BurnOutMaterialTread(0)=MaterialInstanceTimeVarying'VH_SPMA.Materials.MITV_VH_SPMA_Treads_Red_BO'
   BurnOutMaterialTread(1)=MaterialInstanceTimeVarying'VH_SPMA.Materials.MITV_VH_SPMA_Treads_Blue_BO'
   TreadSpeedParameterName="Veh_Tread_Speed"
   IdleAnim(0)="InActiveStill"
   IdleAnim(1)="ActiveStill"
   DeployAnim(0)="Deploying"
   DeployAnim(1)="UnDeploying"
   DeploySound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Deploy'
   UndeploySound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Deploy'
   ToolTipIconCoords=(U=2.000000,V=371.000000,UL=124.000000,VL=115.000000)
   bHasTurretExplosion=True
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_SPMA:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_SPMA:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_SPMAPassengerGun',GunSocket=("GunnerFireSocket"),GunPivotPoints=("SecondaryTurret_YawLift"),TurretVarPrefix="Gunner",WeaponEffects=((SocketName="GunnerFireSocket",Offset=(X=-25.000000,Y=0.000000,Z=0.000000),Scale3D=(X=3.000000,Y=3.000000,Z=3.000000))),TurretControls=("GunnerConstraint","GunnerYawConstraint"),CameraTag="DriverViewSocket",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=16.000000),CameraOffset=-320.000000,SeatIconPOS=(X=0.450000,Y=0.250000))
   Seats(1)=(GunClass=Class'UTGameContent.UTVWeap_SPMACannon_Content',GunSocket=("TurretFireSocket"),GunPivotPoints=("MainTurret_Yaw"),WeaponEffects=((SocketName="TurretFireSocket",Offset=(X=-105.000000,Y=0.000000,Z=0.000000),Scale3D=(X=12.000000,Y=12.000000,Z=12.000000))),TurretControls=("TurretConstraint","TurretYawConstraint"),CameraTag="DriverViewSocket",CameraOffset=-320.000000,MuzzleFlashLightClass=Class'UTGameContent.UTTankMuzzleFlash',SeatIconPOS=(X=0.450000,Y=0.700000))
   VehicleEffects(0)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_SPMA',EffectSocket="DamageSmoke_01")
   VehicleEffects(1)=(EffectStartTag="Deployed",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Piston_Smoke',EffectSocket="BraceA")
   VehicleEffects(2)=(EffectStartTag="Deployed",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Piston_Smoke',EffectSocket="BraceB")
   VehicleEffects(3)=(EffectStartTag="Deployed",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Piston_Smoke',EffectSocket="BraceC")
   VehicleEffects(4)=(EffectStartTag="Deployed",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Piston_Smoke',EffectSocket="BraceD")
   VehicleEffects(5)=(EffectStartTag="Deployed",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Piston_Smoke',EffectSocket="BraceE")
   VehicleEffects(6)=(EffectStartTag="Deployed",bRestartRunning=True,EffectTemplate=ParticleSystem'Envy_Effects.Tests.Effects.P_Piston_Smoke',EffectSocket="BraceF")
   VehicleEffects(7)=(EffectStartTag="CannonFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_PrimaryMuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleEffects(8)=(EffectStartTag="CameraFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_AltMuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleEffects(9)=(EffectStartTag="ShockTurretFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_SecondGin_MF',EffectSocket="GunnerFireSocket")
   VehicleEffects(10)=(EffectStartTag="ShockTurretAltFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_DriverAltMuzzleFlash',EffectSocket="GunnerFireSocket")
   VehicleAnims(0)=(AnimTag="CannonFire",AnimSeqs=("Fire"),AnimRate=1.000000,AnimPlayerName="AnimPlayer")
   VehicleAnims(1)=(AnimTag="CameraFire",AnimSeqs=("Fire"),AnimRate=1.000000,AnimPlayerName="AnimPlayer")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=1.500000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=2.000000)
   DamageMorphTargets(0)=(InfluenceBone="RtFrontBumper_Support",Health=230,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(InfluenceBone="LtFrontLegLow",Health=230,DamagePropNames=("Damage1"))
   DamageMorphTargets(2)=(InfluenceBone="LtFrontLegLow",Health=230,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(InfluenceBone="LtRearFoot",Health=230,DamagePropNames=("Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   DestroyedTurretTemplate=StaticMesh'VH_SPMA.Mesh.S_VH_SPMA_Top'
   TurretExplosiveForce=2000.000000
   ExplosionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Explode'
   IconCoords=(U=918.000000,V=0.000000,UL=18.000000,VL=35.000000)
   PassengerTeamBeaconOffset=(X=100.000000,Y=15.000000,Z=50.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Spawn_Red',MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Spawn_Treads_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Spawn_Blue',MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Spawn_Treads_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_SPMA.Materials.MITV_VH_SPMA_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_SPMA.Materials.MITV_VH_SPMA_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Paladin_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dirt_Effects.P_Hellbender_Wheel_Dirt')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Paladin_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Snow_Effects.P_Paladin_Wheel_Snow')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyHellfire'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyHellfire'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyHellFire'
   HudCoords=(U=493.000000,V=103.000000,UL=-77.000000,VL=135.000000)
   Begin Object Class=UTVehicleSimCar Name=SimObject ObjName=SimObject Archetype=UTVehicleSimCar'UTGame.Default__UTVehicle_SPMA:SimObject'
      ObjectArchetype=UTVehicleSimCar'UTGame.Default__UTVehicle_SPMA:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=UTVehicleWheel Name=RFWheel ObjName=RFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:RFWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:RFWheel'
   End Object
   Wheels(0)=RFWheel
   Begin Object Class=UTVehicleWheel Name=LFWheel ObjName=LFWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:LFWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:LFWheel'
   End Object
   Wheels(1)=LFWheel
   Begin Object Class=UTVehicleWheel Name=RRWheel ObjName=RRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:RRWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:RRWheel'
   End Object
   Wheels(2)=RRWheel
   Begin Object Class=UTVehicleWheel Name=LRWheel ObjName=LRWheel Archetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:LRWheel'
      ObjectArchetype=UTVehicleWheel'UTGame.Default__UTVehicle_SPMA:LRWheel'
   End Object
   Wheels(3)=LRWheel
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_9 ObjName=MyStayUprightSetup_9 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_SPMA:MyStayUprightSetup_9'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_SPMA:MyStayUprightSetup_9'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_SPMA_Content:MyStayUprightSetup_9'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_9 ObjName=MyStayUprightConstraintInstance_9 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_SPMA:MyStayUprightConstraintInstance_9'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_SPMA:MyStayUprightConstraintInstance_9'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_SPMA_Content:MyStayUprightConstraintInstance_9'
   Begin Object Class=AudioComponent Name=SPMAEngineSound ObjName=SPMAEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_EngineIdle'
      Name="SPMAEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=SPMAEngineSound
   CollisionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_EngineRampUp'
   ExitVehicleSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_EngineRampDown'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_SPMA:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_SPMA.Mesh.SK_VH_SPMA'
      AnimTreeTemplate=AnimTree'VH_SPMA.Anims.AT_VH_SPMA'
      PhysicsAsset=PhysicsAsset'VH_SPMA.Mesh.SK_VH_SPMA_Physics'
      AnimSets(0)=AnimSet'VH_SPMA.Anims.VH_SPMA_Anims'
      RBCollideWithChannels=(Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_SPMA:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_SPMA:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=260.000000
      Translation=(X=0.000000,Y=0.000000,Z=100.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_SPMA:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=SPMAEngineSound
   DrawScale=1.300000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_SPMA_Content"
   ObjectArchetype=UTVehicle_SPMA'UTGame.Default__UTVehicle_SPMA'
}
