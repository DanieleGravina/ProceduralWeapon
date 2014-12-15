/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTWalkerBody_DarkWalker extends UTWalkerBody;

/** Light attached to the energy ball. */
var() protected PointLightComponent EnergyBallLight;

/** Holds energy ball's material so we can modify parameters. */
var protected transient MaterialInstanceConstant EnergyBallMatInst;

/** Current percentage the energy ball is powered.  Range [0..1]. */
var private transient float CurrentEnergyBallPowerPct;
/** Goal energy ball power percentage (to interpolate towards).  Range [0..1]. */
var private transient float GoalEnergyBallPowerPct;

/** InterpSpeed (for FInterpTo) used for interpolating the energy ball power up and down. */
var() protected const float EnergyBallPowerInterpSpeed;

/** Color for energy ball light in powered-on state. */
var() protected const color EnergyBallLightColor_PoweredOn;
/** Color for energy ball light in powered-off state. */
var() protected const color EnergyBallLightColor_PoweredOff;

/** Color for blue energy ball light in powered-on state. */
var() protected const color EnergyBallLightColor_PoweredOn_Blue;
/** Color for blue energy ball light in powered-off state. */
var() protected const color EnergyBallLightColor_PoweredOff_Blue;



/** Brightness for energy ball light in powered-on state. */
var() protected const float EnergyBallLightBrightness_PoweredOn;
/** Brightness for energy ball light in powered-off state. */
var() protected const float EnergyBallLightBrightness_PoweredOff;

/** Made a parameter because having an = in a name literal is verboten for some reason. */
var protected const Name	EnergyBallMaterialParameterName;


/** Emitters for beams connecting powerball to shoulders */
var protected ParticleSystemComponent	LegAttachBeams[NUM_WALKER_LEGS];
/** Name of beam endpoint parameter in the particle system */
var protected const name				LegAttachBeamEndPointParamName;

/** ParticleSystem Templates for the Leg beams **/
var protected ParticleSystem PS_LegBeamTemplate;
var protected ParticleSystem PS_LegBeamTemplate_Blue;

/** Names of the top leg bones.  LegAttachBeams will terminate here. */
var protected const name				TopLegBoneName[NUM_WALKER_LEGS];

/** These keep the previous location of the legs and body so that we don't have to do expensive line traces if we have actually not moved their position **/
var protected vector PreviousLegLocation[NUM_WALKER_LEGS];

/** camera anim played when foot lands nearby */
var CameraAnim FootStepShake;
var float FootStepShakeRadius;

function PostBeginPlay()
{
	local int Idx;

	super.PostBeginPlay();

	EnergyBallMatInst = SkeletalMeshComponent.CreateAndSetMaterialInstanceConstant(1);
	SetEnergyBallPowerPercent(0.f);

	// attach powerball light to the ball
	SkeletalMeshComponent.AttachComponent(EnergyBallLight, BodyBoneName);

	// attach leg attach beam emitters to the ball
	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		SkeletalMeshComponent.AttachComponent(LegAttachBeams[Idx], BodyBoneName);
	}
}

final protected function SetEnergyBallPowerPercent(float Pct)
{
	local float NewBrightness;
	local color NewColor;

	if( WalkerVehicle == none )
	{
		return;
	}

	// store it
	CurrentEnergyBallPowerPct = Pct;

	// set light color and brightness
	if( WalkerVehicle.GetTeamNum() == 1 )
	{
		NewColor = EnergyBallLightColor_PoweredOff_Blue + (EnergyBallLightColor_PoweredOn_Blue - EnergyBallLightColor_PoweredOff) * CurrentEnergyBallPowerPct;

	}
	else
	{
		NewColor = EnergyBallLightColor_PoweredOff + (EnergyBallLightColor_PoweredOn - EnergyBallLightColor_PoweredOff) * CurrentEnergyBallPowerPct;
	}


	NewBrightness = EnergyBallLightBrightness_PoweredOff + (EnergyBallLightBrightness_PoweredOn - EnergyBallLightBrightness_PoweredOff) * CurrentEnergyBallPowerPct;

	//`log( "SetEnergyBallPowerPercent: " $ WalkerVehicle.GetTeamNum() $ " NewBrightness: " $ NewBrightness );

	EnergyBallLight.SetLightProperties(NewBrightness, NewColor);

	// set material param
	EnergyBallMatInst.SetScalarParameterValue(EnergyBallMaterialParameterName, CurrentEnergyBallPowerPct);
}

event PlayFootStep(int LegIdx)
{
	local UTPlayerController PC;
	local float Dist;

	Super.PlayFootStep(LegIdx);

	foreach LocalPlayerControllers(class'UTPlayerController', PC)
	{
		if (UTVehicleBase(PC.ViewTarget) == None || WalkerVehicle.Seats.Find('SeatPawn', UTVehicleBase(PC.ViewTarget)) == INDEX_NONE)
		{
			Dist = VSize(CurrentFootPosition[LegIdx] - PC.ViewTarget.Location);
			if (Dist < FootStepShakeRadius)
			{
				PC.PlayCameraAnim(FootStepShake, 1.0 - (Dist / FootStepShakeRadius));
			}
		}
	}
}

function Tick(float DeltaTime)
{
	local float NewPowerPct, NewBrightness;
	local int Idx;
	local vector LegLocation;

	super.Tick(DeltaTime);

	// ball is powered on when driven, powered off otherwise
	GoalEnergyBallPowerPct = (WalkerVehicle.bDriving && !WalkerVehicle.bDeadVehicle) ? 1.f : 0.f;

	if (GoalEnergyBallPowerPct != CurrentEnergyBallPowerPct)
	{
		NewPowerPct = FInterpTo(CurrentEnergyBallPowerPct, GoalEnergyBallPowerPct, DeltaTime, EnergyBallPowerInterpSpeed);
		SetEnergyBallPowerPercent(NewPowerPct);
	}
	else if (WalkerVehicle.bDeadVehicle)
	{
		// this will fade light to zero after it gets to the zero-energy color
		NewBrightness = FInterpTo(EnergyBallLight.Brightness, 0.f, DeltaTime, EnergyBallPowerInterpSpeed);
		EnergyBallLight.SetLightProperties(NewBrightness);
		EnergyBallMatInst.SetScalarParameterValue(EnergyBallMaterialParameterName, 0.0f);
	}

	// set leg attach beam endpoints
	for (Idx=0; Idx<NUM_WALKER_LEGS; ++Idx)
	{
		LegLocation = SkeletalMeshComponent.GetBoneLocation(TopLegBoneName[Idx]);

		if( VSize(PreviousLegLocation[Idx] - LegLocation) > 1.0f )
		{
			//`log( "Ticking Walker PSC: " $ LegAttachBeams[Idx] );
			LegAttachBeams[Idx].SetVectorParameter(LegAttachBeamEndPointParamName, LegLocation );
			PreviousLegLocation[Idx] = LegLocation;
		}
	}
}


/** NOTE:  this is actually what changes the colors on the PowerOrb on the legs of the Walker **/
simulated function TeamChanged()
{
	local int LegIdx;
	local ParticleSystem PS_LegBeam;

	Super.TeamChanged();

	if( WalkerVehicle.GetTeamNum() == 1 )
	{
		PS_LegBeam=PS_LegBeamTemplate_Blue;
	}
	else
	{
		PS_LegBeam=PS_LegBeamTemplate;
	}

	for( LegIdx = 0; LegIdx < NUM_WALKER_LEGS; ++LegIdx )
	{
		LegAttachBeams[LegIdx].SetTemplate( PS_LegBeam );
	}

	SetEnergyBallPowerPercent( CurrentEnergyBallPowerPct );
}

/** NOTE:  this is actually what changes the colors on the PowerOrb on the legs of the Walker **/
simulated function SetBurnOut()
{
	local int LegIdx;

	Super.SetBurnOut();

	for( LegIdx = 0; LegIdx < NUM_WALKER_LEGS; ++LegIdx )
	{
		LegAttachBeams[LegIdx].DeactivateSystem();
	}
}

defaultproperties
{
   Begin Object Class=PointLightComponent Name=Light0 ObjName=Light0 Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Radius=300.000000
      FalloffExponent=4.000000
      CastShadows=False
      LightingChannels=(BSP=False,Static=False)
      Name="Light0"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   EnergyBallLight=Light0
   EnergyBallPowerInterpSpeed=1.500000
   EnergyBallLightColor_PoweredOn=(B=126,G=231,R=250,A=0)
   EnergyBallLightColor_PoweredOff=(B=10,G=50,R=150,A=0)
   EnergyBallLightColor_PoweredOn_Blue=(B=217,G=153,R=89,A=0)
   EnergyBallLightColor_PoweredOff_Blue=(B=150,G=50,R=10,A=0)
   EnergyBallLightBrightness_PoweredOn=8.000000
   EnergyBallLightBrightness_PoweredOff=6.000000
   EnergyBallMaterialParameterName="Scalar"
   Begin Object Class=ParticleSystemComponent Name=LegAttachPSC_0 ObjName=LegAttachPSC_0 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Name="LegAttachPSC_0"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LegAttachBeams(0)=LegAttachPSC_0
   Begin Object Class=ParticleSystemComponent Name=LegAttachPSC_1 ObjName=LegAttachPSC_1 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Name="LegAttachPSC_1"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LegAttachBeams(1)=LegAttachPSC_1
   Begin Object Class=ParticleSystemComponent Name=LegAttachPSC_2 ObjName=LegAttachPSC_2 Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      SecondsBeforeInactive=1.000000
      Name="LegAttachPSC_2"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LegAttachBeams(2)=LegAttachPSC_2
   LegAttachBeamEndPointParamName="DarkwalkerLegEnd"
   PS_LegBeamTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_PowerBall_Idle'
   PS_LegBeamTemplate_Blue=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_PowerBall_Idle_Blue'
   TopLegBoneName(0)="Leg1_Bone1"
   TopLegBoneName(1)="Leg2_Bone1"
   TopLegBoneName(2)="Leg3_Bone1"
   FootStepShake=CameraAnim'Camera_FX.DarkWalker.C_VH_DarkWalker_Step_Shake'
   FootStepShakeRadius=1000.000000
   Begin Object Class=SkeletalMeshComponent Name=LegMeshComponent ObjName=LegMeshComponent Archetype=SkeletalMeshComponent'UTGame.Default__UTWalkerBody:LegMeshComponent'
      SkeletalMesh=SkeletalMesh'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Legs'
      AnimTreeTemplate=AnimTree'VH_DarkWalker.Anims.AT_VH_DarkWalker_Legs'
      PhysicsAsset=PhysicsAsset'VH_DarkWalker.Mesh.SK_VH_DarkWalker_Legs_Physics_NewLegs'
      AnimSets(0)=AnimSet'VH_DarkWalker.Anims.K_VH_DarkWalker_Legs'
      bUpdateJointsFromAnimation=True
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWalkerBody:LegMeshComponent'
   End Object
   SkeletalMeshComponent=LegMeshComponent
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle0 ObjName=RB_FootHandle0 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody:RB_FootHandle0'
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody:RB_FootHandle0'
   End Object
   FootConstraints(0)=RB_FootHandle0
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle1 ObjName=RB_FootHandle1 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody:RB_FootHandle1'
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody:RB_FootHandle1'
   End Object
   FootConstraints(1)=RB_FootHandle1
   Begin Object Class=UTWalkerStepHandle Name=RB_FootHandle2 ObjName=RB_FootHandle2 Archetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody:RB_FootHandle2'
      ObjectArchetype=UTWalkerStepHandle'UTGame.Default__UTWalkerBody:RB_FootHandle2'
   End Object
   FootConstraints(2)=RB_FootHandle2
   FootWaterEffect=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_DarkWalker_Water_Splash'
   MinStepDist=120.000000
   MaxLegReach=750.000000
   LegSpreadFactor=0.600000
   LandedFootDistSq=2500.000000
   FootEmbedDistance=32.000000
   bHasCrouchMode=True
   FootStepEffects(0)=(MaterialType="Dirt",Sound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FootstepCue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_FootImpact_Dust')
   FootStepEffects(1)=(MaterialType="Snow",Sound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FootstepCue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_FootImpact_Snow')
   FootStepEffects(2)=(MaterialType="Water",Sound=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FootstepCue',DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_DarkWalker_Water_Splash')
   FootStepAnimNodeName(0)="Leg0 Step"
   FootStepAnimNodeName(1)="Leg1 Step"
   FootStepAnimNodeName(2)="Leg2 Step"
   Begin Object Class=DynamicLightEnvironmentComponent Name=LegLightEnvironmentComp ObjName=LegLightEnvironmentComp Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTWalkerBody:LegLightEnvironmentComp'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTWalkerBody:LegLightEnvironmentComp'
   End Object
   LegLightEnvironment=LegLightEnvironmentComp
   Components(0)=LegLightEnvironmentComp
   Components(1)=LegMeshComponent
   Components(2)=RB_FootHandle0
   Components(3)=RB_FootHandle1
   Components(4)=RB_FootHandle2
   CollisionComponent=LegMeshComponent
   Name="Default__UTWalkerBody_DarkWalker"
   ObjectArchetype=UTWalkerBody'UTGame.Default__UTWalkerBody'
}
