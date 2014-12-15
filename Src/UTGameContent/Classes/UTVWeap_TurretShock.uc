/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_TurretShock extends UTVehicleWeapon
		HideDropDown;


simulated function Projectile ProjectileFire()
{
	local UTProj_TurretShockBall ShockBall;

	ShockBall = UTProj_TurretShockBall(Super.ProjectileFire());
	if (ShockBall != None)
	{
		ShockBall.InstigatorWeapon = self;
		AimingTraceIgnoredActors[AimingTraceIgnoredActors.length] = ShockBall;
	}
	return ShockBall;
}

defaultproperties
{
   FireTriggerTags(0)="TurretFireRight"
   FireTriggerTags(1)="TurretFireLeft"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue',ParticleTemplate=ParticleSystem'VH_Hellbender.Effects.P_VH_Hellbender_PrimeAltImpact')
   VehicleClass=Class'UTGameContent.UTVehicle_ShieldedTurret_Shock'
   bZoomedFireMode(0)=0
   bZoomedFireMode(1)=1
   ZoomedTargetFOV=20.000000
   ZoomedRate=60.000000
   WeaponFireSnd(0)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireCue'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponFireTypes(1)=EWFT_None
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_TurretShockBall'
   FireInterval(0)=0.500000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Torretta Shock"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_TurretShock"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
