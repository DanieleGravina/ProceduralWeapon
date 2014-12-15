/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_Stinger extends UTWeapon;

var(Weapon) float WindDownTime[2];
var int WarmupShots[2];

var SoundCue WeaponLoadSnd;
var SoundCue WeaponSpinUpSnd[2];
var SoundCue WeaponSpinDownSnd[2];
var SoundCue WeaponWarmUpShotSnd;
var SoundCue WeaponFireStart;

var AudioComponent SpinningBarrelSound;
var SoundCue SpinningBarrelCue;

var name WeaponSpinUpAnims[2];
var name WeaponSpinDownAnims[2];
var name WeaponFireAnims[2];

/** spin up, down, and fire animations to match above for the arm mesh */
var name ArmSpinUpAnims[2];
var name ArmSpinDownAnims[2];
var name ArmFireAnims[2];

var int WarmupShotCount;
var float DesiredShotTime;

var ParticleSystemComponent PrimaryMuzzleFlashPSC;

var MaterialInstanceConstant WeaponMaterialInstance;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	// Atttach the muzzle flash
	SkeletalMeshComponent(Mesh).AttachComponentToSocket(PrimaryMuzzleFLashPSC, MuzzleFlashSocket);
}

/** Needed so when the function is called on this object it will be found and then because we are in a state that version will be used **/
simulated function FireWarmupShot();

simulated function SetSkin(Material NewMaterial)
{
	Super.SetSkin(NewMaterial);
	if( WorldInfo.NetMode != NM_DedicatedServer )
	{
		WeaponMaterialInstance = Mesh.CreateAndSetMaterialInstanceConstant(1);
	}
}

/*********************************************************************************************
 * state WindUp
 * The Minigun will first enter this state during the firing sequence.  It winds up the barrel
 *
 * Because we don't have animations or sounds, it just delays a bit then fires.
 *********************************************************************************************/

simulated state WeaponWindUp
{
	simulated function bool RefireCheck()
	{
		// if switching to another weapon, abort firing and put down right away
		if( bWeaponPutDown )
		{
			GotoState('WeaponWindDown');
			return false;
		}

		// If weapon should keep on firing, then do not leave state and fire again.
		if( ShouldRefire() )
		{
			return true;
		}

		// if out of ammo, then call weapon empty notification
		if( !HasAnyAmmo() )
		{
			GotoState('Active');
			WeaponEmpty();
			return false;
		}
		else
		{
			GotoState('WeaponWindDown');
			return false;
		}
	}

	simulated function WeaponWarmedUp()
	{
		if ( RefireCheck() )
			GotoState('WeaponFiring');
	}

	simulated function bool IsFiring()
	{
		return true;
	}

	simulated function FireWarmupShot()
	{
		local float NextShotTime;
		if ( WarmupShotCount >= WarmupShots[CurrentFireMode] )
		{
			GotoState('WeaponFiring');
		}
		else if ( RefireCheck() )
   		{
	   		FireAmmunition();
			WeaponPlaySound(WeaponWarmUpShotSnd);
			NextShotTime = FMax(0.001,((WarmupShots[CurrentFireMode]-WarmupShotCount)*0.16 + 1.1)*FireInterval[CurrentFireMode]+DesiredShotTime-WorldInfo.TimeSeconds);
   			SetTimer(NextShotTime,false,'FireWarmupShot');
			WarmupShotCount++;
			DesiredShotTime = WorldInfo.TimeSeconds + NextShotTime;
	   	}
	}

	simulated function BeginState(name PreviousStateName)
	{
		MuzzleFlashPSCTemplate = default.MuzzleFlashPSCTemplate;

   		Super.BeginState(PreviousStateName);

		ClearTimer('OnAnimEnd');
		if( WorldInfo.NetMode != NM_DedicatedServer )
		{
			WeaponMaterialInstance.SetScalarParameterValue('Stinger_Belt_Speed', 4.0);
		}
		ClearTimer('StopBeltPanner');
		PlayWeaponAnimation( WeaponSpinUpAnims[CurrentFireMode], 0.8, false );
		PlayArmAnimation( ArmSpinUpAnims[CurrentFireMode], 0.8);
   		WeaponPlaySound(WeaponSpinUpSnd[CurrentFireMode]);
		WarmupShotCount = 0;
		DesiredShotTime = WorldInfo.TimeSeconds;
	   	FireWarmupShot();
	}

	simulated function EndState(name NextStateName)
	{
		Super.EndState(NextStateName);
		ClearFlashLocation();
		ClearTimer('FireWarmupShot');	// Catchall just in case.
	}
}

/*********************************************************************************************
 * State WindDown
 * The Minigun enteres this state when it stops firing.  It slows the barrels down and when
 * done, goes active/down/etc.
 *
 * Because we don't have animations or sounds, it just delays a bit then exits
 *********************************************************************************************/

simulated state WeaponWindDown
{
	simulated function bool IsFiring()
	{
		return true;
	}

	simulated function Timer()
	{
		if ( bWeaponPutDown )
		{
			// if switched to another weapon, put down right away
			PutDownWeapon();
		}
		else
		{
			// Return to the active state
			GotoState('Active');
		}
	}
Begin:
	PlayWeaponAnimation( WeaponSpinDownAnims[CurrentFireMode], 1.5, false );
	PlayArmAnimation(ArmSpinDownAnims[CurrentFireMode], 1.5);
	SetTimer(1.2, FALSE, 'StopBeltPanner');
	WeaponPlaySound(WeaponSpinDownSnd[CurrentFireMode]);
	SetTimer(WindDownTime[CurrentFireMode],false);
}

simulated function StopBeltPanner()
{
	if( WorldInfo.NetMode != NM_DedicatedServer )
	{
		WeaponMaterialInstance.SetScalarParameterValue('Stinger_Belt_Speed', 0.0);
	}
}

simulated function PlayFiringSound()
{
	if(CurrentFireMode == 1)
	{
		WeaponPlaySound(WeaponFireSnd[CurrentFireMode]);
	}
	MakeNoise(1.0);
}

simulated state Active
{
	/** Initialize the weapon as being active and ready to go. */
	simulated function BeginState( Name PreviousStateName )
	{
		local int i;

		// When coming from wind down, allow animation to finish, and then call OnAnimEnd (which plays the idle anim)
		if(PreviousStateName == 'WeaponWindDown')
		{
			SetTimer(1.5, FALSE, 'OnAnimEnd');
		}
		else
		{
			OnAnimEnd(none, 0.f, 0.f);
		}

		if (bDebugWeapon)
		{
			LogInternal("---"@self@"has entered the Active State"@PreviousStateName);
		}

		// Check to see if we need to go down
		if( bWeaponPutDown )
		{
			PutDownWeapon();
		}
		else if ( !HasAnyAmmo() )
		{
			WeaponEmpty();
		}
		else
		{
			// if either of the fire modes are pending, perform them
			for( i=0; i<InvManager.PendingFire.Length; i++ )
			{
				if( PendingFire(i) )
				{
					BeginFire(i);
					DemoBeginFire(i);
					break;
				}
			}
		}

		if (InvManager != none && InvManager.LastAttemptedSwitchToWeapon != none)
		{
			if (InvManager.LastAttemptedSwitchToWeapon != self)
			{
				InvManager.LastAttemptedSwitchToWeapon.ClientWeaponSet(true);
			}
			InvManager.LastAttemptedSwitchToWeapon = none;
		}
	}
};

/*********************************************************************************************
 * State WeaponFiring
 * See UTWeapon.WeaponFiring
 *********************************************************************************************/

simulated state WeaponFiring
{
	/**
	 * Called when the weapon is done firing, handles what to do next.
	 * We override the default here so as to go to the WindDown state.
	 */

	simulated function RefireCheckTimer()
	{
		// if switching to another weapon, abort firing and put down right away
		if( bWeaponPutDown )
		{
			GotoState('WeaponWindDown');
			return;
		}

		// If weapon should keep on firing, then do not leave state and fire again.
		if( ShouldRefire() )
		{
			FireAmmunition();
			return;
		}

		// if out of ammo, then call weapon empty notification
		if( !HasAnyAmmo() )
		{
			GotoState('Active');
			WeaponEmpty();
		}
		else
		{
			GotoState('WeaponWindDown');
		}
	}

	simulated function BeginState(Name PreviousStateName)
	{
		local UTPawn POwner;

		MuzzleFlashPSCTemplate = none;

		super.BeginState(PreviousStateName);

		POwner = UTPawn(Instigator);
		if (POwner != None && CurrentFireMode == 0)
		{
			POwner.SetWeaponAmbientSound(WeaponFireSnd[CurrentFireMode]);
			WeaponPlaySound(WeaponFireStart);
		}

		if (CurrentFireMode == 0)
		{
			if (GetHand() != HAND_Hidden)
			{
				PrimaryMuzzleFlashPSC.ActivateSystem();
			}
			PlayWeaponAnimation(WeaponFireAnims[0],1.0, true); //GetFireInterval(0),true);
			PlayArmAnimation(ArmFireAnims[0],1.0,false,true);
		}
		else
		{
			PlayWeaponAnimation(WeaponFireAnims[1],1.0, true); //,GetFireInterval(1),true);
			PlayArmAnimation(ArmFireAnims[1],1.0,false,true);
		}

		if(SpinningBarrelSound == none)
		{
			SpinningBarrelsound = CreateAudioComponent(SpinningBarrelCue, false, true);
		}
		if(SpinningBarrelSound != none)
			SpinningBarrelSound.FadeIn(0.2f,1.0f);

	}

	simulated function EndState(Name NextStateName)
	{
		local UTPawn POwner;

		super.EndState(NextStateName);

		POwner = UTPawn(Instigator);
		if (POwner != None)
		{
			POwner.SetWeaponAmbientSound(None);
		}
		if(SpinningBarrelSound != none)
		{
				SpinningBarrelSound.FadeOut(0.2f,0.0f);
				SpinningBarrelSound=none;
		}

		PrimaryMuzzleFlashPSC.DeActivateSystem();
	}

	simulated function bool IsFiring()
	{
		return true;
	}



Begin:
	TimeWeaponFiring(CurrentFireMode);
}

/**
 * This function checks to see if the weapon has any ammo available for a given fire mode.
 *
 * @param	FireModeNum		- The Fire Mode to Test For
 * @param	Amount			- [Optional] Check to see if this amount is available.  If 0 it will default to checking
 *							  for the ShotCost
 */
simulated function bool HasAmmo( byte FireModeNum, optional int Amount )
{
	if (Amount==0)
		return (AmmoCount >= 1);
	else
		return ( AmmoCount >= Amount );
}

//-----------------------------------------------------------------
// AI Interface

function float GetAIRating()
{
	local UTBot B;

	B = UTBot(Instigator.Controller);
	if ( (B== None) || (B.Enemy == None) )
		return AIRating;

	if ( !B.LineOfSightTo(B.Enemy) )
		return AIRating - 0.15;

	return AIRating * FMin(Pawn(Owner).GetDamageScaling(), 1.5);
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	local float EnemyDist;
	local UTBot B;
	local UTPawn EnemyPawn;

	if ( IsFiring() )
		return CurrentFireMode;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if ( UTSlowVolume(B.Enemy.PhysicsVolume) != None )
	{
		return 1;
	}
	EnemyPawn = UTPawn(B.Enemy);
	if ( (EnemyPawn != None) && EnemyPawn.bHasSlowField )
	{
		return 1;
	}

	EnemyDist = VSize(B.Enemy.Location - Instigator.Location);
	if ( EnemyDist < 2000 )
		return 0;
	return 1;
}

defaultproperties
{
   WindDownTime(0)=0.270000
   WindDownTime(1)=0.330000
   WarmupShots(0)=5
   WarmupShots(1)=1
   WeaponSpinUpSnd(0)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_BarrelWindStartCue'
   WeaponSpinUpSnd(1)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_BarrelWindStartCue'
   WeaponSpinDownSnd(0)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_BarrelWindStopCue'
   WeaponSpinDownSnd(1)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_BarrelWindStopCue'
   WeaponWarmUpShotSnd=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_FireCue'
   SpinningBarrelCue=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_BarrelWindLoopCue'
   WeaponSpinUpAnims(0)="WeaponRampUp"
   WeaponSpinUpAnims(1)="WeaponRampUp"
   WeaponSpinDownAnims(0)="WeaponRampDown"
   WeaponSpinDownAnims(1)="WeaponRampDown"
   WeaponFireAnims(0)="WeaponFire"
   WeaponFireAnims(1)="WeaponFire-Secondary"
   ArmSpinUpAnims(0)="WeaponRampUp"
   ArmSpinUpAnims(1)="WeaponRampUp"
   ArmSpinDownAnims(0)="WeaponRampDown"
   ArmSpinDownAnims(1)="WeaponRampDown"
   ArmFireAnims(0)="WeaponFire"
   ArmFireAnims(1)="WeaponFire-Secondary"
   Begin Object Class=ParticleSystemComponent Name=MuzzleFlashComponent ObjName=MuzzleFlashComponent Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_Stinger.Particles.P_Stinger_MF_Primary'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      DepthPriorityGroup=SDPG_Foreground
      Name="MuzzleFlashComponent"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   PrimaryMuzzleFlashPSC=MuzzleFlashComponent
   bFastRepeater=True
   bTargetFrictionEnabled=True
   bTargetAdhesionEnabled=True
   AmmoCount=100
   LockerAmmoCount=150
   MaxAmmoCount=300
   ShotCost(1)=2
   IconX=273
   IconY=413
   IconWidth=84
   IconHeight=50
   IconCoordinates=(U=453.000000,V=508.000000,UL=147.000000,VL=52.000000)
   CrossHairCoordinates=(U=448.000000,V=0.000000)
   InventoryGroup=6
   AttachmentClass=Class'UTGame.UTAttachment_Stinger'
   GroupWeight=0.520000
   QuickPickGroup=6
   QuickPickWeight=0.900000
   WeaponFireAnim(0)=
   WeaponFireAnim(1)=
   ArmFireAnim(0)=
   ArmFireAnim(1)=
   ArmsAnimSet=AnimSet'WP_Stinger.Anims.K_WP_Stinger_1P_Arms'
   WeaponFireSnd(0)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_FireLoopCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_FireAltCue'
   WeaponPutDownSnd=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_LowerCue'
   WeaponEquipSnd=SoundCue'A_Weapon_Stinger.Weapons.A_Weapon_Stinger_RaiseCue'
   WeaponColor=(B=0,G=255,R=255,A=255)
   MuzzleFlashPSCTemplate=ParticleSystem'WP_Stinger.Particles.P_Stinger_MF_Primary_WarmUP'
   MuzzleFlashAltPSCTemplate=ParticleSystem'WP_Stinger.Particles.P_Stinger_MF_Alt_Fire'
   MuzzleFlashLightClass=Class'UTGame.UTStingerMuzzleFlashLight'
   PlayerViewOffset=(X=0.000000,Y=2.000000,Z=0.000000)
   WidescreenRotationOffset=(Pitch=0,Yaw=0,Roll=0)
   LockerRotation=(Pitch=0,Yaw=0,Roll=-16384)
   CurrentRating=0.710000
   aimerror=700.000000
   AimingHelpRadius(0)=8.500000
   AimingHelpRadius(1)=11.500000
   WeaponFireTypes(1)=EWFT_Projectile
   FiringStatesArray(0)="WeaponWindUp"
   WeaponProjectiles(1)=Class'UTGame.UTProj_StingerShard'
   FireInterval(0)=0.100000
   FireInterval(1)=0.280000
   Spread(0)=0.067500
   InstantHitDamage(0)=14.000000
   InstantHitDamageTypes(0)=Class'UTGame.UTDmgType_StingerBullet'
   EquipTime=0.600000
   FireOffset=(X=19.000000,Y=10.000000,Z=-10.000000)
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      FOV=65.000000
      SkeletalMesh=SkeletalMesh'WP_Stinger.Mesh.SK_WP_Stinger_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTWeap_Stinger:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_Stinger.Anims.K_WP_Stinger_1P_Base'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Priority=9.500000
   AIRating=0.710000
   ItemName="Minigun Stinger"
   MaxDesireability=0.730000
   PickupMessage="Minigun Stinger"
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Stinger_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_Stinger.Mesh.SK_WP_Stinger_3P_Mid'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_Stinger"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
