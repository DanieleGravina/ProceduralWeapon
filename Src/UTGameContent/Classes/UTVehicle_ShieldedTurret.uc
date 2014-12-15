/**
 * Once upon a time these turrets actually had shields. Really.
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_ShieldedTurret extends UTVehicle_TrackTurretBase
	abstract;

var GameSkelCtrl_Recoil	RecoilLeft, RecoilRight;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	Super.PostInitAnimTree(SkelComp);

	if (SkelComp == Mesh)
	{
		RecoilLeft = GameSkelCtrl_Recoil( mesh.FindSkelControl('LeftRecoil') );
		RecoilRight = GameSkelCtrl_Recoil( mesh.FindSkelControl('RightRecoil') );
	}
}

simulated function VehicleWeaponFireEffects(vector HitLocation, int SeatIndex)
{
	local Name FireTriggerTag;

	Super.VehicleWeaponFireEffects(HitLocation, SeatIndex);

	FireTriggerTag = Seats[SeatIndex].GunClass.static.GetFireTriggerTag( GetBarrelIndex(SeatIndex), SeatFiringMode(SeatIndex,,true) );

	switch(FireTriggerTag)
	{
	case 'TurretFireRight':
		RecoilRight.bPlayRecoil = TRUE;
		break;

	case 'TurretFireLeft':
		RecoilLeft.bPlayRecoil = TRUE;
		break;
	}
}

defaultproperties
{
   Begin Object Class=AudioComponent Name=ACTurretMoveStart ObjName=ACTurretMoveStart Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Turret.Cue.A_Turret_TrackStart01Cue'
      Name="ACTurretMoveStart"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TurretMoveStart=ACTurretMoveStart
   Begin Object Class=AudioComponent Name=ACTurretMoveLoop ObjName=ACTurretMoveLoop Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Turret.Cue.A_Turret_TrackLoop01Cue'
      Name="ACTurretMoveLoop"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TurretMoveLoop=ACTurretMoveLoop
   Begin Object Class=AudioComponent Name=ACTurretMoveStop ObjName=ACTurretMoveStop Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Turret.Cue.A_Turret_TrackStop01Cue'
      Name="ACTurretMoveStop"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TurretMoveStop=ACTurretMoveStop
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_TrackTurretBase:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_TrackTurretBase:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   VehicleEffects(0)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_TurretSmall',EffectSocket="DamageSmoke_01")
   VehicleAnims(0)=(AnimTag="EngineStart",AnimSeqs=("GetIn"),AnimRate=1.000000,AnimPlayerName="TurretPlayer")
   VehicleAnims(1)=(AnimTag="EngineStop",AnimSeqs=("GetOut"),AnimRate=1.000000,AnimPlayerName="TurretPlayer")
   TeamMaterials(0)=MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Blue'
   DrivingAnim="Hellbender_Idle_Sitting"
   FlagOffset=(X=0.000000,Y=0.000000,Z=25.000000)
   FlagBone="base-piston"
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Turret.Material.MITV_VH_Turret_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Turret.Material.MITV_VH_Turret_Blue_BO'
   HudCoords=(U=92.000000,V=249.000000,UL=-92.000000,VL=118.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_ShieldedTurret:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_ShieldedTurret:MyStayUprightConstraintInstance'
   CollisionSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Collide'
   TargetLocationAdjustment=(X=0.000000,Y=0.000000,Z=55.000000)
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_TrackTurretBase:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Turret.Mesh.SK_VH_TurretSmall'
      AnimTreeTemplate=AnimTree'VH_Turret.Anims.AT_VH_TurretSmall'
      PhysicsAsset=PhysicsAsset'VH_Turret.Mesh.SK_VH_TurretSmall_Physics'
      AnimSets(0)=AnimSet'VH_Turret.Anims.VH_TurretSmall_Anims'
      bUseSingleBodyPhysics=0
      bHasPhysicsAssetInstance=True
      Translation=(X=0.000000,Y=0.000000,Z=-55.000000)
      Scale=3.500000
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_TrackTurretBase:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_TrackTurretBase:CollisionCylinder'
      CollisionHeight=80.000000
      CollisionRadius=100.000000
      Translation=(X=0.000000,Y=0.000000,Z=60.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_TrackTurretBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=ACTurretMoveStart
   Components(4)=ACTurretMoveLoop
   Components(5)=ACTurretMoveStop
   Begin Object Class=AudioComponent Name=TurretTwistSound ObjName=TurretTwistSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Turret.Cue.A_Turret_Rotate'
      Name="TurretTwistSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(6)=TurretTwistSound
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_ShieldedTurret"
   ObjectArchetype=UTVehicle_TrackTurretBase'UTGame.Default__UTVehicle_TrackTurretBase'
}
