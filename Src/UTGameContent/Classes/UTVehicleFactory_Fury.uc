/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleFactory_Fury extends UTVehicleFactory;

defaultproperties
{
   VehicleClassPath="UTGameContent.UTVehicle_Fury_Content"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicleFactory:CollisionCylinder'
      CollisionHeight=240.000000
      CollisionRadius=384.000000
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
      SkeletalMesh=SkeletalMesh'VH_Fury.Mesh.SK_VH_Fury'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory:SVehicleMesh'
   End Object
   Components(3)=SVehicleMesh
   CollisionComponent=CollisionCylinder
   Name="Default__UTVehicleFactory_Fury"
   ObjectArchetype=UTVehicleFactory'UTGame.Default__UTVehicleFactory'
}
