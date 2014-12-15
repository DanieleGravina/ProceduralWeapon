/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_LeviathanTurretRocket extends UTVWeap_LeviathanTurretBase
		HideDropDown;

var int RocketBurstSize;
var float RocketBurstInterval;
var int RemainingRockets;

simulated function FireAmmunition()
{
	if (CurrentFireMode == 0)
	{
		// Use ammunition to fire
		ConsumeAmmo( CurrentFireMode );

		RemainingRockets = RocketBurstSize;
		ActuallyFire();

		if (AIController(Instigator.Controller) != None)
		{
			AIController(Instigator.Controller).NotifyWeaponFired(self,CurrentFireMode);
		}
	}
}

simulated function ActuallyFire()
{
	RemainingRockets--;

	// if this is the local player, play the firing effects
	PlayFiringSound();

	ProjectileFire();

	if ( RemainingRockets > 0 )
	{
		SetTimer(RocketBurstInterval, false, 'ActuallyFire');
	}
}

defaultproperties
{
   RocketBurstSize=4
   RocketBurstInterval=0.150000
   FireTriggerTags(0)="TurretRocketMF"
   FireTriggerTags(1)="TurretRocketMF"
   FireTriggerTags(2)="TurretRocketMF"
   VehicleClass=Class'UTGameContent.UTVehicle_Leviathan_Content'
   WeaponFireSnd(0)=SoundCue'A_Weapon_RocketLauncher.Cue.A_Weapon_RL_Fire_Cue'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_LeviathanRocket'
   FireInterval(0)=2.000000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Torretta Razzo"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_LeviathanTurretRocket"
   ObjectArchetype=UTVWeap_LeviathanTurretBase'UTGame.Default__UTVWeap_LeviathanTurretBase'
}
