/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTVehicle_Walker extends UTVehicle
	native(Vehicle)
	abstract;


enum EWalkerStance
{
	WalkerStance_None,
	WalkerStance_Standing,
	WalkerStance_Parked,
	WalkerStance_Crouched
};

var transient EWalkerStance CurrentStance;
var transient EWalkerStance PreviousStance;		// stance last frame

/** Suspension settings for each stance */
var() protected float WheelSuspensionTravel[EWalkerStance.EnumCount];

var array<MaterialInterface> PowerOrbTeamMaterials;
var array<MaterialInterface> PowerOrbBurnoutTeamMaterials;


var UTWalkerBody BodyActor;
var() RB_Handle BodyHandle;
var class<UTWalkerBody> BodyType;
var() protected const Name BodyAttachSocketName;

/** Offset to make sure leg traces start inside the walker collision volume */
var() vector LegTraceOffset;
/** How far up in Z should we start the FindGround check */
var() float LegTraceZUpAmount;

/** Interpolation speed (for RInterpTo) used for interpolating the rotation of the body handle */
var() float BodyHandleOrientInterpSpeed;

var		bool							bWasOnGround;
var		bool							bPreviousInAir;
var     bool                            bHoldingDuck;
var		bool							bAnimateDeadLegs;
var()   float   DuckForceMag;

var		float	InAirStart;
var		float	LandingFinishTime;

var()	vector	BaseBodyOffset;

/** Specifies offset to suspension travel to use for determining approximate distance to ground (takes into account suspension being loaded) */
var		float	HoverAdjust[EWalkerStance.EnumCount];

/** controls how fast to interpolate between various suspension heights */
var() protected float SuspensionTravelAdjustSpeed;

/** current Eyeheight desired offset because of stepping */
var float EyeStepOffset;

/** Max offset due to a step */
var() float MaxEyeStepOffset;

var() float EyeStepFadeRate;

var() float EyeStepBlendRate;

var transient bool bCurrentlyVisible;

var transient vector StoppedBeingVisibleLocation;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function PostBeginPlay()
{
	local vector X, Y, Z;

	Super.PostBeginPlay();

	// no spider body on server
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		GetAxes(Rotation, X,Y,Z);
		BodyActor = Spawn(BodyType, self,, Location+BaseBodyOffset.X*X+BaseBodyOffset.Y*Y+BaseBodyOffset.Z*Z);
		BodyActor.SetWalkerVehicle(self);
	}
}

simulated function UpdateShadowSettings(bool bWantShadow)
{
	Super.UpdateShadowSettings(bWantShadow);

	if (BodyActor != None)
	{
		BodyActor.UpdateShadowSettings(bWantShadow);
	}
}

simulated function BlowupVehicle()
{
	Super.BlowupVehicle();
	if ( BodyActor != None )
	{
		BodyHandle.ReleaseComponent();
		BodyActor.PlayDying();
		BodyActor.SkeletalMeshComponent.SetMaterial(0, Mesh.GetMaterial(0));
		BodyActor.SkeletalMeshComponent.SetMaterial(1, Mesh.GetMaterial(1));
	}
	if ( UTVehicleSimHover(SimObj) != None )
	{
		UTVehicleSimHover(SimObj).bDisableWheelsWhenOff = true;
	}
}

simulated function Destroyed()
{
	Super.Destroyed();
	if ( BodyActor != None )
	{
		if ( !bTearOff )
		{
			BodyActor.Destroy();
		}
		else if ( BodyActor.LifeSpan == 0 )
		{
			BodyActor.PlayDying();
		}
	}
}

/** notification from WalkerBody that foot just landed */
function TookStep(int LegIdx);

function bool DriverEnter(Pawn P)
{
	if ( !Super.DriverEnter(P) )
		return false;
	SetDriving(true);
	return true;
}


function DriverLeft()
{
	Super.DriverLeft();

	SetDriving(NumPassengers() > 0);
}

simulated function bool AllowLinkThroughOwnedActor(Actor OwnedActor)
{
	return (OwnedActor == BodyActor);
}

simulated function PlaySpawnEffect()
{
	Super.PlaySpawnEffect();
	if (BodyActor != None)
	{
		BodyActor.SkeletalMeshComponent.SetMaterial(0, Mesh.GetMaterial(0));
	}
}

simulated function StopSpawnEffect()
{
	Super.StopSpawnEffect();
	if (BodyActor != None)
	{
		BodyActor.SkeletalMeshComponent.SetMaterial(0, Mesh.GetMaterial(0));
	}
}

simulated function TeamChanged()
{
	Super.TeamChanged();
	if (BodyActor != None)
	{
		BodyActor.TeamChanged();
	}
}

simulated function SetBurnOut()
{
	if (BodyActor != None)
	{
		BodyActor.SetBurnOut();
	}

	// sets the MIC
	super.SetBurnOut();
}

defaultproperties
{
   Begin Object Class=RB_Handle Name=RB_BodyHandle ObjName=RB_BodyHandle Archetype=RB_Handle'Engine.Default__RB_Handle'
      LinearStiffness=4000.000000
      AngularStiffness=4000.000000
      Name="RB_BodyHandle"
      ObjectArchetype=RB_Handle'Engine.Default__RB_Handle'
   End Object
   BodyHandle=RB_BodyHandle
   BodyHandleOrientInterpSpeed=5.000000
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   CollisionDamageMult=0.000000
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_Walker:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_Walker:MyStayUprightConstraintInstance'
   bCanBeBaseForPawns=False
   BaseEyeHeight=300.000000
   EyeHeight=300.000000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=RB_BodyHandle
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Walker"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
