/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_HellBenderPrimary extends UTVehicleWeapon
	HideDropDown;

var float	LastFireTime;
var float   ReChargeTime;


/**
  * returns true if should pass trace through this hitactor
  * turret ignores shock balls fired by hellbender driver
  */
simulated function bool PassThroughDamage(Actor HitActor)
{
	return HitActor.IsA('UTProj_VehicleShockBall') || HitActor.IsA('Trigger') || HitActor.IsA('TriggerVolume');
}

simulated function InstantFire()
{
	Super.InstantFire();
	LastFireTime = WorldInfo.TimeSeconds;
}

simulated function ProcessInstantHit( byte FiringMode, ImpactInfo Impact )
{
	local float DamageMod;

	DamageMod = FClamp( (WorldInfo.TimeSeconds - LastFireTime), 0, RechargeTime);
	DamageMod = FClamp( (DamageMod / 3), 0.05, 1.0);

	// cause damage to locally authoritative actors
	if (Impact.HitActor != None && Impact.HitActor.Role == ROLE_Authority)
	{
		Impact.HitActor.TakeDamage(	InstantHitDamage[CurrentFireMode] * DamageMod,
									Instigator.Controller,
									Impact.HitLocation,
									InstantHitMomentum[FiringMode] * Impact.RayDir,
									InstantHitDamageTypes[FiringMode],
									Impact.HitInfo,
									self );
	}
}

defaultproperties
{
   RechargeTime=3.000000
   FireTriggerTags(0)="BackTurretFire"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue',ParticleTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_SecondImpact')
   VehicleClass=Class'UTGameContent.UTVehicle_HellBender_Content'
   bFastRepeater=True
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=20.000000
   ZoomedRate=60.000000
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Hellbender.SoundCues.A_Vehicle_Hellbender_TurretFire'
   WeaponFireTypes(1)=EWFT_None
   FireInterval(0)=0.500000
   InstantHitDamage(0)=180.000000
   InstantHitMomentum(0)=75000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_HellBenderPrimary'
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Hellbender Cannoniere"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_HellBenderPrimary"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
