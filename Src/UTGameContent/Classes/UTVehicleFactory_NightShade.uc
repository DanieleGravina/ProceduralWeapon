/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleFactory_NightShade extends UTVehicleFactory;

defaultproperties
{
   VehicleClassPath="UTGameContent.UTVehicle_NightShade_Content"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicleFactory:CollisionCylinder'
      CollisionHeight=80.000000
      CollisionRadius=140.000000
      Translation=(X=0.000000,Y=0.000000,Z=30.000000)
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
      SkeletalMesh=SkeletalMesh'VH_Nightshade.Mesh.SK_VH_NightShade'
      Translation=(X=40.000000,Y=0.000000,Z=-50.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory:SVehicleMesh'
   End Object
   Components(3)=SVehicleMesh
   DrawScale=1.400000
   CollisionComponent=CollisionCylinder
   Name="Default__UTVehicleFactory_NightShade"
   ObjectArchetype=UTVehicleFactory'UTGame.Default__UTVehicleFactory'
}
