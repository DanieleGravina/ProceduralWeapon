/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_DarkWalkerTurret extends UTVehicleWeapon
	HideDropDown;

var float FireTime;
var float RechargeTime;

var bool bFromTimer;

var MaterialImpactEffect VehicleHitEffect;

/** interpolation speeds for zoom in/out when firing */
var() protected float ZoomInInterpSpeed;
var() protected float ZoomOutInterpSpeed;
var float MinZoomFOV, MaxZoomFOV;
var float MinZoomDist, MaxZoomDist;

/** UTPawns the beam hit within the last FireInterval - don't allow damaging this again until the full FireInterval expires (instead of per tick)
 * so that players with superhealth or armor can escape a beam that sweeps over them
 */
var array<UTPawn> RecentHitPawns;

simulated static function MaterialImpactEffect GetImpactEffect(Actor HitActor, PhysicalMaterial HitMaterial, byte FireModeNum)
{
	return (FireModeNum == 0 && (HitActor != None) && !HitActor.bStatic) ? default.VehicleHitEffect : Super.GetImpactEffect(HitActor, HitMaterial, FireModeNum);
}

simulated event float GetPowerPerc()
{
	return 1.0;
}

reliable client function ClientStopBeamFiring();

function StopBeamFiring();


/*********************************************************************************************
 * State WeaponFiring
 * See UTWeapon.WeaponFiring
 *********************************************************************************************/

simulated state WeaponBeamFiring
{
	simulated event float GetPowerPerc()
	{
		return (1.0 - GetTimerCount('FiringDone') / GetTimerRate('FiringDone'));
	}

	simulated function ProcessInstantHit( byte FiringMode, ImpactInfo Impact )
	{
		local UTPawn P;
		local UTPlayerController PC;

		if (Impact.HitActor != None)
		{
			//damage small things each tick that have not already been damaged this timed refire; large things are easier to hit so they take damage
			P = UTPawn(Impact.HitActor);
			if (bFromTimer || UTProjectile(Impact.HitActor) != None || (P != None && RecentHitPawns.Find(P) == INDEX_NONE))
			{
				Impact.HitActor.TakeDamage( InstantHitDamage[0], Instigator.Controller,	Impact.HitLocation,
								InstantHitMomentum[0] * Impact.RayDir,	InstantHitDamageTypes[0], Impact.HitInfo, self );
				if (P != None)
				{
					RecentHitPawns[RecentHitPawns.length] = P;
					// reset timer so delay between hitting the same Pawn twice is consistent
					SetTimer(GetFireInterval(CurrentFireMode), true, 'RefireCheckTimer');
				}
			}

			//update zoom based on target distance
			PC = UTPlayerController(Instigator.Controller);
			if (PC != None && PC.IsLocalPlayerController() && PC.ViewTarget == Instigator)
			{
				ZoomedTargetFOV = MinZoomFOV + (MaxZoomFOV - MinZoomFOV) * FClamp((VSize(Location - Impact.HitLocation) - MinZoomDist)/(MaxZoomDist - MinZoomDist), 0.0, 1.0);
				PC.StartZoomNonlinear(ZoomedTargetFOV, ZoomInInterpSpeed);
			}
		}
	}

	reliable client function ClientStopBeamFiring()
	{
		if ( Role < ROLE_Authority )
		{
			FiringDone();
		}
	}

	function StopBeamFiring()
	{
		ClientStopBeamFiring();
		FiringDone();
	}

	simulated function RefireCheckTimer()
	{
		// clear recent list, so those targets can be hit again
		RecentHitPawns.length = 0;

		bFromTimer = true;
		InstantFire();
		bFromTimer = false;
	}

	/**
	 * Update the beam and handle the effects
	 */
	simulated function Tick(float DeltaTime)
	{
		// Retrace everything and see if there is a new LinkedTo or if something has changed.
		InstantFire();
	}

	/**
	 * In this weapon, RefireCheckTimer consumes ammo and deals out health/damage.  It's not
	 * concerned with the effects.  They are handled in the tick()
	 */
	simulated function FiringDone()
	{
		Gotostate('WeaponBeamRecharging');
	}

	simulated function EndFire(byte FireModeNum)
	{
		Global.EndFire(FireModeNum);
	}

	simulated function BeginState( Name PreviousStateName )
	{
		InstantFire();
		SetTimer(FireTime, false, 'FiringDone');
		TimeWeaponFiring(CurrentFireMode);
	}


	/**
	 * When leaving the state, shut everything down
	 */
	simulated function EndState(Name NextStateName)
	{
		local UTPlayerController PC;

		ClearTimer('FiringDone');
		ClearTimer('RefireCheckTimer');
		ClearFlashLocation();
		RecentHitPawns.length = 0;

		PC = UTPlayerController(Instigator.Controller);
		if ( (PC != None) && (LocalPlayer(PC.Player) != None) )
		{
			PC.EndZoomNonlinear(ZoomOutInterpSpeed);
		}

		super.EndState(NextStateName);
	}

	simulated function bool IsFiring()
	{
		return true;
	}
}

simulated state WeaponBeamRecharging
{
	simulated event float GetPowerPerc()
	{
		return GetTimerCount('RechargeDone') / GetTimerRate('RechargeDone');
	}

	simulated function BeginState( Name PreviousStateName )
	{
		local UTPawn UTP;
		
		UTP = UTPawn(MyVehicle.Driver);
		if (UTP != None)
		{
			SetTimer(RechargeTime * UTP.FireRateMultiplier, false, 'RechargeDone');
		}
		else
		{
			SetTimer(RechargeTime, false, 'RechargeDone');
		}
	}

	simulated function EndState( Name PreviousStateName )
	{
		ClearTimer( 'RechargeDone' );
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
   FireTime=1.500000
   RechargeTime=1.500000
   VehicleHitEffect=(DurationOfDecal=4.000000,DecalDissolveParamName="DissolveAmount",ParticleTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_Beam_Impact_Damage')
   ZoomInInterpSpeed=6.000000
   ZoomOutInterpSpeed=3.000000
   MinZoomFOV=55.000000
   MaxZoomFOV=22.000000
   MinZoomDist=1200.000000
   MaxZoomDist=7000.000000
   FireTriggerTags(0)="MainTurretFire"
   DefaultImpactEffect=(ParticleTemplate=ParticleSystem'VH_DarkWalker.Effects.P_VH_DarkWalker_Beam_Impact')
   VehicleClass=Class'UTGameContent.UTVehicle_DarkWalker_Content'
   AmmoDisplayType=EAWDS_BarGraph
   ZoomedTargetFOV=22.000000
   WeaponFireSnd(0)=SoundCue'A_Vehicle_DarkWalker.Cue.A_Vehicle_DarkWalker_FireBeamCue'
   AimingHelpRadius(0)=60.000000
   WeaponFireTypes(1)=EWFT_None
   FiringStatesArray(0)="WeaponBeamFiring"
   FireInterval(0)=0.400000
   InstantHitDamage(0)=120.000000
   InstantHitMomentum(0)=60000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_DarkWalkerTurretBeam'
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="DarkWalker"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_DarkWalkerTurret"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
