/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_BioRifle_Content extends UTWeapon;

/** maximum number of globs we can load for one shot */
var int MaxGlobStrength;

var int GlobStrength;

var SoundCue WeaponLoadSnd;

var float AdditionalCoolDownTime;
var float CoolDownTime;

/** Array of all the animations for the various primary fires*/
var array<name> PrimaryFireAnims; // special case for Bio; if this needs to be promoted perhaps an array of arrays?

/** arm animations corresponding to above*/
var array<name> PrimaryArmAnims;

/** the primary fire animation currently playing */
var int CurrentFireAnim;

var ParticleSystemComponent ChargingSystem;
var name WeaponChargeAnim;
var name ArmsChargeAnim;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	SkeletalMeshComponent(Mesh).AttachComponentToSocket(ChargingSystem,MuzzleFlashSocket);
}
/*********************************************************************************************
 * Hud/Crosshairs
 *********************************************************************************************/

simulated event float GetPowerPerc()
{
	return 0.0;
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
	}

	return R;
}

/**
 * Take the projectile spawned and if it's the proper type, adjust it's strength and speed
 */
simulated function Projectile ProjectileFire()
{
	local Projectile SpawnedProjectile;

	SpawnedProjectile = super.ProjectileFire();
	if ( UTProj_BioGlob(SpawnedProjectile) != None )
	{
		UTProj_BioGlob(SpawnedProjectile).InitBio(self, GlobStrength);
	}

	return SpawnedProjectile;
}

/**
 * Tells the weapon to play a firing sound (uses CurrentFireMode)
 */
simulated function PlayFiringSound()
{
	if (CurrentFireMode<WeaponFireSnd.Length)
	{
		// play weapon fire sound
		if ( WeaponFireSnd[CurrentFireMode] != None )
		{
			MakeNoise(1.0);
			if(CurrentFireMode == 1 && GetPowerPerc() > 0.75)
			{
				WeaponPlaySound( WeaponFireSnd[2] );
			}
			else
			{
				WeaponPlaySound( WeaponFireSnd[CurrentFireMode] );
			}
		}
	}
}
/*********************************************************************************************
 * State WeaponLoadAmmo
 * In this state, ammo will continue to load up until MAXLOADCOUNT has been reached.  It's
 * similar to the firing state
 *********************************************************************************************/

simulated state WeaponLoadAmmo
{
	simulated function WeaponEmpty();

	simulated event float GetPowerPerc()
	{
		local float p;
		p = float(GlobStrength) / float(MaxGlobStrength);
		p = FClamp(p,0.0,1.0);

		return p;
	}

	simulated function bool TryPutdown()
	{
		bWeaponPutDown = true;
		return true;
	}

	/**
	 * Adds a rocket to the count and uses up some ammo.  In Addition, it plays
	 * a sound so that other pawns in the world can here it.
	 */
	simulated function IncreaseGlobStrength()
	{
		if (GlobStrength < MaxGlobStrength && HasAmmo(CurrentFireMode))
		{
			// Add the glob
			GlobStrength++;
			ConsumeAmmo(CurrentFireMode);
		}
	}

	function bool IsFullyCharged()
	{
		return (GlobStrength >= MaxGlobStrength);
	}

	/**
	 * Fire off a shot w/ effects
	 */
	simulated function WeaponFireLoad()
	{
		ProjectileFire();
		PlayFiringSound();
		InvManager.OwnerEvent('FiredWeapon');
	}

	/**
	 * This is the timer event for each shot
	 */
	simulated event RefireCheckTimer()
	{
		IncreaseGlobStrength();
	}

	simulated function SendToFiringState( byte FireModeNum )
	{
		return;
	}


	/**
	 * We need to override EndFire so that we can correctly fire off the
	 * current load if we have any.
	 */
	simulated function EndFire(byte FireModeNum)
	{
		Global.EndFire(FireModeNum);

		if (FireModeNum == CurrentFireMode)
		{
			// Fire the load
			ChargingSystem.DeactivateSystem();

			WeaponFireLoad();

			// Cool Down
			AdditionalCoolDownTime = GetTimerRate('RefireCheckTimer') - GetTimerCount('RefireCheckTimer');
			GotoState('WeaponCoolDown');
		}
	}

	/**
	 * Initialize the loadup
	 */
	simulated function BeginState(Name PreviousStateName)
	{
		local UTPawn POwner;
		local UTAttachment_BioRifle ABio;

		GlobStrength = 0;

		super.BeginState(PreviousStateName);

		POwner = UTPawn(Instigator);
		if (POwner != None)
		{
			POwner.SetWeaponAmbientSound(WeaponLoadSnd);
			ABio = UTAttachment_BioRifle(POwner.CurrentWeaponAttachment);
			if(ABio != none)
			{
				ABio.StartCharging();
			}
		}
		ChargingSystem.ActivateSystem();
		PlayWeaponAnimation( WeaponChargeAnim, MaxGlobStrength*FireInterval[1], false);
		PlayArmAnimation(ArmsChargeAnim, MaxGlobStrength*FireInterval[1],false);
	}

	/**
	 * Insure that the GlobStrength is 1 when we leave this state
	 */
	simulated function EndState(Name NextStateName)
	{
		local UTPawn POwner;

		Cleartimer('RefireCheckTimer');

		GlobStrength = 1;

		POwner = UTPawn(Instigator);
		if (POwner != None)
		{
			POwner.SetWeaponAmbientSound(None);
			POwner.SetFiringMode(0); // return to base fire mode for network anims
		}
		ChargingSystem.DeactivateSystem();

		Super.EndState(NextStateName);
	}

	simulated function bool IsFiring()
	{
		return true;
	}

	/**
	 * This determines whether or not the Weapon can have ViewAcceleration when Firing.
	 *
	 * When you are FULLY charged up and running around the level looking for someone to Glob,
	 * you need to be able to view accelerate
	 **/
	simulated function bool CanViewAccelerationWhenFiring()
	{
		return( GlobStrength == MaxGlobStrength );
	};


Begin:
	IncreaseGlobStrength();
	TimeWeaponFiring(CurrentFireMode);

}

simulated function PlayFireEffects( byte FireModeNum, optional vector HitLocation )
{
	if(FireModeNum == 0)
	{
		CurrentFireAnim = (CurrentFireAnim+1)%(PrimaryFireAnims.Length);
		WeaponFireAnim[0] = PrimaryFireAnims[CurrentFireAnim];
		ArmFireAnim[0] = PrimaryArmAnims[CurrentFireAnim];
	}
	super.PlayFireEffects(FireModeNum,HitLocation);
}

simulated state WeaponCoolDown
{
	simulated function WeaponCooled()
	{
		GotoState('Active');
	}

	simulated function EndState(name NextStateName)
	{
		ClearFlashCount();
		ClearFlashLocation();

		ClearTimer('WeaponCooled');
		super.EndState(NextStateName);
	}

begin:
	SetTimer(CoolDownTime + AdditionalCoolDownTime,false,'WeaponCooled');
}

simulated function WeaponCooled()
{
	LogInternal("BioRifle: Weapon Cooled outside WeaponCoolDown, is in"@GetStateName());
}

// AI Interface
function float GetAIRating()
{
	local UTBot B;
	local float EnemyDist;
	local vector EnemyDir;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	// if retreating, favor this weapon
	EnemyDir = B.Enemy.Location - Instigator.Location;
	EnemyDist = VSize(EnemyDir);
	if ( EnemyDist > 1500 )
		return 0.1;
	if ( B.IsRetreating() )
		return (AIRating + 0.4);
	if ( (B.Enemy.Weapon != None) && B.Enemy.Weapon.bMeleeWeapon )
		return (AIRating + 0.35);
	if ( -1 * EnemyDir.Z > EnemyDist )
		return AIRating + 0.1;
	if ( EnemyDist > 1000 )
		return 0.35;
	return AIRating;
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	if ( FRand() < 0.8 )
		return 0;
	return 1;
}

function float SuggestAttackStyle()
{
	local UTBot B;
	local float EnemyDist;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0.4;

	EnemyDist = VSize(B.Enemy.Location - Instigator.Location);
	if ( EnemyDist > 1500 )
		return 1.0;
	if ( EnemyDist > 1000 )
		return 0.4;
	return -0.4;
}

function float SuggestDefenseStyle()
{
	local UTBot B;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if ( VSize(B.Enemy.Location - Instigator.Location) < 1600 )
		return -0.6;
	return 0;
}

defaultproperties
{
   MaxGlobStrength=10
   GlobStrength=1
   WeaponLoadSnd=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireAltChamber_Cue'
   CoolDowntime=0.330000
   PrimaryFireAnims(0)="WeaponFire1"
   PrimaryFireAnims(1)="WeaponFire2"
   PrimaryFireAnims(2)="WeaponFire3"
   PrimaryArmAnims(0)="WeaponFire1"
   PrimaryArmAnims(1)="WeaponFire2"
   PrimaryArmAnims(2)="WeaponFire3"
   Begin Object Class=ParticleSystemComponent Name=ChargePart ObjName=ChargePart Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_Alt_MF'
      bAutoActivate=False
      DepthPriorityGroup=SDPG_Foreground
      Name="ChargePart"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   ChargingSystem=ChargePart
   WeaponChargeAnim="WeaponAltCharge"
   ArmsChargeAnim="WeaponAltCharge"
   AmmoCount=25
   LockerAmmoCount=50
   MaxAmmoCount=50
   IconX=382
   IconY=82
   IconWidth=27
   IconHeight=42
   IconCoordinates=(V=399.000000,UL=128.000000,VL=62.000000)
   CrossHairCoordinates=(V=0.000000)
   InventoryGroup=3
   AttachmentClass=Class'UTGame.UTAttachment_BioRifle'
   GroupWeight=0.510000
   QuickPickGroup=1
   QuickPickWeight=0.800000
   WeaponFireAnim(0)="WeaponFire1"
   WeaponFireAnim(1)="WeaponAltFire"
   ArmFireAnim(0)="WeaponFire1"
   ArmFireAnim(1)="WeaponAltFire"
   ArmsAnimSet=AnimSet'WP_BioRifle.Anims.K_WP_BioRifle_Arms'
   WeaponFireSnd(0)=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireMain_Cue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireAltLarge_Cue'
   WeaponFireSnd(2)=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_FireAltSmall_Cue'
   WeaponPutDownSnd=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_Lower_Cue'
   WeaponEquipSnd=SoundCue'A_Weapon_BioRifle.Weapon.A_BioRifle_Raise_Cue'
   WeaponColor=(B=64,G=255,R=64,A=255)
   MuzzleFlashSocket="Bio_MF"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_BioRifle.Particles.P_WP_Bio_MF'
   PlayerViewOffset=(X=-1.000000,Y=-2.000000,Z=0.000000)
   LockerRotation=(Pitch=0,Yaw=0,Roll=-16384)
   CurrentRating=0.550000
   WeaponFireTypes(0)=EWFT_Projectile
   FiringStatesArray(1)="WeaponLoadAmmo"
   WeaponProjectiles(0)=Class'UTGameContent.UTProj_BioShot'
   WeaponProjectiles(1)=Class'UTGameContent.UTProj_BioGlob'
   FireInterval(0)=0.350000
   FireInterval(1)=0.350000
   EquipTime=0.800000
   FireOffset=(X=19.000000,Y=10.000000,Z=-10.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'WP_BioRifle.Mesh.SK_WP_BioRifle_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTWeap_BioRifle_Content:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_BioRifle.Anims.K_WP_BioRifle_Base'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Priority=3.100000
   AIRating=0.550000
   ItemName="Bio-Fucile"
   MaxDesireability=0.750000
   PickupMessage="Bio-Fucile"
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_CGBio_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_BioRifle.Mesh.SK_WP_BioRifle_3P_Mid'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Components(0)=ChargePart
   DrawScale3D=(X=1.000000,Y=1.050000,Z=1.000000)
   Name="Default__UTWeap_BioRifle_Content"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
