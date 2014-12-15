/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTWalkerBody extends Actor
	native(Vehicle)
	abstract
	notplaceable;

// 3 legged walkers, by default
const NUM_WALKER_LEGS = 3;

enum EWalkerLegID
{
	WalkerLeg_Rear,
	WalkerLeg_FrontLeft,
	WalkerLeg_FrontRight
};

/** Skel mesh for the legs. */
var() /*const*/ editconst SkeletalMeshComponent	SkeletalMeshComponent;

/** Refs to shoulder lookat skelcontrols for each leg  */
var protected transient SkelControlLookat ShoulderSkelControl[NUM_WALKER_LEGS];
/** Names for the shoulder skelcontrol nodes for each leg (from the animtree) */
var protected const Name ShoulderSkelControlName[NUM_WALKER_LEGS];

/** If TRUE for corresponding foot, walking/stepping code will ignore that leg */
var() byte IgnoreFoot[NUM_WALKER_LEGS];

/** Handles used to move the walker feet around. */
var() UTWalkerStepHandle FootConstraints[NUM_WALKER_LEGS];

/** world time to advance to the next phase of the step - experimental walker leg code */
var float NextStepStageTime[NUM_WALKER_LEGS];

/** Time, in seconds, that each step stage lasts. */
var() const array<float> StepStageTimes;

/** which stage the step is in for each leg - experimental walker leg code */
var protected int StepStage[NUM_WALKER_LEGS];

/** used to play water effects when feet enter/exit water */
var byte FootInWater[NUM_WALKER_LEGS];
var ParticleSystem FootWaterEffect;

/** Min dist trigger to make foot a possible candidate for next step */
var() float MinStepDist;

/** Max leg extension */
var() float MaxLegReach;

/** Factor in range [0..1].  0 means no leg spread, 1 means legs are spread as far as possible. */
var() float LegSpreadFactor;
var() float	CustomGravityScale;
var() float LandedFootDistSq;

/** How far foot should embed into ground. */
var() protected const float FootEmbedDistance;


/** Bone names for this walker */
var const name FootBoneName[NUM_WALKER_LEGS];
var const name ShoulderBoneName[NUM_WALKER_LEGS];
var const name BodyBoneName;

/** Ref to the walker vehicle that we are attached to. */
var transient UTVehicle_Walker	WalkerVehicle;

var protected const bool	bHasCrouchMode;
var	bool					bIsDead;

/** Where the feet are right now */
var vector CurrentFootPosition[NUM_WALKER_LEGS];

var array<MaterialImpactEffect> FootStepEffects;
var ParticleSystemComponent FootStepParticles[NUM_WALKER_LEGS];

/** Store indices into the legs array, used to map from rear/left/right leg designations to the model's leg indices.  Indexed by LegID. */
var transient int LegMapping[EWalkerLegID.EnumCount];

/** Base directions from the walker center for the legs to point, in walker-local space.  Indexed by LegID. */
var protected const vector BaseLegDirLocal[EWalkerLegID.EnumCount];

/**
 * Scalar to control how much velocity to add to the desired foot positions.  Indexed by LegID.
 * This effectively controls how far ahead of the walker the legs will try to reach while the walker
 * is moving.
 */
var() const float FootPosVelAdjScale[EWalkerLegID.EnumCount];

/** Names of the anim nodes for playing the step anim for a leg.  Used to fill in FootStepAnimNode array. */
var protected const Name	FootStepAnimNodeName[NUM_WALKER_LEGS];
/** Refs to AnimNodes used for playing step animations */
var protected AnimNode		FootStepAnimNode[NUM_WALKER_LEGS];

/** How far above the current foot position to begin interpolating towards. */
var() protected const float FootStepStartLift;
/** How far above the desired foot position to end the foot step interpolation */
var() protected const float FootStepEndLift;

struct native WalkerLegStepAnimData
{
	/** Where foot wants to be. */
	var vector				DesiredFootPosition;

	/** Normal of the surface at the desired foot position. */
	var vector				DesiredFootPosNormal;

	/** Physical material at the DesiredFootPosition */
	var PhysicalMaterial	DesiredFootPosPhysMaterial;

	/** True if we don't have a valid desired foot position for this leg. */
	var bool				bNoValidFootHold;
};

/** Indexed by LegID. */
var protected WalkerLegStepAnimData StepAnimData[EWalkerLegID.EnumCount];

/** keeps track of previous leg locations */
var protected vector PreviousTraceSeedLocation[NUM_WALKER_LEGS];

/** The walker legs's light environment */
var DynamicLightEnvironmentComponent LegLightEnvironment;

var float MaxFootStepEffectDist;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

function PostBeginPlay()
{
	local int Idx;

	super.PostBeginPlay();

	// make sure the rb is awake
	SkeletalMeshComponent.WakeRigidBody();

	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		// cache refs to footstep anims
		FootStepAnimNode[Idx] = SkeletalMeshComponent.FindAnimNode(FootStepAnimNodeName[Idx]);

		// cache refs to skel controls
		ShoulderSkelControl[Idx] = SkelControlLookAt(SkeletalMeshComponent.FindSkelControl(ShoulderSkelControlName[Idx]));
		if (ShoulderSkelControl[Idx] != None)
		{
			// turn it on
			ShoulderSkelControl[Idx].SetSkelControlActive(TRUE);
		}
	}
}

simulated function UpdateShadowSettings(bool bWantShadow)
{
	local bool bNewCastShadow, bNewCastDynamicShadow;

	if (SkeletalMeshComponent != None)
	{
		bNewCastShadow = default.SkeletalMeshComponent.CastShadow && bWantShadow;
		bNewCastDynamicShadow = default.SkeletalMeshComponent.bCastDynamicShadow && bWantShadow;
		if (bNewCastShadow != SkeletalMeshComponent.CastShadow || bNewCastDynamicShadow != SkeletalMeshComponent.bCastDynamicShadow)
		{
			SkeletalMeshComponent.CastShadow = bNewCastShadow;
			SkeletalMeshComponent.bCastDynamicShadow = bNewCastDynamicShadow;
			// defer if we can do so without it being noticeable
			if (LastRenderTime < WorldInfo.TimeSeconds - 1.0)
			{
				SetTimer(0.1 + FRand() * 0.5, false, 'ReattachMesh');
			}
			else
			{
				ReattachMesh();
			}
		}
	}
}

/** reattaches the mesh component, because settings were updated */
simulated function ReattachMesh()
{
	DetachComponent(SkeletalMeshComponent);
	AttachComponent(SkeletalMeshComponent);
}

/* epic ===============================================
* ::StopsProjectile()
*
* returns true if Projectiles should call ProcessTouch() when they touch this actor
*/
simulated function bool StopsProjectile(Projectile P)
{
	// Don't block projectiles fired from this vehicle
	return (P.Instigator != WalkerVehicle) && (bProjTarget || bBlockActors);
}

/** Called once to set up legs. */
native function InitFeet();

/** Called on landing to reestablish a foothold */
native function InitFeetOnLanding();

function SetWalkerVehicle(UTVehicle_Walker V)
{
	WalkerVehicle = V;
	SkeletalMeshComponent.SetShadowParent(WalkerVehicle.Mesh);
	SkeletalMeshComponent.SetLightEnvironment(LegLightEnvironment);
	InitFeet();
}

event PlayFootStep(int LegIdx)
{
	local AudioComponent AC;
	local UTPhysicalMaterialProperty PhysicalProperty;
	local int EffectIndex;

	local vector HitLoc,HitNorm,TraceLength;
	local TraceHitInfo HitInfo;

	if (FootStepEffects.Length == 0)
	{
		return;
	}

	// figure out what we landed on

	TraceLength = vector(QuatToRotator(SkeletalMeshComponent.GetBoneQuaternion(FootBoneName[LegIdx])))*5.0;
	//Trace(HitLoc,HitNorm, CurrentFootPosition[LegIdx]+TraceLength,CurrentFootPosition[LegIdx],true,,HitInfo);
	Trace(HitLoc,HitNorm, CurrentFootPosition[LegIdx]-TraceLength,CurrentFootPosition[LegIdx]-TraceLength*4.0,true,,HitInfo);
	if(HitInfo.PhysMaterial != none)
	{
		PhysicalProperty = UTPhysicalMaterialProperty(HitInfo.PhysMaterial.GetPhysicalMaterialProperty(class'UTPhysicalMaterialProperty')); //(StepAnimData[LegIdx].DesiredFootPosPhysMaterial.GetPhysicalMaterialProperty(class'UTPhysicalMaterialProperty'));
	}
	if (PhysicalProperty != None)
	{
		EffectIndex = FootStepEffects.Find('MaterialType', PhysicalProperty.MaterialType);
		if (EffectIndex == INDEX_NONE)
		{
			EffectIndex = 0;
		}
		// Footstep particle
		if (FootStepEffects[EffectIndex].ParticleTemplate != None && EffectIsRelevant(Location, false))
		{
			if (FootStepParticles[LegIdx] == None)
			{
				FootStepParticles[LegIdx] = new(self) class'UTParticleSystemComponent';
				FootStepParticles[LegIdx].bAutoActivate = false;
				SkeletalMeshComponent.AttachComponent(FootStepParticles[LegIdx], FootBoneName[LegIdx]);
			}
			FootStepParticles[LegIdx].SetTemplate(FootStepEffects[EffectIndex].ParticleTemplate);
			FootStepParticles[LegIdx].ActivateSystem();
		}
	}

	AC = WorldInfo.CreateAudioComponent(FootStepEffects[EffectIndex].Sound, false, true);
	if (AC != None)
	{
		AC.bUseOwnerLocation = false;

		// play it closer to the player if he's controlling the walker
		AC.Location = (PlayerController(WalkerVehicle.Controller) != None) ? 0.5 * (Location + CurrentFootPosition[LegIdx]) : CurrentFootPosition[LegIdx];

		AC.bAutoDestroy = true;
		AC.Play();
	}
	WalkerVehicle.TookStep(LegIdx);
}

event SpawnFootWaterEffect(int LegIdx)
{
	if (FootWaterEffect != None)
	{
		WorldInfo.MyEmitterPool.SpawnEmitter(FootWaterEffect, CurrentFootPosition[LegIdx]);
	}
}

/**
 * Default behavior when shot is to apply an impulse and kick the KActor.
 */
event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local vector ApplyImpulse;

	if (damageType.default.KDamageImpulse > 0 )
	{
		if ( VSize(momentum) < 0.001 )
		{
			LogInternal("Zero momentum to KActor.TakeDamage");
			return;
		}

		// Make sure we have a valid TraceHitInfo with our SkeletalMesh
		// we need a bone to apply proper impulse
		CheckHitInfo( HitInfo, SkeletalMeshComponent, Normal(Momentum), hitlocation );

		ApplyImpulse = Normal(momentum) * damageType.default.KDamageImpulse;
		if ( HitInfo.HitComponent != None )
		{
			HitInfo.HitComponent.AddImpulse(ApplyImpulse, HitLocation, HitInfo.BoneName);
		}
	}
}

function PlayDying()
{
	local int i;

	Lifespan = 8.0;
	CustomGravityScale = 1.5;
	bCollideWorld = true;
	bIsDead = true;

	// clear all constraints
	for ( i=0; i<3; i++ )
	{
		FootConstraints[i].ReleaseComponent();
	}

	SkeletalMeshComponent.SetTraceBlocking(true, false);
	SkeletalMeshComponent.SetBlockRigidBody(true);
	SkeletalMeshComponent.SetShadowParent(None);
	GotoState('DyingVehicle');
}

function AddVelocity( vector NewVelocity, vector HitLocation,class<DamageType> DamageType, optional TraceHitInfo HitInfo )
{
	if ( !IsZero(NewVelocity) )
	{
		if (Location.Z > WorldInfo.StallZ)
		{
			NewVelocity.Z = FMin(NewVelocity.Z, 0);
		}
		NewVelocity = DamageType.Default.VehicleMomentumScaling * DamageType.Default.KDamageImpulse * Normal(NewVelocity);
		SkeletalMeshComponent.AddImpulse(NewVelocity, HitLocation);
	}
}

state DyingVehicle
{
	event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
	{
		if ( DamageType == None )
			return;
		AddVelocity(Momentum, HitLocation, DamageType, HitInfo);
	}
}

/** cause a single step, used for debugging */
native function DoTestStep(int LegIdx, float Mag);

/** NOTE:  this is actually what changes the colors on the PowerOrb on the legs of the Walker **/
simulated function TeamChanged()
{
	local MaterialInterface NewMaterial;

	NewMaterial = WalkerVehicle.Mesh.GetMaterial(0);
	SkeletalMeshComponent.SetMaterial( 0, NewMaterial );

	NewMaterial = WalkerVehicle.Mesh.GetMaterial(1);
	SkeletalMeshComponent.SetMaterial( 1, NewMaterial );
}


/** NOTE:  this is actually what changes the colors on the PowerOrb on the legs of the Walker **/
simulated function SetBurnOut()
{
	local int TeamNum;
	local BurnOutDatum BOD;
	local MaterialInterface NewMaterial;

	TeamNum = WalkerVehicle.GetTeamNum();

	// we use the walker in DM maps where the team will be 255
	if( WalkerVehicle.PowerOrbBurnoutTeamMaterials.length < TeamNum )
	{
		TeamNum = 0;
	}

	// set our specific turret BurnOut Material
	if( ( WalkerVehicle.PowerOrbBurnoutTeamMaterials.length > 0 ) && ( WalkerVehicle.PowerOrbBurnoutTeamMaterials[TeamNum] != None ) )
	{
		NewMaterial = WalkerVehicle.PowerOrbBurnoutTeamMaterials[TeamNum];
		WalkerVehicle.Mesh.SetMaterial( 1, NewMaterial );
		BOD.MITV = WalkerVehicle.Mesh.CreateAndSetMaterialInstanceTimeVarying(1);
		WalkerVehicle.BurnOutMaterialInstances[WalkerVehicle.BurnOutMaterialInstances.length] = BOD;
	}
}

defaultproperties
{
   Begin Object Class=SkeletalMeshComponent Name=LegMeshComponent ObjName=LegMeshComponent Archetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
      PhysicsWeight=1.000000
      bIgnoreControllersWhenNotRendered=True
      bHasPhysicsAssetInstance=True
      LightEnvironment=DynamicLightEnvironmentComponent'UTGame.Default__UTWalkerBody:LegLightEnvironmentComp'
      bUseAsOccluder=False
      CollideActors=True
      BlockZeroExtent=True
      BlockNonZeroExtent=True
      RBChannel=RBCC_Nothing
      RBCollideWithChannels=(Default=True,GameplayPhysics=True,EffectPhysics=True)
      Name="LegMeshComponent"
      ObjectArchetype=SkeletalMeshComponent'Engine.Default__SkeletalMeshComponent'
   End Object
   SkeletalMeshComponent=LegMeshComponent
   ShoulderSkelControlName(0)="Shoulder1"
   ShoulderSkelControlName(1)="Shoulder2"
   ShoulderSkelControlName(2)="Shoulder3"
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle0 ObjName=RB_FootHandle0 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerStepHandle'
      LinearDamping=50.000000
      LinearStiffness=10000.000000
      Name="RB_FootHandle0"
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerStepHandle'
   End Object
   FootConstraints(0)=RB_FootHandle0
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle1 ObjName=RB_FootHandle1 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerStepHandle'
      LinearDamping=50.000000
      LinearStiffness=10000.000000
      Name="RB_FootHandle1"
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerStepHandle'
   End Object
   FootConstraints(1)=RB_FootHandle1
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle2 ObjName=RB_FootHandle2 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerStepHandle'
      LinearDamping=50.000000
      LinearStiffness=10000.000000
      Name="RB_FootHandle2"
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerStepHandle'
   End Object
   FootConstraints(2)=RB_FootHandle2
   StepStageTimes(0)=0.700000
   StepStageTimes(1)=0.135000
   StepStageTimes(2)=1.000000
   MinStepDist=20.000000
   MaxLegReach=450.000000
   LandedFootDistSq=400.000000
   FootEmbedDistance=8.000000
   FootBoneName(0)="Leg1_End"
   FootBoneName(1)="Leg2_End"
   FootBoneName(2)="Leg3_End"
   ShoulderBoneName(0)="Leg1_Shoulder"
   ShoulderBoneName(1)="Leg2_Shoulder"
   ShoulderBoneName(2)="Leg3_Shoulder"
   BodyBoneName="Root"
   BaseLegDirLocal(0)=(X=-1.000000,Y=0.000000,Z=0.000000)
   BaseLegDirLocal(1)=(X=0.500000,Y=-0.866025,Z=0.000000)
   BaseLegDirLocal(2)=(X=0.500000,Y=0.866025,Z=0.000000)
   FootPosVelAdjScale(0)=1.200000
   FootPosVelAdjScale(1)=0.600000
   FootPosVelAdjScale(2)=0.600000
   FootStepStartLift=512.000000
   FootStepEndLift=128.000000
   Begin Object Class=DynamicLightEnvironmentComponent Name=LegLightEnvironmentComp ObjName=LegLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
      AmbientGlow=(R=0.200000,G=0.200000,B=0.200000,A=1.000000)
      Name="LegLightEnvironmentComp"
      ObjectArchetype=DynamicLightEnvironmentComponent'Engine.Default__DynamicLightEnvironmentComponent'
   End Object
   LegLightEnvironment=LegLightEnvironmentComp
   MaxFootStepEffectDist=5000.000000
   Components(0)=LegLightEnvironmentComp
   Components(1)=LegMeshComponent
   Components(2)=RB_FootHandle0
   Components(3)=RB_FootHandle1
   Components(4)=RB_FootHandle2
   Physics=PHYS_RigidBody
   TickGroup=TG_PostAsyncWork
   bIgnoreEncroachers=True
   bCollideActors=True
   bProjTarget=True
   bNoEncroachCheck=True
   bEdShouldSnap=True
   CollisionComponent=LegMeshComponent
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTWalkerBody"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
