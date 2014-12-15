/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_FuryGun extends UTVehicleWeapon
	HideDropDown;

var float RechargeTime;
var float RechargePct;

/** how far off crosshair vehicle turret can be and still have beam adjusted to crosshair */
var float BeamMaxAimAdjustment;

var MaterialImpactEffect PawnHitEffect;

/** stored up fractional damage since we check every tick but health/damage are integers */
var float PartialDamage;

/** last pawn beam successfully hit */
var Pawn LastBeamTarget;

/** angle for locking for lock targets */
var float 				LockAim;

/** angle for locking for lock targets when on Console */
var float 				ConsoleLockAim;

/** interpolation speeds for zoom in/out when firing */
var() protected float ZoomInInterpSpeed;
var() protected float ZoomOutInterpSpeed;
var float MinZoomFOV, MaxZoomFOV;
var float MinZoomDist, MaxZoomDist;

function byte BestMode()
{
	return 0;
}

/**********************************************************************
  Secondary Fire
 **********************************************************************/

simulated static function MaterialImpactEffect GetImpactEffect(Actor HitActor, PhysicalMaterial HitMaterial, byte FireModeNum)
{
	return (FireModeNum == 0 && Pawn(HitActor) != None) ? default.PawnHitEffect : Super.GetImpactEffect(HitActor, HitMaterial, FireModeNum);
}

simulated event float GetPowerPerc()
{
	return 1.0;
}

/*********************************************************************************************
 * State WeaponFiring
 * See UTWeapon.WeaponFiring
 *********************************************************************************************/

simulated state WeaponBeamFiring
{
	simulated event bool IsFiring()
	{
		return true;
	}

	simulated event float GetPowerPerc()
	{
		return 1.0 - GetTimerCount('RefireCheckTimer') / GetTimerRate('RefireCheckTimer');
	}

	/** deals damage/momentum to the target we hit this tick */
	simulated function DealDamageTo(Actor Victim, int Damage, float DeltaTime, vector StartTrace)
	{
		local SVehicle V;

		//@hack: vehicle damage impulse is constant in the damagetype, so have to use this to scale by deltatime
		V = SVehicle(Victim);
		if (V != None)
		{
			V.RadialImpulseScaling = DeltaTime;
		}
		Victim.TakeDamage(Damage, Instigator.Controller, Victim.Location,
					InstantHitMomentum[CurrentFireMode] * DeltaTime * Normal(StartTrace - Victim.Location),
					InstantHitDamageTypes[CurrentFireMode],, self );
	}

	simulated function Tick(float DeltaTime)
	{
		local Vector StartTrace, EndTrace, ZoomLocation;
		local ImpactInfo IInfo, NearImpact;
		local Array<ImpactInfo>	ImpactList;
		local UTVehicle_Fury UTVFury;
		local UTPlayerController UTPC;
		local float BestAim, NewDamage;
		local UTPawn UTP;
		local UTPlayerController PC;

		NewDamage = Instigator.DamageScaling * InstantHitDamage[CurrentFireMode] * DeltaTime;
		if (MyVehicle != None)
		{
			UTP = UTPawn(MyVehicle.Driver);
			if ( (UTP != None) && (UTP.FireRateMultiplier > 0) )
			{
				NewDamage = NewDamage/UTP.FireRateMultiplier;
			}
		}

		PartialDamage += NewDamage;

		StartTrace = InstantFireStartTrace();
		EndTrace = InstantFireEndTrace(StartTrace);

		// lock onto last hit target if still close to aim
		UTPC = UTPlayerController(Instigator.Controller);
		BestAim	= ((UTPC != None) && UTPC.AimingHelp(true)) ? ConsoleLockAim : LockAim;
		if (LastBeamTarget != None && Normal(EndTrace - StartTrace) dot Normal(LastBeamTarget.Location - StartTrace) >= BestAim)
		{
			// cause damage
			DealDamageTo(LastBeamTarget, int(PartialDamage), DeltaTime, StartTrace);
			ZoomLocation = LastBeamTarget.Location;
		}
		else
		{
			IInfo = CalcWeaponFire(StartTrace, EndTrace, ImpactList);

			if ( IInfo.HitActor == None || !IInfo.HitActor.bProjTarget )
			{
				// console aiming help
				NearImpact = InstantAimHelp(StartTrace, EndTrace, IInfo);
				if ( NearImpact.HitActor != None )
				{
					bUsingAimingHelp = true;
					IInfo = NearImpact;
				}
			}
			ZoomLocation = (IInfo.HitActor != None) ? IInfo.HitLocation : EndTrace;
			
			// Check for an actual hit.  If there is one, flag it.
			UTVFury = UTVehicle_Fury(MyVehicle);
			if (IInfo.HitActor != None && !IInfo.HitActor.bWorldGeometry)
			{
				if (Role == ROLE_Authority)
				{
					// setup beam effect
					if (StaticMeshComponent(IInfo.HitInfo.HitComponent) != None || BrushComponent(IInfo.HitInfo.HitComponent) != None)
					{
						// if we hit a static mesh, the trace was per poly so we can target the exact location
						UTVFury.BeamLockedInfo.LockedTarget = None;
						Global.SetFlashLocation(IInfo.HitLocation);
					}
					else
					{
						UTVFury.BeamLockedInfo.LockedTarget = IInfo.HitActor;
						UTVFury.BeamLockedInfo.LockedBone = IInfo.HitInfo.BoneName;
						UTVFury.BeamLockOn();
					}
				}

				// cause damage
				DealDamageTo(IInfo.HitActor, PartialDamage, DeltaTime, StartTrace);
				LastBeamTarget = Pawn(IInfo.HitActor);
			}
			else
			{
				LastBeamTarget = None;
				if (Role == ROLE_Authority)
				{
					UTVFury.BeamLockedInfo.LockedTarget = None;
					Global.SetFlashLocation((IInfo.HitActor == None) ? EndTrace : IInfo.HitLocation);
				}
			}
		}

		//update zoom based on target distance
		PC = UTPlayerController(Instigator.Controller);
		if (PC != None && PC.IsLocalPlayerController() && PC.ViewTarget == Instigator)
		{
			ZoomedTargetFOV = MinZoomFOV + (MaxZoomFOV - MinZoomFOV) * FClamp((VSize(Location - ZoomLocation) - MinZoomDist)/(MaxZoomDist - MinZoomDist), 0.0, 1.0);
			PC.StartZoomNonlinear(ZoomedTargetFOV, ZoomInInterpSpeed);
		}

		PartialDamage -= int(PartialDamage);
	}

	/** stubbed out so that CalcWeaponFire() in beam trace doesn't set FlashLocation when we might not want it */
	function SetFlashLocation(vector HitLocation);

	/** called when fire time is up or player lets go of the button */
	simulated function FiringDone()
	{
		GotoState('WeaponBeamRecharging');
	}

	simulated function RefireCheckTimer()
	{
		FiringDone();
	}

	simulated function EndFire(byte FireModeNum)
	{
		RechargePct = GetTimerCount('RefireCheckTimer') / GetTimerRate('RefireCheckTimer');
		Global.EndFire(FireModeNum);
		FiringDone();
	}

	simulated function float GetMaxFinalAimAdjustment()
	{
		return BeamMaxAimAdjustment;
	}

	simulated function BeginState( Name PreviousStateName )
	{
		RechargePct = 1.0;
		TimeWeaponFiring(CurrentFireMode);
		Tick(0.0);
	}

	/**
	 * When leaving the state, shut everything down
	 */
	simulated function EndState(Name NextStateName)
	{
		local UTPlayerController PC;

		ClearTimer('RefireCheckTimer');
		UTVehicle_Fury(MyVehicle).BeamLockedInfo.LockedTarget = None;
		ClearFlashLocation();
		LastBeamTarget = None;
		PartialDamage = 0.0;

		PC = UTPlayerController(Instigator.Controller);
		if ( (PC != None) && (LocalPlayer(PC.Player) != None) )
		{
			PC.EndZoomNonlinear(ZoomOutInterpSpeed);
		}

		Super.EndState(NextStateName);
	}
}

simulated state WeaponBeamRecharging
{
	simulated event float GetPowerPerc()
	{
		return GetTimerCount('RechargeDone') / GetTimerRate('RechargeDone');
	}

	simulated event BeginState(name PreviousStateName)
	{
		if (RechargePct ~= 0.0)
		{
			RechargeDone();
		}
		else
		{
			SetTimer(RechargeTime * RechargePct, false, 'RechargeDone');
		}
	}

	simulated event EndState(name NextStateName)
	{
		ClearTimer('RechargeDone');
	}

	simulated function RechargeDone()
	{
		Gotostate('Active');
	}

	simulated function bool IsFiring()
	{
		return true;
	}
}

defaultproperties
{
   RechargeTime=0.500000
   BeamMaxAimAdjustment=0.710000
   PawnHitEffect=(DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_Fury.Effects.P_VH_Fury_Beam_Grab')
   LockAim=0.996000
   ConsoleLockAim=0.991000
   ZoomInInterpSpeed=6.000000
   ZoomOutInterpSpeed=3.000000
   MinZoomFOV=55.000000
   MaxZoomFOV=22.000000
   MinZoomDist=1200.000000
   MaxZoomDist=4000.000000
   FireTriggerTags(0)="RaptorWeapon01"
   FireTriggerTags(1)="RaptorWeapon02"
   DefaultImpactEffect=(ParticleTemplate=ParticleSystem'VH_Fury.Effects.P_VH_Fury_Beam_Impact')
   VehicleClass=Class'UTGameContent.UTVehicle_Fury_Content'
   bFastRepeater=True
   AmmoDisplayType=EAWDS_BarGraph
   ZoomedTargetFOV=22.000000
   WeaponFireTypes(1)=EWFT_None
   FiringStatesArray(0)="WeaponBeamFiring"
   FireInterval(0)=1.500000
   InstantHitDamage(0)=200.000000
   InstantHitMomentum(0)=100000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_FuryBeam'
   bInstantHit=True
   WeaponRange=4000.000000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Fury"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_FuryGun"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
