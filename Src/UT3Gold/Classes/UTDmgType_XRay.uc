/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTDmgType_XRay extends UTDamageType
	abstract;



static function bool ShouldGib(UTPawn DeadPawn)
{
	// Don't gib!
	return false;
}

defaultproperties
{
   DamageBodyMatColor=(R=50.000000,G=50.000000,B=50.000000,A=1.000000)
   DamageOverlayTime=0.000000
   DeathOverlayTime=1.000000
   bLeaveBodyEffect=True
   DamageWeaponFireMode=1
   DamageCameraAnim=CameraAnim'Camera_FX.LinkGun.C_WP_Link_Beam_Hit'
   bArmorStops=False
   bCausesBlood=False
   bIgnoreDriverDamageMult=True
   KDamageImpulse=100.000000
   VehicleDamageScaling=0.200000
   VehicleMomentumScaling=0.100000
   Name="Default__UTDmgType_XRay"
   ObjectArchetype=UTDamageType'UTGame.Default__UTDamageType'
}
