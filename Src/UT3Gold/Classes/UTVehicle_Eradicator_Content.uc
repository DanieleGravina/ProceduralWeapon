/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Eradicator_Content extends UTVehicle_Eradicator;

/** sound of the moving turret */
var SoundCue TurretMovementSound;

var MaterialInterface BurnOutMaterialTread[2];

defaultproperties
{
   TurretMovementSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_CannonRotate'
   CameraFireToolTipIconCoords=(U=2.000000,V=371.000000,UL=124.000000,VL=115.000000)
   bHasTurretExplosion=True
   bHasEnemyVehicleSound=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Eradicator:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Eradicator:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UT3Gold.UTVWeap_EradicatorCannon_Content',GunSocket=("TurretFireSocket"),GunPivotPoints=("MainTurret_Yaw"),WeaponEffects=((SocketName="TurretFireSocket",Offset=(X=-105.000000,Y=0.000000,Z=0.000000),Scale3D=(X=12.000000,Y=12.000000,Z=12.000000))),TurretControls=("TurretConstraint","TurretYawConstraint"),CameraTag="DriverViewSocket",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=100.000000),CameraOffset=-320.000000,MuzzleFlashLightClass=Class'UTGameContent.UTTankMuzzleFlash',SeatIconPOS=(X=0.450000,Y=0.700000))
   VehicleEffects(0)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_SPMA',EffectSocket="DamageSmoke_01")
   VehicleEffects(1)=(bRestartRunning=True)
   VehicleEffects(2)=(bRestartRunning=True)
   VehicleEffects(3)=(bRestartRunning=True)
   VehicleEffects(4)=(bRestartRunning=True)
   VehicleEffects(5)=(bRestartRunning=True)
   VehicleEffects(6)=(bRestartRunning=True)
   VehicleEffects(7)=(EffectStartTag="CannonFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_PrimaryMuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleEffects(8)=(EffectStartTag="CameraFire",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_AltMuzzleFlash',EffectSocket="TurretFireSocket")
   VehicleAnims(0)=(AnimTag="CannonFire",AnimSeqs=("Fire"),AnimRate=1.000000,AnimPlayerName="AnimPlayer")
   VehicleAnims(1)=(AnimTag="CameraFire",AnimSeqs=("Fire"),AnimRate=1.000000,AnimPlayerName="AnimPlayer")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=1.500000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=1.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=2.000000)
   DamageMorphTargets(0)=(InfluenceBone="RtFrontBumper_Support",Health=230,DamagePropNames=("Damage2"))
   DamageMorphTargets(1)=(InfluenceBone="LtFrontLegLow",Health=230,DamagePropNames=("Damage1"))
   DamageMorphTargets(2)=(InfluenceBone="LtFrontLegLow",Health=230,DamagePropNames=("Damage1"))
   DamageMorphTargets(3)=(InfluenceBone="LtRearFoot",Health=230,DamagePropNames=("Damage3"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_ERAD.Materials.MI_VH_ERAD_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_ERAD.Materials.MI_VH_ERAD_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   DestroyedTurretTemplate=StaticMesh'VH_SPMA.Mesh.S_VH_SPMA_Top'
   TurretExplosiveForce=2000.000000
   ExplosionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Explode'
   IconCoords=(U=918.000000,V=0.000000,UL=18.000000,VL=35.000000)
   PassengerTeamBeaconOffset=(X=100.000000,Y=15.000000,Z=50.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_SPMA.Materials.MI_VH_SPMA_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_ERAD.Materials.MITV_VH_ERAD_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_ERAD.Materials.MITV_VH_ERAD_Blue_BO'
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Paladin_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dirt_Effects.P_Hellbender_Wheel_Dirt')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Paladin_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Snow_Effects.P_Paladin_Wheel_Snow')
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyHellfire'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyHellfire'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyHellFire'
   HudCoords=(U=493.000000,V=103.000000,UL=-77.000000,VL=135.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Eradicator:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Eradicator:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UT3Gold.Default__UTVehicle_Eradicator_Content:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Eradicator:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Eradicator:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UT3Gold.Default__UTVehicle_Eradicator_Content:MyStayUprightConstraintInstance'
   Begin Object Class=AudioComponent Name=SPMAEngineSound ObjName=SPMAEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_EngineIdle'
      Name="SPMAEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=SPMAEngineSound
   CollisionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_Collide'
   EnterVehicleSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_EngineRampUp'
   ExitVehicleSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_EngineRampDown'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Eradicator:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_ERAD.Mesh.SK_VH_ERAD_Cannon'
      AnimTreeTemplate=AnimTree'VH_ERAD.Anim.SK_VH_ERAD_AnimTree'
      PhysicsAsset=PhysicsAsset'VH_ERAD.Mesh.SK_VH_ERAD_Cannon_Physics'
      AnimSets(0)=AnimSet'VH_SPMA.Anims.VH_SPMA_Anims'
      RBCollideWithChannels=(Untitled4=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Eradicator:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Eradicator:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=260.000000
      Translation=(X=0.000000,Y=0.000000,Z=100.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Eradicator:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SPMAEngineSound
   DrawScale=1.300000
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Eradicator_Content"
   ObjectArchetype=UTVehicle_Eradicator'UTGame.Default__UTVehicle_Eradicator'
}
