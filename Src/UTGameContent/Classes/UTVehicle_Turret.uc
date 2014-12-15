/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Turret extends UTVehicle_TrackTurretBase
	dependson(UTSkelControl_Turretconstrained);

/** The Template of the Beam to use */
var ParticleSystem BeamTemplate;

var color EffectColor;
var bool bFireRight;

var GameSkelCtrl_Recoil	RecoilUL, RecoilUR, RecoilLL, RecoilLR;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	Super.PostInitAnimTree(SkelComp);

	if (SkelComp == Mesh)
	{
		RecoilUL = GameSkelCtrl_Recoil( mesh.FindSkelControl('RecoilUL') );
		RecoilUR = GameSkelCtrl_Recoil( mesh.FindSkelControl('RecoilUR') );
		RecoilLL = GameSkelCtrl_Recoil( mesh.FindSkelControl('RecoilLL') );
		RecoilLR = GameSkelCtrl_Recoil( mesh.FindSkelControl('RecoilLR') );
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'FlashLocation' && !IsZero(FlashLocation))
	{
		bFireRight = !bFireRight;
	}

	super.ReplicatedEvent(VarName);
}

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local ParticleSystemComponent Beam;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	// Handle Beam Effects for the shock beam
	if (!IsZero(HitLocation))
	{
		Beam = WorldInfo.MyEmitterPool.SpawnEmitter(BeamTemplate, GetEffectLocation(SeatIndex));
		Beam.SetVectorParameter('ShockBeamEnd', HitLocation);
	}
}

function SetFlashLocation( Weapon Who, byte FireModeNum, vector NewLoc )
{
	Super.SetFlashLocation(Who,FireModeNum,NewLoc);
	bFireRight = !bFireRight;
}


simulated function SetVehicleEffectParms(name TriggerName, ParticleSystemComponent PSC)
{
	if (TriggerName == 'FireRight' || TriggerName == 'FireLeft')
	{
		PSC.SetColorParameter('MFlashColor',EffectColor);
	}
	else
	{
		Super.SetVehicleEffectParms(TriggerName, PSC);
	}
}

simulated function VehicleWeaponFireEffects(vector HitLocation, int SeatIndex)
{
	local Name FireTriggerTag;

	Super.VehicleWeaponFireEffects(HitLocation, SeatIndex);

	FireTriggerTag = Seats[SeatIndex].GunClass.static.GetFireTriggerTag( GetBarrelIndex(SeatIndex), SeatFiringMode(SeatIndex,,true) );

	switch(FireTriggerTag)
	{
	case 'FireUL':
		RecoilUL.bPlayRecoil = TRUE;
		break;

	case 'FireUR':
		RecoilUR.bPlayRecoil = TRUE;
		break;

	case 'FireLL':
		RecoilLL.bPlayRecoil = TRUE;
		break;

	case 'FireLR':
		RecoilLR.bPlayRecoil = TRUE;
		break;
	}
}

/**
 * We override GetCameraStart for the Turret so that it just uses the Socket Location
 */
simulated function vector GetCameraStart(int SeatIndex)
{
	local vector CamStart;

	if (Mesh.GetSocketWorldLocationAndRotation(Seats[SeatIndex].CameraTag, CamStart) )
	{
		return CamStart + (Seats[SeatIndex].CameraBaseOffset >> Rotation);
	}
	else
	{
		return Super.GetCameraStart(SeatIndex);
	}
}

defaultproperties
{
   BeamTemplate=ParticleSystem'VH_Turret.Effects.P_VH_Turret_TurretBeam'
   EffectColor=(B=151,G=26,R=35,A=255)
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
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_TurretPrimary',GunSocket=("LU_Barrel","RU_Barrel","LL_Barrel","RL_Barrel"),GunPivotPoints=("Seat"),WeaponEffects=((SocketName="LL_Barrel",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=4.000000,Y=4.500000,Z=4.500000)),(SocketName="RL_Barrel",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=4.000000,Y=4.500000,Z=4.500000)),(SocketName="LU_Barrel",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=4.000000,Y=4.500000,Z=4.500000)),(SocketName="RU_Barrel",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=4.000000,Y=4.500000,Z=4.500000))),TurretControls=("MegaTurret","TurretBase"),bDisableOffsetZAdjust=True,CameraTag="CameraViewSocket",CameraOffset=-120.000000,CameraEyeHeight=5.000000,bSeatVisible=True,SeatBone="Seat",SeatOffset=(X=43.000000,Y=0.000000,Z=-7.000000),DriverDamageMult=0.100000,SeatMotionAudio=TurretTwistSound,SeatIconPOS=(X=0.470000,Y=0.650000))
   VehicleEffects(0)=(EffectStartTag="FireUL",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Turret.Effects.P_VH_Turret_MuzzleFlash',EffectSocket="LU_Barrel")
   VehicleEffects(1)=(EffectStartTag="FireUR",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Turret.Effects.P_VH_Turret_MuzzleFlash',EffectSocket="RU_Barrel")
   VehicleEffects(2)=(EffectStartTag="FireLL",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Turret.Effects.P_VH_Turret_MuzzleFlash',EffectSocket="LL_Barrel")
   VehicleEffects(3)=(EffectStartTag="FireLR",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Turret.Effects.P_VH_Turret_MuzzleFlash',EffectSocket="RL_Barrel")
   VehicleEffects(4)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Turret',EffectSocket="DamageSmoke_01")
   VehicleAnims(0)=(AnimTag="EngineStart",AnimSeqs=("GetIn"),AnimRate=1.000000,AnimPlayerName="TurretPlayer")
   VehicleAnims(1)=(AnimTag="EngineStop",AnimSeqs=("GetOut"),AnimRate=1.000000,AnimPlayerName="TurretPlayer")
   TeamMaterials(0)=MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Blue'
   FlagOffset=(X=-45.000000,Y=60.000000,Z=85.000000)
   FlagBone="Seat"
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Turret.Material.MI_VH_Turret_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Turret.Material.MITV_VH_Turret_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Turret.Material.MITV_VH_Turret_Blue_BO'
   HudCoords=(U=92.000000,V=249.000000,UL=-92.000000,VL=118.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Turret:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Turret:MyStayUprightConstraintInstance'
   CollisionSound=SoundCue'A_Vehicle_Manta.SoundCues.A_Vehicle_Manta_Collide'
   ExitRadius=175.000000
   TargetLocationAdjustment=(X=0.000000,Y=0.000000,Z=100.000000)
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_TrackTurretBase:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Turret.Mesh.SK_VH_Turret'
      AnimTreeTemplate=AnimTree'VH_Turret.Anims.AT_VH_Turret'
      PhysicsAsset=PhysicsAsset'VH_Turret.Mesh.SK_VH_Turret_Physics'
      AnimSets(0)=AnimSet'VH_Turret.Anims.VH_Turret_anims'
      Translation=(X=0.000000,Y=0.000000,Z=-68.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_TrackTurretBase:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_TrackTurretBase:CollisionCylinder'
      CollisionHeight=80.000000
      CollisionRadius=100.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_TrackTurretBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Begin Object Class=AudioComponent Name=TurretTwistSound ObjName=TurretTwistSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Turret.Cue.A_Turret_Rotate'
      Name="TurretTwistSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(3)=TurretTwistSound
   Components(4)=ACTurretMoveStart
   Components(5)=ACTurretMoveLoop
   Components(6)=ACTurretMoveStop
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Turret"
   ObjectArchetype=UTVehicle_TrackTurretBase'UTGame.Default__UTVehicle_TrackTurretBase'
}
