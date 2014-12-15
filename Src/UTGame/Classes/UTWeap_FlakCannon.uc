/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTWeap_FlakCannon extends UTWeapon
native;

var float SpreadDist;
var UTSkeletalMeshComponent SkeletonFirstPersonMesh;

var int curTensOdometer;
var int curOnesOdometer;
var float OdometerMaxPerSecOnes;
var float OdometerMaxPerSecTens;
var name OnesPlaceSkelName;
var name TensPlaceSkelName;
var class<Projectile> CenterShardClass;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function Projectile ProjectileFire()
{
	local vector		RealStartLoc;
	local UTProj_FlakShell	SpawnedProjectile;

	// tell remote clients that we fired, to trigger effects
	IncrementFlashCount();

	if( Role == ROLE_Authority )
	{
		// this is the location where the projectile is spawned.
		RealStartLoc = GetPhysicalFireStartLoc();

		// Spawn projectile
		SpawnedProjectile = Spawn(class'UTProj_FlakShell',,, RealStartLoc);
		if( SpawnedProjectile != None && !SpawnedProjectile.bDeleteMe )
		{
			SpawnedProjectile.Init( Vector(GetAdjustedAim( RealStartLoc )) );
		}

		// Return it up the line
		return SpawnedProjectile;
	}

	return None;
}

/**
 * GetAdjustedAim begins a chain of function class that allows the weapon, the pawn and the controller to make
 * on the fly adjustments to where this weapon is pointing.
 */
simulated function Rotator GetAdjustedAim( vector StartFireLoc )
{
	local rotator R;

	// Start the chain, see Pawn.GetAdjustedAimFor()
	if( Instigator != None )
	{
		R = Instigator.GetAdjustedAimFor( Self, StartFireLoc );

		if ( (PlayerController(Instigator.Controller) != None) && (CurrentFireMode == 1) )
		{
			R.Pitch = R.Pitch & 65535;
			if ( R.Pitch < 16384 )
			{
				R.Pitch += (16384 - R.Pitch)/32;
			}
			else if ( R.Pitch > 49152 )
			{
				R.Pitch += 512;
			}
		}
	}

	return R;
}

simulated event ReplicatedEvent(name VarName)
{
	if ( VarName == 'AmmoCount')
	{
		UpdateAmmoCount();
	}

	Super.ReplicatedEvent(VarName);
}

simulated state WeaponFiring
{
	simulated event ReplicatedEvent(name VarName)
	{
		if ( VarName == 'AmmoCount')
		{
			UpdateAmmoCount();
		}
		Super.ReplicatedEvent(VarName);
	}
}

function int AddAmmo( int Amount )
{
	local int rvalue;
	rvalue = super.AddAmmo(Amount);
	UpdateAmmoCount();
	return rvalue;
}

simulated function HideFlakCannonAmmo()
{
    local SkelControlSingleBone SkelControl;
    if (AmmoCount <= 1)
    {
	    //Hide the flak cannon ammo in the chamber
	    SkelControl = SkelControlSingleBone(SkeletonFirstPersonMesh.FindSkelControl('AmmoScale'));
	    if(SkelControl != none)
	    {
	    	SkelControl.SetSkelControlStrength(1.0f, 0.0f);
	    }
    }
}

simulated function UpdateAmmoCount()
{
	local SkelControlSingleBone SkelControl;
	local int AmmoCountOnes;
	local int AmmoCountTens;

	if(Instigator.IsHumanControlled() && Instigator.IsLocallyControlled())
	{
		AmmoCountOnes = AmmoCount%10;
		AmmoCountTens = (AmmoCount - AmmoCountOnes)/10;
		SkelControl = SkelControlSingleBone(SkeletonFirstPersonMesh.FindSkelControl('OnesDisplay'));
		if(SkelControl != none)
		{
			SkelControl.BoneRotation.Pitch = -AmmoCountOnes*6554;
		}
		SkelControl = SkelControlSingleBone(SkeletonFirstPersonMesh.FindSkelControl('TensDisplay'));
		if(SkelControl != none)
		{
			SkelControl.BoneRotation.Pitch = -AmmoCountTens*6554;
		}

	    if (AmmoCount == 1)
    	{
		    //Hide the flak cannon ammo in the chamber
		    //Delay the hiding a fraction of time so the user doesn't see it happen	(time from anim)
	    	SetTimer(0.40f, false, 'HideFlakCannonAmmo');
    	}
    	else if (AmmoCount > 1)
    	{
	    	//Show the flak cannon ammo in the chamber
	    	ClearTimer('HideFlakCannonAmmo');
		    SkelControl = SkelControlSingleBone(SkeletonFirstPersonMesh.FindSkelControl('AmmoScale'));
	    	if(SkelControl != none)
	    	{
	    		SkelControl.SetSkelControlStrength(0.0f, 0.0f);
    		}
	    }
    }
}

simulated function CustomFire()
{
	local int i,j;
   	local vector RealStartLoc, AimDir, YDir, ZDir;
	local Projectile Proj;
	local class<Projectile> ShardProjectileClass;
	local float Mag;

	IncrementFlashCount();

	if (Role == ROLE_Authority)
	{
		// this is the location where the projectile is spawned
		RealStartLoc = GetPhysicalFireStartLoc();
		// get fire aim direction
		GetAxes(GetAdjustedAim(RealStartLoc),AimDir, YDir, ZDir);

		// special center shard
		Proj = Spawn(CenterShardClass,,, RealStartLoc);
		if (Proj != None)
		{
			Proj.Init(AimDir);
		}

		// one shard in each of 9 zones (except center)
		ShardProjectileClass = GetProjectileClass();
		for ( i=-1; i<2; i++)
		{
			for ( j=-1; j<2; j++ )
			{
				if ( (i != 0) || (j != 0) )
				{
					Mag = (abs(i)+abs(j) > 1) ? 0.7 : 1.0;
					Proj = Spawn(ShardProjectileClass,,, RealStartLoc);
					if (Proj != None)
					{
						Proj.Init(AimDir + (0.3 + 0.7*FRand())*Mag*i*SpreadDist*YDir + (0.3 + 0.7*FRand())*Mag*j*SpreadDist*ZDir );
					}
				}
			}
	    }
	}
}

//-----------------------------------------------------------------
// AI Interface

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	local vector EnemyDir;
	local float EnemyDist;
	local UTBot B;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 750 )
	{
		if ( EnemyDir.Z < -0.5 * EnemyDist )
			return 1;
		return 0;
	}
	else if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return 0;
	else if ( (EnemyDist < 400) || (EnemyDir.Z > 30) )
		return 0;
	else if ( FRand() < 0.65 )
		return 1;
	return 0;
}

function float GetAIRating()
{
	local UTBot B;
	local float EnemyDist;
	local vector EnemyDir;

	B = UTBot(Instigator.Controller);
	if ( B == None )
		return AIRating;

	if ( UTOnslaughtPowerNode(B.Focus) != None )
	{
		EnemyDist = VSize(B.FocalPoint - Instigator.Location);
		if (EnemyDist < 1250.0)
		{
			return 0.9;
		}
		return AIRating * 1500.0/EnemyDist;
	}

	if ( B.Enemy == None )
		return AIRating;

	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 750 )
	{
		if ( EnemyDist > 1700 )
		{
			if ( EnemyDist > 2500 )
				return 0.2;
			return (AIRating - 0.3);
		}
		if ( EnemyDir.Z < -0.5 * EnemyDist )
			return (AIRating - 0.3);
	}
	else if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return (AIRating + 0.35);
	else if ( EnemyDist < 400 )
		return (AIRating + 0.2);
	return FMax(AIRating + 0.2 - (EnemyDist - 400) * 0.0008, 0.2);
}

function float SuggestAttackStyle()
{
	if ( (AIController(Instigator.Controller) != None)
		&& (AIController(Instigator.Controller).Skill < 3) )
		return 0.4;
    return 0.8;
}

simulated state WeaponEquipping
{
	/**
	 * We want to being this state by setting up the timing and then notifying the pawn
	 * that the weapon has changed.
	 */

	simulated function BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);

		if (Instigator.IsLocallyControlled() && Instigator.IsHumanControlled())
		{
			UpdateAmmoCount();
		}
	}

}
function float SuggestDefenseStyle()
{
	return -0.4;
}

function float GetOptimalRangeFor(Actor Target)
{
	// short range so bots try to maximize shards that hit
	return 750.0;
}

defaultproperties
{
   SpreadDist=0.100000
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      FOV=70.000000
      SkeletalMesh=SkeletalMesh'WP_FlakCannon.Mesh.SK_WP_FlakCannon_1P'
      AnimTreeTemplate=AnimTree'WP_FlakCannon.Anims.AT_FlakCannon'
      AnimSets(0)=AnimSet'WP_FlakCannon.Anims.K_WP_FlakCannon_1P_Base'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   SkeletonFirstPersonMesh=FirstPersonMesh
   OdometerMaxPerSecOnes=21845.000000
   OdometerMaxPerSecTens=10950.000000
   OnesPlaceSkelName="OnesDisplay"
   TensPlaceSkelName="TensDisplay"
   CenterShardClass=Class'UTGame.UTProj_FlakShardMain'
   bTargetFrictionEnabled=True
   bTargetAdhesionEnabled=True
   AmmoCount=10
   LockerAmmoCount=20
   MaxAmmoCount=30
   WeaponFireWaveForm=ForceFeedbackWaveform'UTGame.Default__UTWeap_FlakCannon:ForceFeedbackWaveformShooting1'
   IconX=394
   IconY=38
   IconWidth=60
   IconHeight=38
   IconCoordinates=(U=131.000000,V=429.000000,UL=132.000000,VL=52.000000)
   CrossHairCoordinates=(U=64.000000)
   InventoryGroup=7
   AttachmentClass=Class'UTGame.UTAttachment_FlakCannon'
   GroupWeight=0.500000
   QuickPickGroup=4
   QuickPickWeight=0.900000
   ArmsAnimSet=AnimSet'WP_FlakCannon.Anims.K_WP_FlakCannon_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_FireCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_FireAltCue'
   WeaponPutDownSnd=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_LowerCue'
   WeaponEquipSnd=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_RaiseCue'
   MaxPitchLag=500.000000
   MaxYawLag=500.000000
   WeaponColor=(B=128,G=255,R=255,A=255)
   MuzzleFlashPSCTemplate=ParticleSystem'WP_FlakCannon.Effects.P_WP_FlakCannon_Muzzle_Flash'
   MuzzleFlashLightClass=Class'UTGame.UTRocketMuzzleFlashLight'
   PlayerViewOffset=(X=-6.000000,Y=-4.000000,Z=0.500000)
   SmallWeaponsOffset=(X=12.000000,Y=6.000000,Z=-6.000000)
   LockerRotation=(Pitch=0,Yaw=0,Roll=-16384)
   CurrentRating=0.750000
   TargetFrictionDistanceMin=64.000000
   TargetFrictionDistancePeak=128.000000
   TargetFrictionDistanceMax=200.000000
   WeaponFireTypes(0)=EWFT_Custom
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGame.UTProj_FlakShard'
   WeaponProjectiles(1)=Class'UTGame.UTProj_FlakShell'
   FireInterval(0)=1.100000
   FireInterval(1)=1.100000
   EquipTime=0.750000
   FireOffset=(X=8.000000,Y=10.000000,Z=-10.000000)
   Mesh=FirstPersonMesh
   Priority=9.000000
   AIRating=0.750000
   ItemName="Cannone Flak"
   MaxDesireability=0.750000
   PickupMessage="Cannone Flak"
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Flak_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_FlakCannon.Mesh.SK_WP_FlakCannon_3P_Mid'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_FlakCannon"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
