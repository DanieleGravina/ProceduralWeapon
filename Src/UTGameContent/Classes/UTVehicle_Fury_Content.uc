/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Fury_Content extends UTVehicle_Fury;

/** dynamic light which moves around following primary fire beam impact point */
var UTFuryBeamLight BeamLight;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	AnimPlayer = UTAnimNodeSequence(Mesh.FindAnimNode('AnimPlayer'));
	BlendNode = AnimNodeBlend(Mesh.FindAnimNode('LandBlend'));

	ArmBlendNodes[0] = UTAnimBlendByCollision( Mesh.FindAnimNode('UpRtBlend') );
	ArmBlendNodes[1] = UTAnimBlendByCollision( Mesh.FindAnimNode('UpLtBlend') );
	ArmBlendNodes[2] = UTAnimBlendByCollision( Mesh.FindAnimNode('LwRtBlend') );
	ArmBlendNodes[3] = UTAnimBlendByCollision( Mesh.FindAnimNode('LwLtBlend') );
}

simulated event PlayLanding()
{
 	Mesh.bForceDiscardRootMotion = false;
	AnimPlayer.PlayAnimation('Land',1.0,false);
	BlendNode.SetBlendTarget(1.0, 0.25);
}

simulated event PlayTakeOff()
{
	AnimPlayer.PlayAnimation('TakeOff',1.0,false);
	BlendNode.SetBlendTarget(0.0,TakeOffRate);
}

event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
	Super.OnAnimEnd(SeqNode, PlayedTime, ExcessTime);
	if (SeqNode.AnimSeqName == 'TakeOff')
	{
		Mesh.bForceDiscardRootMotion = true;
	}
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (BeamLight != None)
	{
		BeamLight.Destroy();
	}
}

simulated function KillBeamEmitter()
{
	Super.KillBeamEmitter();
	if (BeamLight != None)
	{
		BeamLight.Destroy();
	}
}

simulated function SetBeamEmitterHidden(bool bHide)
{
	Super.SetBeamEmitterHidden(bHide);

	if (bHide && BeamLight != None)
	{
		BeamLight.AmbientSound.Stop();
		BeamLight.Destroy();
	}
}

simulated function VehicleWeaponFired( bool bViaReplication, vector HitLocation, int SeatIndex )
{
	Super.VehicleWeaponFired(bViaReplication,HitLocation,SeatIndex);

	if (WorldInfo.NetMode != NM_DedicatedServer && !IsZero(HitLocation))
	{
		if (BeamLight == None || BeamLight.bDeleteMe)
		{
			BeamLight = spawn(class'UTFuryBeamLight');
			BeamLight.AmbientSound.Play();
		}
		BeamLight.SetLocation(HitLocation + vect(0,0,128));
	}
}

defaultproperties
{
   BoostCameraShake=CameraAnim'Camera_FX.VH_Fury.C_VH_Fury_Boost'
   BeamTemplate=ParticleSystem'VH_Fury.Effects.P_VH_Fury_AltBeam'
   BeamSockets(0)="ArmSocket0"
   BeamSockets(1)="ArmSocket1"
   BeamSockets(2)="ArmSocket2"
   BeamSockets(3)="ArmSocket3"
   EndPointParamName="LinkBeamEnd"
   EndPointNormalParamName="FuryBeamTargetTangent"
   EndPointNormalLength=-200.000000
   BeamFireSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_AltBeamCue'
   AfterburnerSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_ThrustCue'
   StrafeSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_StrafeCue'
   Begin Object Class=AudioComponent Name=BeamAmbientSoundComponent ObjName=BeamAmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="BeamAmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BeamAmbientSound=BeamAmbientSoundComponent
   BeamStartSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_AltBeamStartCue'
   BeamStopSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_AltBeamStopCue'
   Begin Object Class=AudioComponent Name=BoostAmbientSoundComponent ObjName=BoostAmbientSoundComponent Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      bShouldRemainActiveIfDropped=True
      Name="BoostAmbientSoundComponent"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   BoostComponent=BoostAmbientSoundComponent
   JetSFX(0)=(ExhaustTag="MainThrusters")
   JetSFX(1)=(ExhaustTag="LeftThrusters")
   JetSFX(2)=(ExhaustTag="RightThrusters")
   BoosterNames(0)="MainThrustersBoost"
   BoosterNames(1)="LeftThrustersBoost"
   BoosterNames(2)="RightThrustersBoost"
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Fury:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Fury:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_FuryGun',GunSocket=("LeftCannonA","RightCannonA","LeftCannonB","RightCannonB","LeftCannonC","RightCannonC"),GunPivotPoints=("LeftCannon","RightCannon"),WeaponEffects=((SocketName="ArmSocket0",Scale3D=(X=5.000000,Y=8.000000,Z=8.000000)),(SocketName="ArmSocket1",Scale3D=(X=5.000000,Y=8.000000,Z=8.000000)),(SocketName="ArmSocket2",Scale3D=(X=5.000000,Y=8.000000,Z=8.000000)),(SocketName="ArmSocket3",Scale3D=(X=5.000000,Y=8.000000,Z=8.000000))),TurretControls=("LeftTurretConstraint","RightTurretConstraint","LeftTentacleTurretConstraint","RightTentacleTurretConstraint"),CameraBaseOffset=(X=0.000000,Y=0.000000,Z=100.000000),CameraOffset=-400.000000,SeatIconPOS=(X=0.480000,Y=0.500000))
   VehicleEffects(0)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Fury.Effects.P_VH_Fury_Exhaust',EffectTemplate_Blue=ParticleSystem'VH_Fury.Effects.P_VH_Fury_Exhaust_Blue',EffectSocket="ExhaustSocket")
   VehicleEffects(1)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Fury',EffectSocket="DamageSmoke_01")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=3.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=3.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=3.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_Bottom",InfluenceBone="Tail_Damage1",Health=100,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_Left",InfluenceBone="Lt_Wing_Damage1",Health=100,DamagePropNames=("Damage1"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeW_Left",InfluenceBone="Lt_Wing_Damage2",Health=100,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(MorphNodeName="MorphNodeW_Right",InfluenceBone="Rt_Wing_Damage1",Health=100,DamagePropNames=("Damage1"))
   DamageMorphTargets(4)=(MorphNodeName="MorphNodeW_Right",InfluenceBone="Rt_Wing_Damage2",Health=100,DamagePropNames=("Damage1"))
   DamageMorphTargets(5)=(InfluenceBone="Base_Animated",Health=100,DamagePropNames=("Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Fury.Materials.MI_VH_Fury_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Fury.Materials.MI_VH_Fury_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.A_Gameplay_Onslaught_MetalScrape01Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   SpawnInSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeInNecris01Cue'
   SpawnOutSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeOutNecris01Cue'
   IconCoords=(U=858.000000,V=73.000000,UL=51.000000,VL=20.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Fury.Materials.MI_VH_Fury_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Fury.Materials.MI_VH_Fury_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Fury.Materials.MITV_VH_Fury_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Fury.Materials.MITV_VH_Fury_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   ReferenceMovementMesh=StaticMesh'Envy_Effects.Mesh.S_Air_Wind_Ball'
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyFury'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyFury'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyFury'
   HudCoords=(U=543.000000,UL=-147.000000,VL=103.000000)
   Begin Object Class=UTVehicleSimChopper Name=SimObject ObjName=SimObject Archetype=UTVehicleSimChopper'UTGame.Default__UTVehicle_Fury:SimObject'
      ObjectArchetype=UTVehicleSimChopper'UTGame.Default__UTVehicle_Fury:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_1 ObjName=MyStayUprightSetup_1 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Fury:MyStayUprightSetup_1'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Fury:MyStayUprightSetup_1'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Fury_Content:MyStayUprightSetup_1'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_1 ObjName=MyStayUprightConstraintInstance_1 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Fury:MyStayUprightConstraintInstance_1'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Fury:MyStayUprightConstraintInstance_1'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Fury_Content:MyStayUprightConstraintInstance_1'
   Begin Object Class=AudioComponent Name=FuryEngineSound ObjName=FuryEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_EngineLoopCue'
      Name="FuryEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=FuryEngineSound
   CollisionSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_StartCue'
   ExitVehicleSound=SoundCue'A_Vehicle_Fury.Cue.A_Vehicle_Fury_StopCue'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Fury:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Fury.Mesh.SK_VH_Fury'
      AnimTreeTemplate=AnimTree'VH_Fury.Anims.AT_VH_Fury'
      PhysicsAsset=PhysicsAsset'VH_Fury.Mesh.SK_VH_Fury_Physics'
      AnimSets(0)=AnimSet'VH_Fury.Anims.K_VH_Fury'
      MorphSets(0)=MorphTargetSet'VH_Fury.Mesh.SK_VH_Fury_MorphTargets'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Fury:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Fury:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Fury:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   Components(4)=FuryEngineSound
   Components(5)=BaseScrapeSound
   Components(6)=BeamAmbientSoundComponent
   Components(7)=BoostAmbientSoundComponent
   DrawScale=1.300000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Fury_Content"
   ObjectArchetype=UTVehicle_Fury'UTGame.Default__UTVehicle_Fury'
}
