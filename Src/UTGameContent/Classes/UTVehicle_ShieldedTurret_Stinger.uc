/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_ShieldedTurret_Stinger extends UTVehicle_ShieldedTurret;

defaultproperties
{
   Begin Object Class=AudioComponent Name=ACTurretMoveStart ObjName=ACTurretMoveStart Archetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:ACTurretMoveStart'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:ACTurretMoveStart'
   End Object
   TurretMoveStart=ACTurretMoveStart
   Begin Object Class=AudioComponent Name=ACTurretMoveLoop ObjName=ACTurretMoveLoop Archetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:ACTurretMoveLoop'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:ACTurretMoveLoop'
   End Object
   TurretMoveLoop=ACTurretMoveLoop
   Begin Object Class=AudioComponent Name=ACTurretMoveStop ObjName=ACTurretMoveStop Archetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:ACTurretMoveStop'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:ACTurretMoveStop'
   End Object
   TurretMoveStop=ACTurretMoveStop
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_TurretStinger',GunSocket=("GunLeft","GunRight"),GunPivotPoints=("Seat"),WeaponEffects=((SocketName="GunLeft",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=4.000000,Y=4.500000,Z=4.500000)),(SocketName="GunRight",Offset=(X=-35.000000,Y=-3.000000,Z=0.000000),Scale3D=(X=4.000000,Y=4.500000,Z=4.500000))),TurretControls=("PitchControl","LeftYawControl","RightYawControl"),CameraTag="CameraViewSocket",CameraBaseOffset=(X=0.000000,Y=0.000000,Z=50.000000),CameraOffset=-120.000000,CameraEyeHeight=5.000000,bSeatVisible=True,SeatBone="Seat",SeatOffset=(X=36.000000,Y=0.000000,Z=23.000000),SeatRotation=(Pitch=1820,Yaw=0,Roll=0),DriverDamageMult=0.400000,SeatMotionAudio=TurretTwistSound)
   VehicleEffects(1)=(EffectStartTag="TurretFireLeft",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretStingerMF',EffectSocket="GunLeft")
   VehicleEffects(2)=(EffectStartTag="TurretFireRight",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_TurretStingerMF',EffectSocket="GunRight")
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_ShieldedTurret:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_ShieldedTurret:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_ShieldedTurret_Stinger:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_ShieldedTurret:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_ShieldedTurret:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_ShieldedTurret_Stinger:MyStayUprightConstraintInstance'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=ACTurretMoveStart
   Components(4)=ACTurretMoveLoop
   Components(5)=ACTurretMoveStop
   Begin Object Class=AudioComponent Name=TurretTwistSound ObjName=TurretTwistSound Archetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:TurretTwistSound'
      ObjectArchetype=AudioComponent'UTGameContent.Default__UTVehicle_ShieldedTurret:TurretTwistSound'
   End Object
   Components(6)=TurretTwistSound
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_ShieldedTurret_Stinger"
   ObjectArchetype=UTVehicle_ShieldedTurret'UTGameContent.Default__UTVehicle_ShieldedTurret'
}
