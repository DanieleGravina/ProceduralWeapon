/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_DarkWalker extends UTVehicle_Walker
	native(Vehicle)
	abstract;

var repnotify byte TurretFlashCount;
var repnotify rotator TurretWeaponRotation;
var byte TurretFiringMode;

var particleSystem BeamTemplate;

/** Holds the Emitter for the Beam */
var ParticleSystemComponent BeamEmitter[2];

/** Where to attach the Beam */
var name BeamSockets[2];

/** The name of the EndPoint parameter */
var name EndPointParamName;

var protected AudioComponent BeamAmbientSound;
var SoundCue BeamFireSound;

var float WarningConeMaxRadius;
var float LengthDarkWalkerWarningCone;
var AudioComponent WarningConeSound;
var name ConeParam;

var ParticleSystemComponent EffectEmitter;

var actor LastHitActor;

var bool bIsBeamActive;

/** radius to allow players under this darkwalker to gain entry */
var float CustomEntryRadius;

/** When asleep, monitor distance below darkwalker to make sure it isn't in the air. */
var float LastSleepCheckDistance;

/** Disable aggressive sleeping behaviour. */
var bool bSkipAggresiveSleep;

var float CustomGravityScaling;

/** @hack: replicated copy of bHoldingDuck for clients */
var bool bIsDucking;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

replication
{
	if (!bNetOwner)
		bIsDucking;
	if (!IsSeatControllerReplicationViewer(1) || bDemoRecording)
		TurretFlashCount, TurretWeaponRotation;
}

native simulated final function PlayWarningSoundIfInCone(Pawn Target);

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	AddBeamEmitter();
	SetTimer(1.0, TRUE, 'SleepCheckGroundDistance');
}

simulated event Destroyed()
{
	super.Destroyed();
	KillBeamEmitter();
	ClearTimer('SleepCheckGroundDistance');
}

simulated function SleepCheckGroundDistance()
{
	local vector HitLocation, HitNormal;
	local actor HitActor;
	local float SleepCheckDistance;

	bSkipAggresiveSleep = FALSE;

	if(!bDriving && !Mesh.RigidBodyIsAwake())
	{
		HitActor = Trace(HitLocation, HitNormal, Location - vect(0,0,1000), Location, TRUE);

		SleepCheckDistance = 1000.0;
		if(HitActor != None)
		{
			SleepCheckDistance = VSize(HitLocation - Location);
		}

		// If distance has changed, wake it
		if(Abs(SleepCheckDistance - LastSleepCheckDistance) > 10.0)
		{
			Mesh.WakeRigidBody();
			bSkipAggresiveSleep = TRUE;
			LastSleepCheckDistance = SleepCheckDistance;
		}
	}
}

simulated function AddBeamEmitter()
{
	local int i;
	if (WorldInfo.NetMode != NM_DedicatedServer)
	{
		for (i=0;i<2;i++)
		{
			if (BeamEmitter[i] == None)
			{
				if (BeamTemplate != None)
				{
					BeamEmitter[i] = new(Outer) class'UTParticleSystemComponent';
					BeamEmitter[i].SetTemplate(BeamTemplate);
					BeamEmitter[i].SecondsBeforeInactive=1.0f;
					BeamEmitter[i].SetHidden(true);
					Mesh.AttachComponentToSocket( BeamEmitter[i],BeamSockets[i] );
				}
			}
			else
			{
				BeamEmitter[i].ActivateSystem();
			}
		}
	}
}

simulated function KillBeamEmitter()
{
	local int i;
	for (i=0;i<2;i++)
	{
		if (BeamEmitter[i] != none)
		{
			//BeamEmitter[i].SetHidden(true);
			BeamEmitter[i].DeactivateSystem();
		}
	}
}

simulated function SetBeamEmitterHidden(bool bHide)
{
	local int i;

	if (bHide && EffectEmitter != None)
	{
		EffectEmitter.SetActive(false);
	}
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		if (bIsBeamActive != !bHide )
		{
			for (i=0; i<2; i++)
			{
					if (BeamEmitter[i] != none)
					{
						if(!bHide)
							BeamEmitter[i].SetHidden(bHide);
						else
							BeamEmitter[i].DeactivateSystem();
					}

					if (!bHide)
					{
						BeamAmbientSound.SoundCue = BeamFireSound;
						BeamAmbientSound.Play();
						BeamEmitter[i].ActivateSystem();
					}
					else
					{
						BeamAmbientSound.FadeOut(0.3f, 0.f);
					}
			}
		}
		bIsBeamActive = !bHide;
	}
}

/**
 * Detect the transition from vehicle to ground and vice versus and handle it
 */

simulated function actor FindWeaponHitNormal(out vector HitLocation, out Vector HitNormal, vector End, vector Start, out TraceHitInfo HitInfo)
{
	local Actor NewHitActor;

	NewHitActor = Super.FindWeaponHitNormal(HitLocation, HitNormal, End, Start, HitInfo);
	if (NewHitActor != LastHitActor && EffectEmitter != None)
	{
		EffectEmitter.SetActive(false);
	}
	LastHitActor = NewHitActor;
	return NewHitActor;
}


simulated function SpawnImpactEmitter(vector HitLocation, vector HitNormal, const out MaterialImpactEffect ImpactEffect, int SeatIndex)
{
	local rotator TmpRot;

	TmpRot = rotator(HitNormal);
	TmpRot.Pitch = NormalizeRotAxis(TmpRot.Pitch - 16384);

	if (EffectEmitter == None)
	{
		EffectEmitter = new(self) class'ParticleSystemComponent';
		EffectEmitter.SetTemplate(ImpactEffect.ParticleTemplate);
		EffectEmitter.SetAbsolute(true, true, true);
		EffectEmitter.SetScale(0.7);
		AttachComponent(EffectEmitter);
	}

	EffectEmitter.SetTranslation(HitLocation);
	EffectEmitter.SetRotation(TmpRot);
	EffectEmitter.SetActive(true);
}

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local int i;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	if ( SeatIndex == 0 )
	{
		SetBeamEmitterHidden(false);
		for(i=0;i<2;i++)
		{
			BeamEmitter[i].SetVectorParameter(EndPointParamName, HitLocation);
		}
	}
}

simulated function VehicleWeaponStoppedFiring( bool bViaReplication, int SeatIndex )
{
	if (SeatIndex == 0)
	{
		SetBeamEmitterHidden(true);
	}
}

/** notification from WalkerBody that foot just landed */
function TookStep(int LegIdx)
{
	EyeStepOffset = MaxEyeStepOffset * FMin(1.0,VSize(Velocity)/AirSpeed);
}

function PassengerLeave(int SeatIndex)
{
	Super.PassengerLeave(SeatIndex);

	SetDriving(NumPassengers() > 0);
}

function bool PassengerEnter(Pawn P, int SeatIndex)
{
	local bool b;

	b = Super.PassengerEnter(P, SeatIndex);
	SetDriving(NumPassengers() > 0);
	return b;
}

simulated function VehicleCalcCamera(float DeltaTime, int SeatIndex, out vector out_CamLoc, out rotator out_CamRot, out vector CamStart, optional bool bPivotOnly)
{
	local UTPawn P;

	if (SeatIndex == 1)
	{
		// Handle the fixed view
		P = UTPawn(Seats[SeatIndex].SeatPawn.Driver);
		if (P != None && P.bFixedView)
		{
			out_CamLoc = P.FixedViewLoc;
			out_CamRot = P.FixedViewRot;
			return;
		}

		out_CamLoc = GetCameraStart(SeatIndex);
		CamStart = out_CamLoc;
		out_CamRot = Seats[SeatIndex].SeatPawn.GetViewRotation();
		return;
	}

	Super.VehicleCalcCamera(DeltaTime, SeatIndex, out_CamLoc, out_CamRot, CamStart, bPivotOnly);
}


/**
*  Overloading this from SVehicle to avoid torquing the walker head.
*/
function AddVelocity( vector NewVelocity, vector HitLocation, class<DamageType> DamageType, optional TraceHitInfo HitInfo )
{
	// apply hit at location, not hitlocation
	Super.AddVelocity(NewVelocity, Location, DamageType, HitInfo);
}

/**
  * Let pawns standing under me get in, if I have a driver.
  */
function bool InCustomEntryRadius(Pawn P)
{
	return ( (P.Location.Z < Location.Z) && (VSize2D(P.Location - Location) < CustomEntryRadius)
		&& FastTrace(P.Location, Location) );
}

event WalkerDuckEffect();

simulated function BlowupVehicle()
{
	local vector Impulse;
	Super.BlowupVehicle();
	Impulse = Velocity; //LastTakeHitInfo;
	Impulse.Z = 0;
	if(IsZero(Impulse))
	{
		Impulse = vector(Rotation); // forward if no velocity.
	}
	Impulse *= 4000/VSize(Impulse);
	Mesh.SetRBLinearVelocity(Impulse);
	Mesh.SetRBAngularVelocity(VRand()*5, true);
	bStayUpright = false;
	bCanFlip=true;
}

simulated function bool ShouldClamp()
{
	return false;
}

//=================================
// AI Interface

function bool ImportantVehicle()
{
	return true;
}

function bool RecommendLongRangedAttack()
{
	return true;
}

defaultproperties
{
   LengthDarkWalkerWarningCone=7500.000000
   CustomEntryRadius=300.000000
   CustomGravityScaling=0.900000
   WheelSuspensionTravel(1)=600.000000
   WheelSuspensionTravel(3)=153.000000
   Begin Object Class=RB_Handle Name=RB_BodyHandle ObjName=RB_BodyHandle Archetype=RB_Handle'UTGame.Default__UTVehicle_Walker:RB_BodyHandle'
      LinearStiffness=99000.000000
      AngularDamping=100.000000
      AngularStiffness=99000.000000
      ObjectArchetype=RB_Handle'UTGame.Default__UTVehicle_Walker:RB_BodyHandle'
   End Object
   BodyHandle=RB_BodyHandle
   LegTraceZUpAmount=700.000000
   HoverAdjust(1)=-280.000000
   HoverAdjust(3)=-63.000000
   SuspensionTravelAdjustSpeed=250.000000
   MaxEyeStepOffset=48.000000
   EyeStepFadeRate=2.000000
   EyeStepBlendRate=2.000000
   bHasCustomEntryRadius=True
   bShouldAutoCenterViewPitch=False
   bFindGroundExit=False
   bIsNecrisVehicle=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Walker:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle_Walker:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   RespawnTime=45.000000
   MaxDesireability=1.250000
   ObjectiveGetOutDist=750.000000
   HornIndex=3
   VehicleIndex=1
   VehiclePositionString="In un Darkwalker"
   VehicleNameString="Darkwalker"
   NeedToPickUpAnnouncement=(AnnouncementText="Equipaggia il Darkwalker")
   HUDExtent=250.000000
   SpawnRadius=125.000000
   ChargeBarPosX=3.000000
   ChargeBarPosY=4.000000
   TeamBeaconOffset=(X=0.000000,Y=0.000000,Z=350.000000)
   LookForwardDist=40.000000
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   ExtraReachDownThreshold=450.000000
   HeroBonus=2.000000
   GreedCoinBonus=6
   Begin Object Class=UTVehicleSimHover Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
      bDisableWheelsWhenOff=False
      bCanClimbSlopes=True
      MaxThrustForce=600.000000
      MaxReverseForce=600.000000
      LongDamping=0.300000
      MaxStrafeForce=600.000000
      LatDamping=0.300000
      TurnTorqueFactor=9000.000000
      TurnTorqueMax=10000.000000
      TurnDamping=3.000000
      MaxYawRate=1.600000
      PitchTorqueMax=35.000000
      PitchDamping=0.100000
      RollTorqueMax=50.000000
      RollDamping=0.100000
      RandForceInterval=1000.000000
      bFullThrustOnDirectionChange=True
      bStabilizeStops=True
      HardLimitAirSpeedScale=1.500000
      WheelSuspensionStiffness=100.000000
      WheelSuspensionDamping=40.000000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimHover'UTGame.Default__UTVehicleSimHover'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=RThruster ObjName=RThruster Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bCollidesVehicles=False
      SteerFactor=1.000000
      BoneName="BodyRoot"
      BoneOffset=(X=0.000000,Y=0.000000,Z=-20.000000)
      WheelRadius=70.000000
      SuspensionTravel=20.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="RThruster"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(0)=RThruster
   COMOffset=(X=0.000000,Y=0.000000,Z=150.000000)
   bStayUpright=True
   bUseSuspensionAxis=True
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup_13 ObjName=MyStayUprightSetup_13 Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Walker:MyStayUprightSetup'
      Name="MyStayUprightSetup_13"
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle_Walker:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGame.Default__UTVehicle_DarkWalker:MyStayUprightSetup_13'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance_13 ObjName=MyStayUprightConstraintInstance_13 Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Walker:MyStayUprightConstraintInstance'
      Name="MyStayUprightConstraintInstance_13"
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle_Walker:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGame.Default__UTVehicle_DarkWalker:MyStayUprightConstraintInstance_13'
   bTurnInPlace=True
   bFollowLookDir=True
   bDuckObstacles=True
   bIgnoreStallZ=True
   bCanStrafe=True
   MeleeRange=-100.000000
   GroundSpeed=350.000000
   AirSpeed=350.000000
   BaseEyeHeight=0.000000
   EyeHeight=0.000000
   Health=1000
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Walker:SVehicleMesh'
      RBCollideWithChannels=(Untitled1=True)
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle_Walker:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle_Walker:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle_Walker:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=RB_BodyHandle
   Components(4)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_DarkWalker"
   ObjectArchetype=UTVehicle_Walker'UTGame.Default__UTVehicle_Walker'
}
