/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicleFactory_Eradicator extends UTVehicleFactory;

function Deactivate()
{
	local int i;

	// kick players out of turrets instead of killing them
	if (ChildVehicle != None)
	{
		for (i = 0; i < ChildVehicle.Seats.length; i++)
		{
			if (ChildVehicle.Seats[i].SeatPawn != None && ChildVehicle.Seats[i].SeatPawn.bDriving)
			{
				ChildVehicle.Seats[i].SeatPawn.DriverLeave(true);
			}
		}
	}

	Super.Deactivate();
}

defaultproperties
{
   VehicleClassPath="UT3Gold.UTVehicle_Eradicator_Content"
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicleFactory:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=260.000000
      Translation=(X=-10.000000,Y=0.000000,Z=-20.000000)
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
      SkeletalMesh=SkeletalMesh'VH_SPMA.Mesh.SK_VH_SPMA'
      Translation=(X=40.000000,Y=0.000000,Z=-90.000000)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleFactory:SVehicleMesh'
   End Object
   Components(3)=SVehicleMesh
   DrawScale=1.300000
   CollisionComponent=CollisionCylinder
   Name="Default__UTVehicleFactory_Eradicator"
   ObjectArchetype=UTVehicleFactory'UTGame.Default__UTVehicleFactory'
}
