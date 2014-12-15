/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleFactory_Turret extends UTVehicleFactory_TrackTurretBase;

defaultproperties
{
   VehicleClassPath="UTGameContent.UTVehicle_Turret"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:CollisionCylinder'
      CollisionHeight=80.000000
      CollisionRadius=100.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Turret.Mesh.SK_VH_Turret'
      Translation=(X=0.000000,Y=0.000000,Z=-90.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory_TrackTurretBase:SVehicleMesh'
   End Object
   Components(3)=SVehicleMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTVehicleFactory_Turret"
   ObjectArchetype=UTVehicleFactory_TrackTurretBase'UTGame.Default__UTVehicleFactory_TrackTurretBase'
}
