/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTVehicle_Cicada extends UTAirVehicle
	native(Vehicle)
	abstract;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var repnotify vector TurretFlashLocation;
var repnotify rotator TurretWeaponRotation;
var	repnotify byte TurretFlashCount;
var repnotify byte TurretFiringMode;


var bool bFreelanceStart;

var array<int> JetEffectIndices;

var ParticleSystem TurretBeamTemplate;

var UTSkelControl_JetThruster JetControl;

var name JetScalingParam;

replication
{
	if (bNetDirty)
		TurretFlashLocation;

	if (!IsSeatControllerReplicationViewer(1) || bDemoRecording)
		TurretFlashCount, TurretFiringMode, TurretWeaponRotation;
}

simulated event RigidBodyCollision( PrimitiveComponent HitComponent, PrimitiveComponent OtherComponent,
					const out CollisionImpactData RigidCollisionData, int ContactIndex )
{
	Super.RigidBodyCollision(HitComponent, OtherComponent, RigidCollisionData, ContactIndex);
	if(!IsTimerActive('ResetTurningSpeed'))
	{
		SetTimer(0.7f,false,'ResetTurningSpeed');
		MaxSpeed = default.MaxSpeed/2.0;
		MaxAngularVelocity = default.MaxAngularVelocity/4.0;
		if( UTVehicleSimChopper(SimObj) != none)
			UTVehicleSimChopper(SimObj).bRecentlyHit = true;
		//UTVehicleSimChopper(SimObj).TurnDamping = 0.8;
	}
}

simulated function ResetTurningSpeed()
{ // this is safe since this only gets called above after checking SimObj is a chopper.
	MaxSpeed = default.MaxSpeed;
	MaxAngularVelocity = default.MaxAngularVelocity;
	if( UTVehicleSimChopper(SimObj) != none)
		UTVehicleSimChopper(SimObj).bRecentlyHit = false;

	//UTVehicleSimChopper(SimObj).TurnDamping = UTVehicleSimChopper(default.SimObj).TurnDamping;
}
// AI hint
function bool ImportantVehicle()
{
	return !bFreelanceStart;
}

function bool DriverEnter(Pawn P)
{
	local UTBot B;

	if ( !Super.DriverEnter(P) )
		return false;

	B = UTBot(Controller);
	bFreelanceStart = (B != None && B.Squad != None && B.Squad.bFreelance && !UTOnslaughtTeamAI(B.Squad.Team.AI).bAllNodesTaken);
	return true;
}

function DriverLeft()
{
	Super.DriverLeft();

	SetDriving(NumPassengers() > 0);
}

function PassengerLeave(int SeatIndex)
{
	Super.PassengerLeave(SeatIndex);

	SetDriving(NumPassengers() > 0);
}

function bool PassengerEnter(Pawn P, int SeatIndex)
{
	if ( !Super.PassengerEnter(P, SeatIndex) )
		return false;

	SetDriving(true);
	return true;
}

//Switching seats during altfire doesn't replicate because
//bDriving is the same at the end of the tick as the beginning.  Tell the client
//to stop firing the weapon it left behind
simulated function SitDriver( UTPawn UTP, int SeatIndex)
{
	if (Role<ROLE_Authority && SeatIndex == 1)
	{
		Seats[0].Gun.ForceEndFire();
	}

	Super.SitDriver(UTP, SeatIndex);
}


/* FIXME:
function Vehicle FindEntryVehicle(Pawn P)
{
	local Bot B, S;

	B = Bot(P.Controller);
	if ( (B == None) || !IsVehicleEmpty() || (WeaponPawns[0].Driver != None) )
		return Super.FindEntryVehicle(P);

	for ( S=B.Squad.SquadMembers; S!=None; S=S.NextSquadMember )
	{
		if ( (S != B) && (S.RouteGoal == self) && S.InLatentExecution(S.LATENT_MOVETOWARD)
			&& ((S.MoveTarget == self) || (Pawn(S.MoveTarget) == None)) )
			return WeaponPawns[0];
	}
	return Super.FindEntryVehicle(P);
}
*/

function bool RecommendLongRangedAttack()
{
	return true;
}

/* FIXME:
function float RangedAttackTime()
{
	local ONSDualACSideGun G;

	G = ONSDualACSideGun(Weapons[0]);
	if ( G.LoadedShotCount > 0 )
		return (0.05 + (G.MaxShotCount - G.LoadedShotCount) * G.FireInterval);
	return 1;
}
*/

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local ParticleSystemComponent E;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	if (SeatIndex == 1 && !IsZero(HitLocation))
	{
		E = WorldInfo.MyEmitterPool.SpawnEmitter(TurretBeamTemplate, GetEffectLocation(SeatIndex));
		E.SetVectorParameter('ShockBeamEnd', HitLocation);
	}
}

/**
 * We override GetCameraStart for the Belly Turret so that it just uses the Socket Location
 */
simulated function vector GetCameraStart(int SeatIndex)
{
	local vector CamStart;

	if (SeatIndex == 1 && Seats[SeatIndex].CameraTag != '')
	{
		if (Mesh.GetSocketWorldLocationAndRotation(Seats[SeatIndex].CameraTag, CamStart) )
		{
			return CamStart;
		}
	}

	return Super.GetCameraStart(SeatIndex);
}

/**
 * We override VehicleCalcCamera for the Belly Turret so that it just uses the Socket Location
 */
simulated function VehicleCalcCamera(float DeltaTime, int SeatIndex, out vector out_CamLoc, out rotator out_CamRot, out vector CamStart, optional bool bPivotOnly)
{
	if (SeatIndex == 1)
	{
		out_CamLoc = GetCameraStart(SeatIndex);
		out_CamRot = Seats[SeatIndex].SeatPawn.GetViewRotation();
	CamStart = out_CamLoc;
	}
	else
	{
		Super.VehicleCalcCamera(DeltaTime, SeatIndex, out_CamLoc, out_CamRot, CamStart, bPivotOnly);
	}
}

simulated function bool ShouldClamp()
{
	return false;
}

defaultproperties
{
   PushForce=50000.000000
   bOverrideAVRiLLocks=True
   bLimitCameraZLookingUp=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAirVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTAirVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   VehicleIndex=0
   VehiclePositionString="In un Cicada"
   VehicleNameString="Cicada"
   HUDExtent=140.000000
   SpawnRadius=180.000000
   CameraLag=0.050000
   LookForwardDist=290.000000
   Begin Object Class=UTVehicleSimChopper Name=SimObject ObjName=SimObject Archetype=UTVehicleSimChopper'UTGame.Default__UTVehicleSimChopper'
      MaxThrustForce=700.000000
      MaxReverseForce=700.000000
      LongDamping=0.600000
      MaxStrafeForce=680.000000
      LatDamping=0.700000
      MaxRiseForce=1000.000000
      UpDamping=0.700000
      TurnTorqueFactor=7000.000000
      TurnTorqueMax=10000.000000
      TurnDamping=1.200000
      MaxYawRate=1.800000
      PitchTorqueFactor=450.000000
      PitchTorqueMax=60.000000
      PitchDamping=0.300000
      RollTorqueTurnFactor=700.000000
      RollTorqueStrafeFactor=100.000000
      RollTorqueMax=300.000000
      RollDamping=0.100000
      StopThreshold=100.000000
      MaxRandForce=30.000000
      RandForceInterval=0.500000
      bShouldCutThrustMaxOnImpact=True
      Name="SimObject"
      ObjectArchetype=UTVehicleSimChopper'UTGame.Default__UTVehicleSimChopper'
   End Object
   SimObj=SimObject
   COMOffset=(X=-40.000000,Y=0.000000,Z=-50.000000)
   bStayUpright=True
   StayUprightRollResistAngle=5.000000
   StayUprightPitchResistAngle=5.000000
   StayUprightStiffness=1200.000000
   StayUprightDamping=20.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_0 ObjName=MyStayUprightSetup_0 Archetype=RB_StayUprightSetup'UTGame.Default__UTAirVehicle:MyStayUprightSetup'
      Name="MyStayUprightSetup_0"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTAirVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Cicada:MyStayUprightSetup_0'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_0 ObjName=MyStayUprightConstraintInstance_0 Archetype=RB_ConstraintInstance'UTGame.Default__UTAirVehicle:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_0"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTAirVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Cicada:MyStayUprightConstraintInstance_0'
   UprightLiftStrength=30.000000
   UprightTorqueStrength=30.000000
   GroundSpeed=1600.000000
   AirSpeed=2000.000000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTAirVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTAirVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTAirVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTAirVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Cicada"
   ObjectArchetype=UTAirVehicle'UTGame.Default__UTAirVehicle'
}
