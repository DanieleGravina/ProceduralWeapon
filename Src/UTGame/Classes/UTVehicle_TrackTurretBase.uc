/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_TrackTurretBase extends UTVehicle
	native(Vehicle)
	abstract;

var AudioComponent TurretMoveStart;
var AudioComponent TurretMoveLoop;
var AudioComponent TurretMoveStop;

/** Is true if this turret is in motion */
var bool bInMotion;

/** last bounding box of our Mesh. This is used to check encroachment when the turret animates so that players don't get stuck
 * if the animation moves a part of the turret on top of them
 */
var Box LastBoundingBox;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function AttachFlag(UTCarriedObject FlagActor, Pawn NewDriver)
{
	if ( UTOnslaughtFlag(FlagActor) == None )
	{
		// CTF flag needs different offset
		FlagOffset.X = 50;
		FlagOffset.Z = 20;
		FlagRotation.Yaw = 49152;
		FlagRotation.Roll = 16384;
	}
	super.AttachFlag(FlagActor, NewDriver);
}

/**
 * When an icon for this vehicle is needed on the hud, this function is called
 */
simulated function RenderMapIcon(UTMapInfo MP, Canvas Canvas, UTPlayerController PlayerOwner, LinearColor FinalColor)
{
	local Rotator VehicleRotation;
	VehicleRotation = (Controller != None) ? Controller.Rotation : Rotation;
	MP.DrawRotatedTile(Canvas, Class'UTHUD'.default.IconHudTexture, HUDLocation, VehicleRotation.Yaw + 32767, MapSize, IconCoords, FinalColor);
}

/**
 * Notify Kismet that the turret has died
 */
function bool Died(Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
	local UTVehicleFactory_TrackTurretBase PFacWhileDying;

	PFacWhileDying = UTVehicleFactory_TrackTurretBase(ParentFactory); // cache this before super.died sets it to none
	if (Super.Died(Killer, DamageType, HitLocation))
	{
		if (Role == ROLE_Authority && PFacWhileDying != none)
		{

			SetBase( None );
			SetHardAttach(false);
			PFacWhileDying.TriggerEventClass(class'UTSeqEvent_TurretStatusChanged', PFacWhileDying, 1);
			PFacWhileDying.TurretDeathReset();
		}
		return true;
	}
	else
	{
		return false;
	}
}

/**
 * Notify Kismet that the drive left
 */
function DriverLeft()
{
	Super.DriverLeft();

	ParentFactory.TriggerEventClass(class'UTSeqEvent_TurretStatusChanged', ParentFactory, 3);

	// Set the move back to start time
	ResetTime = WorldInfo.TimeSeconds + 30;
	UTVehicleFactory_TrackTurretBase(ParentFactory).ForceTurretStop();
}

event CheckReset()
{
	local controller C;

	// If we are occupied, don't reset
	if ( Occupied() )
	{
		ResetTime = WorldInfo.TimeSeconds - 1;
		return;
	}

	// If someone is close, don't reset

	foreach WorldInfo.AllControllers(class'Controller', C)
	{
		if ( (C.Pawn != None) && WorldInfo.GRI.OnSameTeam(C,self) && (VSize(Location - C.Pawn.Location) < 512) && FastTrace(C.Pawn.Location + C.Pawn.GetCollisionHeight() * vect(0,0,1), Location + GetCollisionHeight() * vect(0,0,1)) )
		{
			ResetTime = WorldInfo.TimeSeconds + 10;
			return;
		}
	}

	UTVehicleFactory_TrackTurretBase(ParentFactory).ResetTurret();
}

function SetTeamNum(byte T)
{
	if (Controller != None && Controller.GetTeamNum() != T)
	{
		DriverLeave(true);
	}

	// restore health and return to initial position when changing hands
	if (T != GetTeamNum())
	{
		Health = HealthMax;
		if (UTVehicleFactory_TrackTurretBase(ParentFactory) != None)
		{
			UTVehicleFactory_TrackTurretBase(ParentFactory).ResetTurret();
		}
	}

	Super.SetTeamNum(T);
}

/**
 * Notify Kismet that someone has entered
 */
function bool DriverEnter(Pawn P)
{
	if (Super.DriverEnter(P))
	{
		ParentFactory.TriggerEventClass(class'UTSeqEvent_TurretStatusChanged', ParentFactory, 2);
		return true;
	}
	else
	{
		return false;
	}
}

/** @return rotation used for determining valid exit positions */
function rotator ExitRotation()
{
	return (Controller != None) ? Controller.Rotation : Rotation;
}

simulated function bool ShouldClamp()
{
	return false;
}

defaultproperties
{
   bCanCarryFlag=True
   bEnteringUnlocks=False
   bEjectKilledBodies=True
   bCameraNeverHidesVehicle=True
   AIPurpose=AIP_Defensive
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   ExplosionDamage=0.000000
   IconCoords=(U=895.000000,V=0.000000,UL=23.000000,VL=34.000000)
   CameraLag=0.050000
   LookForwardDist=150.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_TrackTurretBase:MyStayUprightConstraintInstance'
   bTurnInPlace=True
   bFollowLookDir=True
   TargetLocationAdjustment=(X=0.000000,Y=0.000000,Z=45.000000)
   bCanStrafe=True
   BaseEyeHeight=0.000000
   EyeHeight=0.000000
   Health=400
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   ViewPitchMin=-15473.000000
   ViewPitchMax=15473.000000
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Physics=PHYS_None
   bIgnoreEncroachers=True
   bHardAttach=True
   bCollideWorld=False
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_TrackTurretBase"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
