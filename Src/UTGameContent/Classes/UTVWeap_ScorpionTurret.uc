/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_ScorpionTurret extends UTVehicleWeapon
	HideDropDown;

var class<UTProj_ScorpionGlob_Base> TeamProjectiles[2];

/**
 * GetAdjustedAim begins a chain of function class that allows the weapon, the pawn and the controller to make
 * on the fly adjustments to where this weapon is pointing.
 */
simulated function Rotator GetAdjustedAim( vector StartFireLoc )
{
	local rotator R;

	// Start the chain, see Pawn.GetAdjustedAimFor()
	R = Instigator.GetAdjustedAimFor( Self, StartFireLoc );

	if ( PlayerController(Instigator.Controller) != None )
	{
		R.Pitch = R.Pitch & 65535;
		if ( R.Pitch < 16384 )
		{
			R.Pitch += (16384 - R.Pitch)/16;
		}
		else if ( R.Pitch > 49152 )
		{
			R.Pitch += 1024;
		}
	}
	else
	{
		// due to the way SuggestTossVelocity() tests in increments combined with the high projectile speed,
		// the bots tend to overshoot just a tiny bit, so we nudge their aim down a little here
		R.Pitch -= 100;
	}

	return R;
}

simulated function Projectile ProjectileFire()
{
	if(Role==ROLE_Authority)
	{
		WeaponProjectiles[0] = TeamProjectiles[(MyVehicle.GetTeamNum()==1)?1:0];
	}
	return super.ProjectileFire();
}

defaultproperties
{
   TeamProjectiles(0)=Class'UTGameContent.UTProj_ScorpionGlob_Red'
   TeamProjectiles(1)=Class'UTGameContent.UTProj_ScorpionGlob'
   VehicleClass=Class'UTGameContent.UTVehicle_Scorpion_Content'
   bFastRepeater=True
   IconX=382
   IconY=82
   IconWidth=27
   IconHeight=42
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_AltFire'
   WeaponColor=(B=64,G=255,R=64,A=255)
   PlayerViewOffset=(X=11.000000,Y=7.000000,Z=-9.000000)
   aimerror=650.000000
   WeaponFireTypes(0)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_ScorpionGlob'
   FireInterval(0)=0.650000
   FireOffset=(X=19.000000,Y=10.000000,Z=-10.000000)
   WeaponRange=7000.000000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Scorpion"
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_ScorpionTurret"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
