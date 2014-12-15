/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Raptor_Content extends UTVehicle_Raptor;

var color EffectColor[2];

simulated function SetVehicleEffectParms(name TriggerName, ParticleSystemComponent PSC)
{
	if (TriggerName == 'RaptorWeapon01' || TriggerName == 'RaptorWeapon02')
	{
		PSC.SetColorParameter('MFlashColor',EffectColor[GetTeamNum()]);
	}
	else
	{
		Super.SetVehicleEffectParms(TriggerName, PSC);
	}
}

simulated function vector GetPhysicalFireStartLoc(UTWeapon ForWeapon)
{
	local vector RocketSocketL;
	local rotator RocketSocketR;

	if (ForWeapon.CurrentFireMode == 1)
	{
		Mesh.GetSocketWorldLocationAndRotation('RocketSocket',RocketSocketL, RocketSocketR);
		return RocketSocketL;
	}
	else
		return Super.GetPhysicalFireStartLoc(ForWeapon);
}

defaultproperties
{
   EffectColor(0)=(B=35,G=26,R=151,A=255)
   EffectColor(1)=(B=151,G=26,R=35,A=255)
   TurretPivotSocketName="TurretPiv"
   TeamMF(0)=ParticleSystem'VH_Raptor.Effects.PS_Raptor_MF'
   TeamMF(1)=ParticleSystem'VH_Raptor.Effects.PS_Raptor_MF_Blue'
   ContrailEffectIndices(0)=3
   ContrailEffectIndices(1)=4
   ContrailEffectIndices(2)=5
   ContrailEffectIndices(3)=6
   GroundEffectIndices(0)=9
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Raptor:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Raptor:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_RaptorGun',GunSocket=("Gun_Socket_01","Gun_Socket_02"),GunPivotPoints=("left_gun","rt_gun"),WeaponEffects=((SocketName="Gun_Socket_01",Offset=(X=-55.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=6.000000,Y=6.000000,Z=6.000000)),(SocketName="Gun_Socket_02",Offset=(X=-55.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=6.000000,Y=6.000000,Z=6.000000))),TurretControls=("gun_rotate_lt","gun_rotate_rt"),CameraTag="ViewSocket",CameraOffset=-384.000000,SeatIconPOS=(X=0.450000,Y=0.400000))
   VehicleEffects(0)=(EffectStartTag="RaptorWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.PS_Raptor_MF',EffectSocket="Gun_Socket_02")
   VehicleEffects(1)=(EffectStartTag="RaptorWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.PS_Raptor_MF',EffectSocket="Gun_Socket_01")
   VehicleEffects(2)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Raptor',EffectSocket="DamageSmoke_01")
   VehicleEffects(3)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Contrail',EffectSocket="LeftTip")
   VehicleEffects(4)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Contrail',EffectSocket="RightTip")
   VehicleEffects(5)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Contrail',EffectSocket="RearRtContrail")
   VehicleEffects(6)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,bHighDetailOnly=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Contrail',EffectSocket="RearLtContrail")
   VehicleEffects(7)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Exhaust',EffectSocket="ExhaustL")
   VehicleEffects(8)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Exhaust',EffectSocket="ExhaustR")
   VehicleEffects(9)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Raptor.Effects.P_VH_Raptor_GroundEffect',EffectSocket="GroundEffectBase")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=2.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=4.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=2.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_Rear",InfluenceBone="Rudder_Rt",Health=105,DamagePropNames=("Damage2","Damage1"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_Rear",InfluenceBone="Rudder_left",Health=105,DamagePropNames=("Damage2","Damage1"))
   DamageMorphTargets(2)=(MorphNodeName="MorphNodeW_Left",InfluenceBone="Lft_Wing_Damage2",Health=140,DamagePropNames=("Damage3"))
   DamageMorphTargets(3)=(MorphNodeName="MorphNodeW_Right",InfluenceBone="Rt_Wing_Damage1",Health=140,DamagePropNames=("Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Raptor.Materials.MI_VH_Raptor_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Raptor.Materials.MI_VH_Raptor_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_SMALL_Near')
   BigExplosionSocket="VH_Death"
   ExplosionSound=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_Explode'
   Begin Object Class=AudioComponent Name=BaseScrapeSound ObjName=BaseScrapeSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Gameplay.A_Gameplay_Onslaught_MetalScrape01Cue'
      Name="BaseScrapeSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   ScrapeSound=BaseScrapeSound
   IconCoords=(U=859.000000,V=27.000000,UL=25.000000,VL=46.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Raptor.Materials.MI_VH_Raptor_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Raptor.Materials.MI_VH_Raptor_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Raptor.Materials.MITV_VH_Raptor_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Raptor.Materials.MITV_VH_Raptor_Blue_BO'
   HoverBoardAttachSockets(0)="HoverAttach00"
   ReferenceMovementMesh=StaticMesh'Envy_Effects.Mesh.S_Air_Wind_Ball'
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyRaptor'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyRaptor'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyRaptor'
   HudCoords=(U=571.000000,V=129.000000,UL=-75.000000,VL=137.000000)
   Begin Object Class=UTVehicleSimChopper Name=SimObject ObjName=SimObject Archetype=UTVehicleSimChopper'UTGame.Default__UTVehicle_Raptor:SimObject'
      ObjectArchetype=UTVehicleSimChopper'UTGame.Default__UTVehicle_Raptor:SimObject'
   End Object
   SimObj=SimObject
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_2 ObjName=MyStayUprightSetup_2 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Raptor:MyStayUprightSetup_2'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Raptor:MyStayUprightSetup_2'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Raptor_Content:MyStayUprightSetup_2'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_2 ObjName=MyStayUprightConstraintInstance_2 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Raptor:MyStayUprightConstraintInstance_2'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Raptor:MyStayUprightConstraintInstance_2'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Raptor_Content:MyStayUprightConstraintInstance_2'
   Begin Object Class=AudioComponent Name=RaptorEngineSound ObjName=RaptorEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_EngineLoop'
      Name="RaptorEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=RaptorEngineSound
   CollisionSound=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_Start'
   ExitVehicleSound=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_Stop'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Raptor:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Raptor.Mesh.SK_VH_Raptor'
      AnimTreeTemplate=AnimTree'VH_Raptor.Anims.AT_VH_Raptor'
      PhysicsAsset=PhysicsAsset'VH_Raptor.Anims.SK_VH_Raptor_Physics'
      MorphSets(0)=MorphTargetSet'VH_Raptor.Mesh.SK_VH_Raptor_MorphTargets'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Raptor:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Raptor:CollisionCylinder'
      CollisionHeight=70.000000
      CollisionRadius=140.000000
      Translation=(X=-40.000000,Y=0.000000,Z=40.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Raptor:CollisionCylinder'
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
   Name="Default__UTVehicle_Raptor_Content"
   ObjectArchetype=UTVehicle_Raptor'UTGame.Default__UTVehicle_Raptor'
}
