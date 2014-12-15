/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicleFactory_Scorpion extends UTVehicleFactory;

defaultproperties
{
   VehicleClassPath="UTGameContent.UTVehicle_Scorpion_Content"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicleFactory:CollisionCylinder'
      CollisionHeight=80.000000
      CollisionRadius=120.000000
      Translation=(X=-45.000000,Y=0.000000,Z=-10.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicleFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTVehicleFactory:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTVehicleFactory:Arrow'
   End Object
   Components(0)=Arrow
   Components(1)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTVehicleFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTVehicleFactory:PathRenderer'
   End Object
   Components(2)=PathRenderer
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Scorpion.Mesh.SK_VH_Scorpion_001'
      Translation=(X=0.000000,Y=0.000000,Z=-70.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory:SVehicleMesh'
   End Object
   Components(3)=SVehicleMesh
   DrawScale=1.200000
   CollisionComponent=CollisionCylinder
   Name="Default__UTVehicleFactory_Scorpion"
   ObjectArchetype=UTVehicleFactory'UTGame.Default__UTVehicleFactory'
}
