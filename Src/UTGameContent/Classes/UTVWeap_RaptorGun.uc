/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_RaptorGun extends UTVehicleWeapon
	HideDropDown;

/** angle for locking for lock targets */
var float 				LockAim;

/** angle for locking for lock targets when on Console */
var float 				ConsoleLockAim;

/** How far out should we be considering actors for a lock */
var float		LockRange;

/** Sound Effects to play when Locking */
var SoundCue 			LockAcquiredSound;

/** Used to show lock symbol on crosshair */
var float LastLockTime;

/**
 * Access to HUD and Canvas.
 * Event always called when the InventoryManager considers this Inventory Item currently "Active"
 * (for example active weapon)
 *
 * @param	HUD			- HUD with canvas to draw on
 */
simulated function ActiveRenderOverlays( HUD H )
{
	local UTPlayerController PC;

	PC = UTPlayerController(Instigator.Controller);
	if ( (PC == None) || PC.bNoCrosshair )
	{
		return;
	}
	DrawWeaponCrosshair( H );
	if (WorldInfo.TimeSeconds - LastLockTime < 0.9 )
	{
		DrawLockedOn( H );
	}
	else
	{
		bWasLocked = false;
	}

}

simulated function Projectile ProjectileFire()
{
	local UTProj_RaptorRocket Rocket;
	local float BestAim, BestDist;
	local UTVehicle AimTarget;
	local UTPlayerController UTPC;

	Rocket = UTProj_RaptorRocket(Super.ProjectileFire());

	if ( Rocket != None )
	{
		UTPC = UTPlayerController(MyVehicle.Controller);
		BestAim	= ((UTPC != None) && UTPC.AimingHelp(true)) ? ConsoleLockAim : LockAim;
		AimTarget = UTVehicle(Instigator.Controller.PickTarget(class'UTHoverVehicle', BestAim, BestDist, Normal(Rocket.Velocity), Rocket.Location, LockRange));
		if (AimTarget != None && AimTarget.bHomingTarget)
		{
			Rocket.Seeking = AimTarget;
			ClientSetLock();
		}
	}

	return Rocket;
}

unreliable simulated client function ClientSetLock()
{
	LastLockTime = WorldInfo.TimeSeconds;
	if ( PlayerController(Instigator.Controller) != None )
	{
		PlayerController(Instigator.Controller).ClientPlaySound(LockAcquiredSound);
	}
}

simulated function float MaxRange()
{
	local float Range;

	// ignore missles for the range calculation
	if (bInstantHit)
	{
		Range = GetTraceRange();
	}
	if (WeaponProjectiles[0] != None)
	{
		Range = FMax(Range, WeaponProjectiles[0].static.GetRange());
	}
	return Range;
}

function class<Projectile> GetProjectileClass()
{
	if ( CurrentFireMode == 0)
	{
		if( Instigator.GetTeamNum() == 0 )
		{
			return class'UTProj_RaptorBoltRed';
		}
		else
		{
			return class'UTProj_RaptorBolt';
		}
	}
	else
	{
		if( Instigator.GetTeamNum() == 0 )
		{
			return class'UTProj_RaptorRocketRed';
		}
		else
		{
			return class'UTProj_RaptorRocket';
		}
	}
}

function byte BestMode()
{
	local UTBot Bot;

	Bot = UTBot(Instigator.Controller);
	if (Bot != None && UTVehicle(Bot.Enemy) != None && UTVehicle(Bot.Enemy).bHomingTarget && (FRand() < 0.3 + 0.1 * Bot.Skill))
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

defaultproperties
{
   LockAim=0.930000
   ConsoleLockAim=0.900000
   LockRange=15000.000000
   LockAcquiredSound=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_TargetLock'
   FireTriggerTags(0)="RaptorWeapon01"
   FireTriggerTags(1)="RaptorWeapon02"
   VehicleClass=Class'UTGameContent.UTVehicle_Raptor_Content'
   bFastRepeater=True
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_Fire'
   WeaponFireSnd(1)=SoundCue'A_Vehicle_Raptor.SoundCues.A_Vehicle_Raptor_AltFire'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_RaptorBolt'
   WeaponProjectiles(1)=Class'UTGameContent.UTProj_RaptorRocket'
   FireInterval(0)=0.200000
   FireInterval(1)=1.200000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Raptor"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_RaptorGun"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
