/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


/** base class for vehicles that fly or hover */
class UTAirVehicle extends UTHoverVehicle
	native(Vehicle)
	abstract;

/** indices into VehicleEffects array of contrail effects that have their 'ContrailColor' parameter set via C++ */
var array<int> ContrailEffectIndices;

/** parameter name for contrail color (determined by speed) */
var name ContrailColorParameterName;

var bool bAutoLand;
var float PushForce;	// for AI when landing;

var localized string RadarLockMessage;				/** Displayed when enemy raptor fires locked missile at you */

var float LastRadarLockWarnTime;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

native function float GetGravityZ();

simulated event LockOnWarning(UTProjectile IncomingMissile)
{
	if ( UTProj_AvrilRocketBase(IncomingMissile) != None )
	{
		SendLockOnMessage(2);
	}
	else if ( IncomingMissile.IsA('UTProj_RaptorRocket') ) //@hack: FIXME: need a flag or something
	{
		SendLockOnMessage(4);
	}
	else
	{
		SendLockOnMessage(1);
	}
}

/** JumpOutCheck()
Check if bot wants to jump out of vehicle, which is currently descending towards its destination
*/
event JumpOutCheck()
{
	local UTBot B;

	B = UTBot(Controller);
	if ( (B != None) && (UTOnslaughtObjective(B.Movetarget) != None) && UTOnslaughtObjective(B.MoveTarget).IsNeutral() && ((B.Enemy == None) || !B.LineOfSightTo(B.Enemy)) )
	{
		DriverLeave(false);
		if ( Controller == None )
		{
			Mesh.AddImpulse( PushForce*Vector(Rotation), Location );
			if ( (B.Pawn.Physics == PHYS_Falling) && B.DoWaitForLanding() )
				B.Pawn.Velocity.Z = 0;
		}
	}
}

simulated function SetDriving(bool bNewDriving)
{
	if (bAutoLand && !bNewDriving && !bChassisTouchingGround && Health > 0)
	{
		if (Role == ROLE_Authority)
		{
			GotoState('AutoLanding');
		}
	}
	else
	{
		Super.SetDriving(bNewDriving);
	}
}

/** state to automatically land when player jumps out while high above land */
state AutoLanding
{
	simulated function SetDriving(bool bNewDriving)
	{
		if ( bNewDriving )
		{
			GotoState('Auto');
			Global.SetDriving(bNewDriving);
		}
	}

	function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
	{
		if (Global.Died(Killer, DamageType, HitLocation))
		{
			SetDriving(false);
			return true;
		}
		else
		{
			return false;
		}
	}

	function Tick(float DeltaTime)
	{
		local actor HitActor;
		local vector HitNormal, HitLocation;

		if (bChassisTouchingGround)
		{
			GotoState('Auto');
			SetDriving(false);
		}
		else
		{
			HitActor = Trace(HitLocation, HitNormal, Location - vect(0,0,2500), Location, false);
			if ( Velocity.Z < -1200 )
				OutputRise = 1.0;
			else if ( HitActor == None )
				OutputRise = -1.0;
			else if ( VSize(HitLocation - Location) < -2*Velocity.Z )
			{
				if ( Velocity.Z > -100 )
					OutputRise = 0;
				else
					OutputRise = 1.0;
			}
			else if ( Velocity.Z > -500 )
				OutputRise = -0.4;
			else
				OutputRise = -0.1;
		}
	}
}

//==============================
// AI interface
function bool RecommendLongRangedAttack()
{
	return true;
}

function bool FastVehicle()
{
	return true;
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	if ( FRand() < 0.7 )
	{
		VehicleMovingTime = WorldInfo.TimeSeconds + 1;
		Rise = 1;
	}
	return false;
}

defaultproperties
{
   ContrailColorParameterName="ContrailColor"
   bAutoLand=True
   bUseAlternatePaths=False
   bEjectPassengersWhenFlipped=False
   bMustBeUpright=False
   bDropDetailWhenDriving=True
   bFindGroundExit=False
   bHomingTarget=True
   bReducedFallingCollisionDamage=True
   bNoZDampingInAir=False
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHoverVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHoverVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   UpsideDownDamagePerSec=0.000000
   IconCoords=(U=989.000000,V=24.000000,UL=43.000000,VL=48.000000)
   LookForwardDist=100.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTHoverVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTAirVehicle:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTHoverVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTAirVehicle:MyStayUprightConstraintInstance'
   bTurnInPlace=True
   bFollowLookDir=True
   bCanFly=True
   bCanStrafe=True
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTHoverVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTHoverVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTHoverVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTHoverVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   CollisionComponent=SVehicleMesh
   Name="Default__UTAirVehicle"
   ObjectArchetype=UTHoverVehicle'UTGame.Default__UTHoverVehicle'
}
