/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTVWeap_LeviathanTurretShock extends UTVWeap_LeviathanTurretBase
		HideDropDown;


simulated function Projectile ProjectileFire()
{
	local UTProj_LeviathanShockBall ShockBall;

	ShockBall = UTProj_LeviathanShockBall(Super.ProjectileFire());
	if (ShockBall != None)
	{
		ShockBall.InstigatorWeapon = self;
		AimingTraceIgnoredActors[AimingTraceIgnoredActors.length] = ShockBall;
	}
	return ShockBall;
}

defaultproperties
{
   FireTriggerTags(0)="TurretShockMF"
   VehicleClass=Class'UTGameContent.UTVehicle_Leviathan_Content'
   WeaponFireSnd(0)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireCue'
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_LeviathanShockBall'
   FireInterval(0)=0.500000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Torretta Shock"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVWeap_LeviathanTurretBase:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_LeviathanTurretShock"
   ObjectArchetype=UTVWeap_LeviathanTurretBase'UTGame.Default__UTVWeap_LeviathanTurretBase'
}
