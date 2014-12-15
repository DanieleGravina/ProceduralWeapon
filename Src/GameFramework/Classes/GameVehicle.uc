/**
 * GameVehicle
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class GameVehicle extends SVehicle
	config(Game)
	native
	abstract
	notplaceable;

defaultproperties
{
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'Engine.Default__SVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'Engine.Default__SVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'GameFramework.Default__GameVehicle:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'Engine.Default__SVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'Engine.Default__SVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'GameFramework.Default__GameVehicle:MyStayUprightConstraintInstance'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'Engine.Default__SVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__SVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__SVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   bCanBeAdheredTo=True
   bCanBeFrictionedTo=True
   CollisionComponent=SVehicleMesh
   Name="Default__GameVehicle"
   ObjectArchetype=SVehicle'Engine.Default__SVehicle'
}
