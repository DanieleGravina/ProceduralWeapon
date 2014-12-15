/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVehicle_Nemesis extends UTVehicle;

/** animation for entering/exiting the vehicle */
var AnimNodeSequence EnterExitSequence;

/** skeletal controllers that should only be enabled when someone is driving the vehicle */
var array<SkelControlBase> DrivingControllers;

/** skeletal controllers that control the height of the turret */
var array<SkelControlBase> TurretHeightControllers;

/** indicates whether the turret is raised or lowered */
enum ETurretHeightSetting
{
	THS_Lowered,
	THS_Normal,
	THS_Raised,
};
var repnotify ETurretHeightSetting TurretHeightSetting;
var ETurretHeightSetting LastTurretHeightSetting;

/** The Template of the Beam to use */
var ParticleSystem BeamTemplate;

/** The particle system to use when in the raised position */
var ParticleSystem OrbPoweredUpParticle;
var ParticleSystem OrbPoweredUpParticle_Blue;

/** Nemesis has a material which has colors for on and off  and then a switch to flip between them **/
var LinearColor PowerOrbColorOn_Red;
var LinearColor PowerOrbColorOn_Blue;

var LinearColor PowerOrbColorOff_Red;
var LinearColor PowerOrbColorOff_Blue;

/** The particle system to use otherwise */
var ParticleSystem RegularOrb;
var ParticleSystem RegularOrb_Blue;

/** sounds for raising and lowering the turret */
var SoundCue TurretRaiseSound, TurretLowerSound;

/** audio component to play raise/lower sounds on */
var AudioComponent TurretAudioComponent;

/** Normal engine force */
var(Movement) float NormalEngineForce;

/** Engine force when raised */
var(Movement) float RaisedEngineForce;

/** Engine force when lowered */
var(Movement) float LoweredEngineForce;

/** Normal max speed */
var(Movement) float NormalMaxSpeed;

/** max speed when raised */
var(Movement) float RaisedMaxSpeed;

/** max speed when lowered */
var(Movement) float LoweredMaxSpeed;

/** Firing rate increase when raised */
var(Movement) float RaisedFiringRate;

/** Last Turret Height setting transition start time */
var float LastTurretHeightTransitionTime;

/** CameraScale to use when lowered */
var(Movement) float LoweredCameraScale;

/** BaseCameraOffset to use when lowered */
var(Movement) vector LoweredCameraOffset;

/** time to transition to lowered camera mode */
var(Movement) float FastCamTransitionTime;

/** camera lag when in crouched mode */
var(Movement) float LoweredCameraLag;

/** FOV when lowered */
var float LoweredFOV;

/** Camera shake to play when going lowered */
var CameraAnim LoweredCamShake;

/** true when want to transition camera back out of lowered camera mode */
var bool bTransitionCameraScale;

/** bRiseReset becomes true when rise becomes zero again after a posture transition, allowing toggling of postures with same key */
var bool bRiseReset;

var AnimNodeBlend CrouchBlend;

replication
{
	if (Role == ROLE_Authority)
		TurretHeightSetting;
}

simulated event PostBeginPlay()
{
	//local UTVehicleSimHovertank TankObj;

	Super.PostBeginPlay();

	EnterExitSequence = AnimNodeSequence(Mesh.Animations.FindAnimNode('EnterExitNode'));
	if (EnterExitSequence == None) WarnInternal("Could not find EnterExitNode for mesh (" $ Mesh $ ")");

	DrivingControllers[DrivingControllers.length] = Mesh.FindSkelControl('GunYawLock');
	DrivingControllers[DrivingControllers.length] = Mesh.FindSkelControl('GunPitchLock');
	DrivingControllers[DrivingControllers.length] = Mesh.FindSkelControl('TurretBaseLock');
	DrivingControllers[DrivingControllers.length] = Mesh.FindSkelControl('TurretBaseLock');

	SetDrivingControllersActive(false);

	TurretHeightControllers[TurretHeightControllers.length] = Mesh.FindSkelControl('HeightControl1');
	TurretHeightControllers[TurretHeightControllers.length] = Mesh.FindSkelControl('HeightControl2');

	CrouchBlend = AnimNodeBlend(Mesh.FindAnimNode('CrouchNode'));
	OrbPower(false);

	// On console - disallow turning in place when you steer.
	if (WorldInfo.bUseConsoleInput || (UTGameReplicationInfo(WorldInfo.GRI) != None && UTGameReplicationInfo(WorldInfo.GRI).bConsoleServer))
	{
		//TankObj = UTVehicleSimHovertank(SimObj);
		//TankObj.bTurnInPlaceOnSteer = false;
	}

	// we have a separate material for the power orb
	Mesh.CreateAndSetMaterialInstanceConstant(1);
}

simulated function SetDrivingControllersActive(bool bNowActive)
{
	local int i;

	for (i = 0; i < DrivingControllers.length; i++)
	{
		if (DrivingControllers[i] != None)
		{
			DrivingControllers[i].SetSkelControlActive(bNowActive);
		}
	}
}

simulated function DrivingStatusChanged()
{
	Super.DrivingStatusChanged();

	OrbPower(bDriving);

	SetDrivingControllersActive(bDriving);

	SetTurretHeight(bDriving ? THS_Normal : THS_Lowered);
	if (CrouchBlend != None)
	{
		CrouchBlend.SetBlendTarget(0.0, EnterExitSequence.GetAnimPlaybackLength());
	}

	if (Role == ROLE_Authority)
	{
		if (UTBot(Controller) != None)
		{
			SetTimer(2.0, true, 'CheckAIStance');
		}
		else
		{
			ClearTimer('CheckAIStance');
		}
	}
}

/** used by AI to decide what stance to be in */
function CheckAIStance()
{
	local UTBot B;
	local ETurretHeightSetting NewStance;

	B = UTBot(Controller);
	if (B != None)
	{
		if (B.IsShootingObjective() || B.Stopped())
		{
			NewStance = THS_Raised;
		}
		else if ( B.Enemy == None && B.MoveTarget != None && B.CurrentPath != None && B.NextRoutePath != None &&
			B.InLatentExecution(class'Controller'.const.LATENT_MOVETOWARD) && (B.CurrentPathDir dot vector(Rotation)) > 0.7 &&
			(Normal(B.NextRoutePath.End.Nav.Location - B.NextRoutePath.Start.Location) dot vector(Rotation)) > 0.7 )
		{
			NewStance = THS_Lowered;
		}
		else
		{
			NewStance = THS_Normal;
		}
		SetTurretHeight(NewStance);
	}
}

simulated function VehicleWeaponImpactEffects(vector HitLocation, int SeatIndex)
{
	local ParticleSystemComponent Beam;

	Super.VehicleWeaponImpactEffects(HitLocation, SeatIndex);

	// Handle Beam Effects for the shock beam
	if ( !IsZero(HitLocation) )
	{
		Beam = WorldInfo.MyEmitterPool.SpawnEmitter(BeamTemplate, GetEffectLocation(SeatIndex));
		Beam.SetVectorParameter('ShockBeamEnd', HitLocation);
	}
}

simulated function VehicleWeaponFireEffects(vector HitLocation, int SeatIndex)
{
	if (GetBarrelIndex(SeatIndex) == 0)
	{
		VehicleEvent('TankWeapon01');
	}
	else
	{
		VehicleEvent('TankWeapon02');
	}
}

function SetTurretHeight(ETurretHeightSetting NewHeightSetting)
{
	if (TurretHeightSetting != NewHeightSetting)
	{
		TurretHeightSetting = NewHeightSetting;
		ApplyTurretHeight();
	}
}

simulated function Tick(float DeltaTime)
{
	local float CamStrength;
	local UTPlayerController UTPC;

	Super.Tick(DeltaTime);

	if ( TurretHeightSetting == THS_Lowered )
	{
		UTPC = UTPlayerController(Controller);
		if(UTPC != None)
		{
			CamStrength = FClamp(VSize(Velocity)/AirSpeed, 0.0, 1.0);
			UTPC.SetCameraAnimStrength(CamStrength);
		}
	}
}

simulated function ApplyTurretHeight()
{
	local int i;
	local bool bTurretRaised;
	local name NewAnim;
	local float OldFiringRate, CamStrength;
	local UTPlayerController UTPC;

	UTPC = UTPlayerController(Controller);

	LastTurretHeightTransitionTime = WorldInfo.TimeSeconds;
	bTurretRaised = (TurretHeightSetting == THS_Raised);
	for (i = 0; i < TurretHeightControllers.length; i++)
	{
		if (TurretHeightControllers[i] != None)
		{
			TurretHeightControllers[i].SetSkelControlActive(bTurretRaised);
		}
	}

	NewAnim = (TurretHeightSetting == THS_Lowered) ? 'GetOut' : 'GetIn';
	if (EnterExitSequence.AnimSeqName != NewAnim)
	{
		EnterExitSequence.SetAnim(NewAnim);
		EnterExitSequence.PlayAnim(, EnterExitSequence.Rate);
	}
	if (CrouchBlend != None)
	{
		CrouchBlend.SetBlendTarget((TurretHeightSetting == THS_Lowered && bDriving) ? 1.0 : 0.0, EnterExitSequence.GetAnimPlaybackLength());
	}

	TurretAudioComponent.Stop();
	if (TurretHeightSetting < LastTurretHeightSetting)
	{
		TurretAudioComponent.SoundCue = TurretLowerSound;
		if (VehicleEffects.length > 2 && VehicleEffects[2].EffectRef != None)
		{
			if( GetTeamNum() == 1 )
			{
				VehicleEffects[2].EffectRef.SetTemplate(RegularOrb_Blue);
			}
			else
			{
				VehicleEffects[2].EffectRef.SetTemplate(RegularOrb);
			}

			if (!bDriving) // if the Nemesis is resetting itself after an exit, we don't want this on
			{
				VehicleEffects[2].EffectRef.DeactivateSystem();
			}
		}
	}
	else
	{
		TurretAudioComponent.SoundCue = TurretRaiseSound;
	}
	TurretAudioComponent.Play();

	LastTurretHeightSetting = TurretHeightSetting;

	// change engine torque and firing rate based on posture
	if ( TurretHeightSetting == THS_Raised )
	{
		UTVehicleSimHoverTank(SimObj).MaxThrustForce = RaisedEngineForce;
		AirSpeed = RaisedMaxSpeed;
		if( GetTeamNum() == 1 )
		{
			VehicleEffects[2].EffectRef.SetTemplate(OrbPoweredUpParticle_Blue);
		}
		else
		{
			VehicleEffects[2].EffectRef.SetTemplate(OrbPoweredUpParticle);
		}

		DefaultFOV = Default.DefaultFOV;

		if ( UTPC != None )
		{
			UTPC.StopCameraAnim(FALSE);
		}
	}
	else if ( TurretHeightSetting == THS_Lowered )
	{
		UTVehicleSimHoverTank(SimObj).MaxThrustForce = LoweredEngineForce;
		AirSpeed = LoweredMaxSpeed;
		bTransitionCameraScale = true; // for when leave lowered posture
		DefaultFOV = LoweredFOV;

		if ( UTPC != None )
		{
			CamStrength = FClamp(VSize(Velocity)/AirSpeed, 0.0, 1.0);
			UTPC.PlayCameraAnim(LoweredCamShake, CamStrength, 0.8f, 1.f, 0.f, TRUE, FALSE);
		}
	}
	else
	{
		UTVehicleSimHoverTank(SimObj).MaxThrustForce = NormalEngineForce;
		AirSpeed = NormalMaxSpeed;
		DefaultFOV = Default.DefaultFOV;

		if ( UTPC != None )
		{
			UTPC.StopCameraAnim(FALSE);
		}
	}
	if ( UTPC != None )
	{
		UTPC.DefaultFOV = DefaultFOV;
		UTPC.DesiredFOV = DefaultFOV;
	}
	UTVehicleSimHoverTank(SimObj).MaxReverseForce = 0.67 * UTVehicleSimHoverTank(SimObj).MaxThrustForce;

	if ( Seats[0].Gun != None )
	{
		OldFiringRate = Seats[0].Gun.FireInterval[0];
		Seats[0].Gun.FireInterval[0] = Seats[0].Gun.Default.FireInterval[0];
		if ( TurretHeightSetting == THS_Raised )
		{
			Seats[0].Gun.FireInterval[0] *= RaisedFiringRate;
		}

		if ( (Seats[0].Gun.FireInterval[0] != OldFiringRate)
			&& Seats[0].Gun.IsTimerActive('RefireCheckTimer')
			&& (Seats[0].Gun.CurrentFireMode == 0) )
		{
			// make currently firing weapon change firing rate
			Seats[0].Gun.ClearTimer('RefireCheckTimer');
			Seats[0].Gun.TimeWeaponFiring(0);
		}
	}
}

/** Used to make sure we stop the camera anim when you get out of nemesis. */
simulated function DetachDriver( Pawn P )
{
	Super.DetachDriver(P);

	if( UTPlayerController(P.Controller) != None )
	{
		UTPlayerController(P.Controller).StopCameraAnim(TRUE);
	}
}

simulated function OrbPower(bool bIsActive)
{
	local MaterialInstance MI;

	if( WorldInfo.NetMode != NM_DedicatedServer )
	{
		if( MaterialInstance( Mesh.Materials[1]) != none )
		{
			MI = MaterialInstance( Mesh.Materials[1] );
		}
		else
		{
			MI = Mesh.CreateAndSetMaterialInstanceConstant(1);
		}

		MI.SetScalarParameterValue('EnergyCorePower', bIsActive?1:0);

		if( GetTeamNum() == 1 )
		{
			MI.SetVectorParameterValue( 'PowerOrbColor_On', PowerOrbColorOn_Blue );
			MI.SetVectorParameterValue( 'PowerOrbColor_Off', PowerOrbColorOff_Blue );
		}
		else
		{
			MI.SetVectorParameterValue( 'PowerOrbColor_On', PowerOrbColorOn_Red );
			MI.SetVectorParameterValue( 'PowerOrbColor_Off', PowerOrbColorOff_Red );
		}
	}
}

simulated function TeamChanged()
{
	local MaterialInstance MI;

	Super.TeamChanged();

	if( WorldInfo.NetMode != NM_DedicatedServer )
	{
		MI = MaterialInstance(Mesh.Materials[1]);

		if( GetTeamNum() == 1 )
		{
			MI.SetVectorParameterValue( 'PowerOrbColor_On', PowerOrbColorOn_Blue );
			MI.SetVectorParameterValue( 'PowerOrbColor_Off', PowerOrbColorOff_Blue );
		}
		else
		{
			MI.SetVectorParameterValue( 'PowerOrbColor_On', PowerOrbColorOn_Red );
			MI.SetVectorParameterValue( 'PowerOrbColor_Off', PowerOrbColorOff_Red );
		}
	}
}


simulated function int PartialTurn(int original, int desired, float PctTurn)
{
	local float result;

	original = original & 65535;
	desired = desired & 65535;

	if ( abs(original - desired) > 32768 )
	{
		if ( desired > original )
		{
			original += 65536;
		}
		else
		{
			desired += 65536;
		}
	}
	result = original*(1-PctTurn) + desired*PctTurn;
	return (int(result) & 65535);
}

/**
  *  Force fixed view if in lowered posture
  */
simulated function Rotator GetViewRotation()
{
	local rotator FixedRotation, ControllerRotation;
	local float TimeSinceTransition, PctTurn;

	if ( TurretHeightSetting != THS_Lowered )
	{
		if ( bTransitionCameraScale )
		{
			TimeSinceTransition = WorldInfo.TimeSeconds- LastTurretHeightTransitionTime;
			if ( TimeSinceTransition < FastCamTransitionTime )
			{
				FixedRotation = super.GetViewRotation();
				PctTurn = TimeSinceTransition/FastCamTransitionTime;
				FixedRotation.Yaw = PartialTurn(Rotation.Yaw, FixedRotation.Yaw, PctTurn);
				FixedRotation.Pitch = PartialTurn(Rotation.Pitch, FixedRotation.Pitch, PctTurn);
				FixedRotation.Roll = PartialTurn(Rotation.Roll, FixedRotation.Roll, PctTurn);
				return FixedRotation;
			}
		}
		return super.GetViewRotation();
	}

	// swing smoothly around to vehicle rotation
	TimeSinceTransition = WorldInfo.TimeSeconds- LastTurretHeightTransitionTime;
	if ( TimeSinceTransition < FastCamTransitionTime )
	{
		FixedRotation = super.GetViewRotation();
		PctTurn = TimeSinceTransition/FastCamTransitionTime;
		FixedRotation.Yaw = PartialTurn(FixedRotation.Yaw, Rotation.Yaw, PctTurn);
		FixedRotation.Pitch = PartialTurn(FixedRotation.Pitch, Rotation.Pitch, PctTurn);
		FixedRotation.Roll = PartialTurn(FixedRotation.Roll, Rotation.Roll, PctTurn);
		return FixedRotation;
	}
	else
	{
		if ( Controller != None )
		{
	    ControllerRotation = Rotation;
	    ControllerRotation.Roll = 0;
			Controller.SetRotation(ControllerRotation);
		}
		return Rotation;
	}
}

simulated function VehicleCalcCamera(float DeltaTime, int SeatIndex, out vector out_CamLoc, out rotator out_CamRot, out vector CamStart, optional bool bPivotOnly)
{
	local float RealSeatCameraScale;
	local float TimeSinceTransition;

	RealSeatCameraScale = SeatCameraScale;
	if ( TurretHeightSetting == THS_Lowered )
	{
		TimeSinceTransition = WorldInfo.TimeSeconds- LastTurretHeightTransitionTime;
		if ( TimeSinceTransition < FastCamTransitionTime )
		{
			SeatCameraScale = (LoweredCameraScale*TimeSinceTransition + SeatCameraScale*(FastCamTransitionTime-TimeSinceTransition))/FastCamTransitionTime;
			Seats[0].CameraBaseOffset = LoweredCameraOffset * TimeSinceTransition/FastCamTransitionTime;
			CameraLag = (LoweredCameraLag*TimeSinceTransition + Default.CameraLag*(FastCamTransitionTime-TimeSinceTransition))/FastCamTransitionTime;
		}
		else
		{
			Seats[0].CameraBaseOffset = LoweredCameraOffset;
			SeatCameraScale = LoweredCameraScale;
			CameraLag = LoweredCameraLag;
		}
	}
	else if ( bTransitionCameraScale )
	{
		TimeSinceTransition = WorldInfo.TimeSeconds- LastTurretHeightTransitionTime;
		if ( TimeSinceTransition < FastCamTransitionTime )
		{
			SeatCameraScale = (SeatCameraScale*TimeSinceTransition + LoweredCameraScale*(FastCamTransitionTime-TimeSinceTransition))/FastCamTransitionTime;
			Seats[0].CameraBaseOffset = LoweredCameraOffset * (FastCamTransitionTime - TimeSinceTransition)/FastCamTransitionTime;
			CameraLag = (Default.CameraLag*TimeSinceTransition + LoweredCameraLag*(FastCamTransitionTime-TimeSinceTransition))/FastCamTransitionTime;
		}
		else
		{
			CameraLag = Default.CameraLag;
			bTransitionCameraScale = false;
		}
	}
	super.VehicleCalcCamera(DeltaTime, SeatIndex, out_CamLoc, out_CamRot, CamStart, bPivotOnly);
	SeatCameraScale = RealSeatCameraScale;
	Seats[0].CameraBaseOffset = vect(0,0,0);
}

simulated function SetInputs(float InForward, float InStrafe, float InUp)
{
	local ETurretHeightSetting NewHeightSetting;

	Super.SetInputs(InForward, InStrafe, InUp);

	if (Role == ROLE_Authority)
	{
		if ( !bRiseReset )
		{
			bRiseReset = (Rise == 0.f);
		}
		if ( !bRiseReset || (WorldInfo.TimeSeconds - LastTurretHeightTransitionTime < 0.25) || (Rise == 0.f) )
		{
			return;
		}
		bRiseReset = false;

		if ( TurretHeightSetting == THS_Normal )
		{
			NewHeightSetting = (Rise < 0.f || bWantsToCrouch) ? THS_Lowered : THS_Raised;
		}
		else
		{
			NewHeightSetting = THS_Normal;
		}
		SetTurretHeight(NewHeightSetting);
	}
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'TurretHeightSetting')
	{
		ApplyTurretHeight();
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

function bool RecommendLongRangedAttack()
{
	return true;
}

defaultproperties
{
   BeamTemplate=ParticleSystem'VH_Nemesis.Effects.P_VH_Nemesis_NewBeam'
   OrbPoweredUpParticle=ParticleSystem'VH_Nemesis.Effects.P_Power_Ball_Raised'
   OrbPoweredUpParticle_Blue=ParticleSystem'VH_Nemesis.Effects.P_Power_Ball_Raised_Blue'
   PowerOrbColorOn_Red=(R=0.750000,G=0.070000,B=0.000000,A=1.000000)
   PowerOrbColorOn_Blue=(R=0.000000,G=0.070000,B=0.750000,A=1.000000)
   PowerOrbColorOff_Red=(R=14.000000,G=3.750000,B=0.900000,A=1.000000)
   PowerOrbColorOff_Blue=(R=0.900000,G=3.750000,B=14.000000,A=1.000000)
   RegularOrb=ParticleSystem'VH_Nemesis.Effects.P_Power_Ball'
   RegularOrb_Blue=ParticleSystem'VH_Nemesis.Effects.P_Power_Ball_Blue'
   TurretRaiseSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_TurretExtendCue'
   TurretLowerSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_TurretCrouchCue'
   Begin Object Class=AudioComponent Name=TurretSound ObjName=TurretSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      bStopWhenOwnerDestroyed=True
      Name="TurretSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   TurretAudioComponent=TurretSound
   NormalEngineForce=2000.000000
   RaisedEngineForce=2000.000000
   LoweredEngineForce=2000.000000
   NormalMaxSpeed=500.000000
   RaisedMaxSpeed=200.000000
   LoweredMaxSpeed=1100.000000
   RaisedFiringRate=0.750000
   LoweredCameraScale=0.350000
   LoweredCameraOffset=(X=-50.000000,Y=0.000000,Z=80.000000)
   FastCamTransitionTime=0.500000
   LoweredCameraLag=0.015000
   LoweredFOV=90.000000
   LoweredCamShake=CameraAnim'Camera_FX.VH_Nemesis.C_VH_Nemesis_Ground_Rumble'
   bLookSteerOnSimpleControls=True
   bHasTurretExplosion=True
   bCameraNeverHidesVehicle=True
   bHasEnemyVehicleSound=True
   bIsNecrisVehicle=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=MyLightEnvironment ObjName=MyLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTVehicle:MyLightEnvironment'
   End Object
   LightEnvironment=MyLightEnvironment
   MaxDesireability=0.550000
   HornIndex=3
   LeftStickDirDeadZone=0.100000
   ConsoleSteerScale=1.000000
   Seats(0)=(GunClass=Class'UTGameContent.UTVWeap_NemesisTurret',GunSocket=("GunSocketL","GunSocketR"),GunPivotPoints=("BarrelOffset"),WeaponEffects=((SocketName="GunSocketL",Offset=(X=-10.000000,Y=0.000000,Z=0.000000),Scale3D=(X=11.000000,Y=8.000000,Z=8.000000)),(SocketName="GunSocketR",Offset=(X=-10.000000,Y=0.000000,Z=0.000000),Scale3D=(X=11.000000,Y=8.000000,Z=8.000000))),TurretControls=("GunPitch","GunYaw"),CameraTag="ViewSocket",CameraOffset=-310.000000,MuzzleFlashLightClass=Class'UTGameContent.UTNemesisMuzzleFlashLight',ImpactFlashLightClass=Class'UTGameContent.UTNemesisBeamLight',SeatIconPOS=(X=0.460000,Y=0.400000))
   VehicleEffects(0)=(EffectStartTag="TankWeapon01",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_MF_Nemesis',EffectSocket="GunSocketL")
   VehicleEffects(1)=(EffectStartTag="TankWeapon02",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_MF_Nemesis',EffectSocket="GunSocketR")
   VehicleEffects(2)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Power_Ball',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Power_Ball_Blue',EffectSocket="CoreSocket")
   VehicleEffects(3)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets_Blue',EffectSocket="L_Jet1")
   VehicleEffects(4)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets_Blue',EffectSocket="L_Jet2")
   VehicleEffects(5)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets_Blue',EffectSocket="L_Jet3")
   VehicleEffects(6)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets_Blue',EffectSocket="R_Jet1")
   VehicleEffects(7)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets_Blue',EffectSocket="R_Jet2")
   VehicleEffects(8)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_Nano_Jets_Blue',EffectSocket="R_Jet3")
   VehicleEffects(9)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_MF_Nemesis_Constant',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_MF_Nemesis_Constant_Blue',EffectSocket="GunSocketL")
   VehicleEffects(10)=(EffectStartTag="EngineStart",EffectEndTag="EngineStop",bRestartRunning=True,EffectTemplate=ParticleSystem'VH_Nemesis.Effects.P_MF_Nemesis_Constant',EffectTemplate_Blue=ParticleSystem'VH_Nemesis.Effects.P_MF_Nemesis_Constant_Blue',EffectSocket="GunSocketR")
   VehicleEffects(11)=(EffectStartTag="DamageSmoke",EffectEndTag="NoDamageSmoke",EffectTemplate=ParticleSystem'Envy_Effects.Vehicle_Damage.P_Vehicle_Damage_1_Nemisis',EffectSocket="DamageSmoke")
   DamageParamScaleLevels(0)=(DamageParamName="Damage1",Scale=4.000000)
   DamageParamScaleLevels(1)=(DamageParamName="Damage2",Scale=4.000000)
   DamageParamScaleLevels(2)=(DamageParamName="Damage3",Scale=6.000000)
   DamageMorphTargets(0)=(MorphNodeName="MorphNodeW_Front",LinkedMorphNodeName="MorphNodeW_Rear",InfluenceBone="TurretArm",Health=180,DamagePropNames=("Damage3"))
   DamageMorphTargets(1)=(MorphNodeName="MorphNodeW_Rear",InfluenceBone="TurretBody",Health=180,DamagePropNames=("Damage1"))
   DamageMorphTargets(2)=(InfluenceBone="LtTail2Damage",Health=180,DamagePropNames=("Damage2"))
   DamageMorphTargets(3)=(InfluenceBone="RtTail2Damage",Health=180,DamagePropNames=("Damage2"))
   TeamMaterials(0)=MaterialInstanceConstant'VH_Nemesis.Materials.MI_VH_Nemesis_Red'
   TeamMaterials(1)=MaterialInstanceConstant'VH_Nemesis.Materials.MI_VH_Nemesis_Blue'
   BigExplosionTemplates(0)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGE_Far',MinDistance=350.000000)
   BigExplosionTemplates(1)=(Template=ParticleSystem'Envy_Effects.VH_Deaths.P_VH_Death_LARGEL_Near')
   BigExplosionSocket="VH_Death"
   DestroyedTurretTemplate=StaticMesh'VH_Nemesis.Mesh.S_VH_Nemisis_Tank_Top'
   TurretExplosiveForce=3500.000000
   ExplosionSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_ExplodeCue'
   SpawnInSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeInNecris01Cue'
   SpawnOutSound=SoundCue'A_Vehicle_Generic.Vehicle.VehicleFadeOutNecris01Cue'
   FlagOffset=(X=-50.000000,Y=40.000000,Z=80.000000)
   FlagBone="TurretYaw"
   IconCoords=(U=965.000000,V=36.000000,UL=24.000000,VL=41.000000)
   SpawnMaterialLists(0)=(Materials=(MaterialInstanceConstant'VH_Nemesis.Materials.MI_VH_Nemesis_Spawn_Red'))
   SpawnMaterialLists(1)=(Materials=(MaterialInstanceConstant'VH_Nemesis.Materials.MI_VH_Nemesis_Spawn_Blue'))
   BurnOutMaterial(0)=MaterialInstanceTimeVarying'VH_Nemesis.Materials.MITV_VH_Nemesis_Red_BO'
   BurnOutMaterial(1)=MaterialInstanceTimeVarying'VH_Nemesis.Materials.MITV_VH_Nemesis_Blue_BO'
   CollisionDamageMult=0.001300
   LookForwardDist=140.000000
   HoverBoardAttachSockets(0)="HoverAttach00"
   HoverBoardAttachSockets(1)="HoverAttach01"
   WheelParticleEffects(0)=(MaterialType="Generic",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Goliath_Wheel_Dust')
   WheelParticleEffects(1)=(MaterialType="Dirt",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Dust_Effects.P_Goliath_Wheel_Dust')
   WheelParticleEffects(2)=(MaterialType="Water",ParticleTemplate=ParticleSystem'Envy_Level_Effects_2.Vehicle_Water_Effects.P_Goliath_Water_Splash')
   WheelParticleEffects(3)=(MaterialType="Snow")
   EnemyVehicleSound(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_EnemyNemesis'
   EnemyVehicleSound(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_EnemyNemesis'
   EnemyVehicleSound(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_EnemyNemesis'
   HudCoords=(U=265.000000,V=143.000000,UL=-89.000000,VL=-143.000000)
   Begin Object Class=UTVehicleSimHoverTank Name=SimObject ObjName=SimObject Archetype=UTVehicleSimHoverTank'UTGame.Default__UTVehicleSimHoverTank'
      MaxThrustForce=900.000000
      MaxReverseForce=600.000000
      LongDamping=0.850000
      LatDamping=0.700000
      TurnTorqueMax=9000.000000
      TurnDamping=4.000000
      bStabilizeStops=True
      StopThreshold=100.000000
      DrivingGroundDist=50.000000
      ParkedGroundDist=30.000000
      CurrentGroundDist=31.000000
      GroundDistAdjustSpeed=30.000000
      WheelAdjustFactor=55.000000
      StabilizationForceMultiplier=2.300000
      WheelSuspensionStiffness=75.000000
      WheelSuspensionDamping=4.000000
      Name="SimObject"
      ObjectArchetype=UTVehicleSimHoverTank'UTGame.Default__UTVehicleSimHoverTank'
   End Object
   SimObj=SimObject
   Begin Object Class=UTHoverWheel Name=LFWheel ObjName=LFWheel Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      SteerFactor=1.000000
      BoneName="LtTail2"
      BoneOffset=(X=70.000000,Y=0.000000,Z=-55.000000)
      WheelRadius=40.000000
      SuspensionTravel=55.000000
      LongSlipFactor=250.000000
      LatSlipFactor=500.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=500.000000
      Name="LFWheel"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(0)=LFWheel
   Begin Object Class=UTHoverWheel Name=LMWheel ObjName=LMWheel Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      BoneName="LtTail3"
      BoneOffset=(X=0.000000,Y=0.000000,Z=-55.000000)
      WheelRadius=30.000000
      SuspensionTravel=55.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="LMWheel"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(1)=LMWheel
   Begin Object Class=UTHoverWheel Name=LRWheel ObjName=LRWheel Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bUseMaterialSpecificEffects=True
      SteerFactor=1.000000
      BoneName="LtTail4"
      BoneOffset=(X=-35.000000,Y=0.000000,Z=-55.000000)
      WheelRadius=30.000000
      SuspensionTravel=55.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=250.000000
      Name="LRWheel"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(2)=LRWheel
   Begin Object Class=UTHoverWheel Name=RFWheel ObjName=RFWheel Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      SteerFactor=1.000000
      BoneName="RtTail2"
      BoneOffset=(X=70.000000,Y=0.000000,Z=-55.000000)
      WheelRadius=40.000000
      SuspensionTravel=55.000000
      LongSlipFactor=250.000000
      LatSlipFactor=500.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=500.000000
      Name="RFWheel"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(3)=RFWheel
   Begin Object Class=UTHoverWheel Name=RMWheel ObjName=RMWheel Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      BoneName="RtTail3"
      BoneOffset=(X=0.000000,Y=0.000000,Z=-55.000000)
      WheelRadius=30.000000
      SuspensionTravel=55.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=0.000000
      HandbrakeLatSlipFactor=0.000000
      Name="RMWheel"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(4)=RMWheel
   Begin Object Class=UTHoverWheel Name=RRWheel ObjName=RRWheel Archetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
      bUseMaterialSpecificEffects=True
      SteerFactor=1.000000
      BoneName="RtTail4"
      BoneOffset=(X=-35.000000,Y=0.000000,Z=-55.000000)
      WheelRadius=30.000000
      SuspensionTravel=55.000000
      LongSlipFactor=0.000000
      LatSlipFactor=0.000000
      HandbrakeLongSlipFactor=250.000000
      HandbrakeLatSlipFactor=250.000000
      Name="RRWheel"
      ObjectArchetype=UTHoverWheel'UTGame.Default__UTHoverWheel'
   End Object
   Wheels(5)=RRWheel
   COMOffset=(X=-110.000000,Y=0.000000,Z=-50.000000)
   Begin Object Class=RB_StayUprightSetup Name=MyStayUprightSetup ObjName=MyStayUprightSetup Archetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
      ObjectArchetype=RB_StayUprightSetup'UTGame.Default__UTVehicle:MyStayUprightSetup'
   End Object
   StayUprightConstraintSetup=RB_StayUprightSetup'UTGameContent.Default__UTVehicle_Nemesis:MyStayUprightSetup'
   Begin Object Class=RB_ConstraintInstance Name=MyStayUprightConstraintInstance ObjName=MyStayUprightConstraintInstance Archetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
      ObjectArchetype=RB_ConstraintInstance'UTGame.Default__UTVehicle:MyStayUprightConstraintInstance'
   End Object
   StayUprightConstraintInstance=RB_ConstraintInstance'UTGameContent.Default__UTVehicle_Nemesis:MyStayUprightConstraintInstance'
   MaxSpeed=1500.000000
   Begin Object Class=AudioComponent Name=NemesisEngineSound ObjName=NemesisEngineSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_EngineCue'
      Name="NemesisEngineSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   EngineSound=NemesisEngineSound
   CollisionSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_CollideCue'
   EnterVehicleSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_EngineStartCue'
   ExitVehicleSound=SoundCue'A_Vehicle_Nemesis.Cue.A_Vehicle_Nemesis_EngineStopCue'
   bTurnInPlace=True
   bSeparateTurretFocus=True
   bAvoidReversing=True
   bCanStrafe=True
   NonPreferredVehiclePathMultiplier=2.000000
   AirSpeed=500.000000
   Health=600
   Begin Object Class=SkeletalMeshComponent Name=SVehicleMesh ObjName=SVehicleMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
      SkeletalMesh=SkeletalMesh'VH_Nemesis.Mesh.SK_VH_Nemesis'
      AnimTreeTemplate=AnimTree'VH_Nemesis.Anims.AT_VH_Nemesis'
      PhysicsAsset=PhysicsAsset'VH_Nemesis.Mesh.SK_VH_Nemesis_Physics'
      AnimSets(0)=AnimSet'VH_Nemesis.Anims.K_VH_Nemesis'
      MorphSets(0)=MorphTargetSet'VH_Nemesis.Mesh.VH_Nemesis_MorphTargets'
      Materials(0)=Material'VH_Nemesis.Materials.M_VH_Nemesis'
      Materials(1)=Material'VH_Nemesis.Materials.M_VH_Nemesis_EnergyCore_Glow'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicle:SVehicleMesh'
   End Object
   Mesh=SVehicleMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
      CollisionHeight=100.000000
      CollisionRadius=260.000000
      Translation=(X=-50.000000,Y=0.000000,Z=80.000000)
      ObjectArchetype=CylinderComponent'UTGame.Default__UTVehicle:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Components(1)=SVehicleMesh
   Components(2)=MyLightEnvironment
   Components(3)=NemesisEngineSound
   Components(4)=TurretSound
   Components(5)=SimObject
   CollisionComponent=SVehicleMesh
   Name="Default__UTVehicle_Nemesis"
   ObjectArchetype=UTVehicle'UTGame.Default__UTVehicle'
}
