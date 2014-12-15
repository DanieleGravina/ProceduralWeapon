/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


/** used on non-owning clients when driving a UTWeaponPawn, as those aren't replicated for performance reasons
 * but lots of code looks for Pawn.DrivenVehicle so we need something there
 */
class UTClientSideWeaponPawn extends UTWeaponPawn;

simulated function PreBeginPlay();

simulated function AttachDriver(Pawn P)
{
	Driver = P;
	bDriving = true;
	Super.AttachDriver(P);
}

simulated function DetachDriver(Pawn P)
{
	Super.DetachDriver(P);
	Destroy();
}

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);

	// make sure we get destroyed when no longer in use
	if (Driver == None || Driver.bDeleteMe || Driver.DrivenVehicle != self)
	{
		Destroy();
	}
}

defaultproperties
{
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTWeaponPawn:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTWeaponPawn:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTClientSideWeaponPawn:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTWeaponPawn:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTWeaponPawn:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTClientSideWeaponPawn:MyStayUprightConstraintInstance'
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeaponPawn:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeaponPawn:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTWeaponPawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTWeaponPawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   CollisionComponent=SVehicleMesh
   Name="Default__UTClientSideWeaponPawn"
   ObjectArchetype=UTWeaponPawn'UTGame.Default__UTWeaponPawn'
}
