/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_ShockRifle extends UTWeapon;

// AI properties (for shock combos)
var UTProj_ShockBall ComboTarget;
var bool bRegisterTarget;
var bool bWaitForCombo;
var vector ComboStart;

var bool bWasACombo;
var int CurrentPath;
//-----------------------------------------------------------------
// AI Interface
function float GetAIRating()
{
	local UTBot B;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) || Pawn(B.Focus) == None )
		return AIRating;

	if ( bWaitForCombo )
		return 1.5;
	if ( !B.ProficientWithWeapon() )
		return AIRating;
	if ( B.Stopped() )
	{
		if ( !B.LineOfSightTo(B.Enemy) && (VSize(B.Enemy.Location - Instigator.Location) < 5000) )
			return (AIRating + 0.5);
		return (AIRating + 0.3);
	}
	else if ( VSize(B.Enemy.Location - Instigator.Location) > 1600 )
		return (AIRating + 0.1);
	else if ( B.Enemy.Location.Z > B.Location.Z + 200 )
		return (AIRating + 0.15);

	return AIRating;
}


/**
* Overriden to use GetPhysicalFireStartLoc() instead of Instigator.GetWeaponStartTraceLocation()
* @returns position of trace start for instantfire()
*/
simulated function vector InstantFireStartTrace()
{
	return GetPhysicalFireStartLoc();
}

function SetComboTarget(UTProj_ShockBall S)
{
	if ( !bRegisterTarget || (UTBot(Instigator.Controller) == None) || (Instigator.Controller.Enemy == None) )
		return;

	bRegisterTarget = false;
	bWaitForCombo = true;
	ComboStart = Instigator.Location;
	ComboTarget = S;
	ComboTarget.Monitor(UTBot(Instigator.Controller).Enemy);
}

function float RangedAttackTime()
{
	local UTBot B;

	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if ( B.CanComboMoving() )
		return 0;

	return FMin(2,0.3 + VSize(B.Enemy.Location - Instigator.Location)/class'UTProj_ShockBall'.default.Speed);
}

function float SuggestAttackStyle()
{
	return -0.4;
}

simulated function StartFire(byte FireModeNum)
{
	if ( bWaitForCombo && (UTBot(Instigator.Controller) != None) )
	{
		if ( (ComboTarget == None) || ComboTarget.bDeleteMe )
			bWaitForCombo = false;
		else
			return;
	}
	Super.StartFire(FireModeNum);
}

function DoCombo()
{
	if ( bWaitForCombo )
	{
		bWaitForCombo = false;
		if ( (Instigator != None) && (Instigator.Weapon == self) )
		{
			StartFire(0);
		}
	}
}

function ClearCombo()
{
	ComboTarget = None;
	bWaitForCombo = false;
}

/* BestMode()
choose between regular or alt-fire
*/
function byte BestMode()
{
	local float EnemyDist;
	local UTBot B;
	local UTPawn EnemyPawn;

	bWaitForCombo = false;
	B = UTBot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return 0;

	if (B.IsShootingObjective())
		return 0;

	if ( !B.LineOfSightTo(B.Enemy) )
	{
		if ( (ComboTarget != None) && !ComboTarget.bDeleteMe && B.CanCombo() )
		{
			bWaitForCombo = true;
			return 0;
		}
		ComboTarget = None;
		if ( B.CanCombo() && B.ProficientWithWeapon() )
		{
			bRegisterTarget = true;
			return 1;
		}
		return 0;
	}

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

	if ( (EnemyDist > 4*class'UTProj_ShockBall'.default.Speed) || (EnemyDist < 150) )
	{
		ComboTarget = None;
		return 0;
	}

	if ( (ComboTarget != None) && !ComboTarget.bDeleteMe && B.CanCombo() )
	{
		bWaitForCombo = true;
		return 0;
	}

	ComboTarget = None;

	if ( (EnemyDist > 2500) && (FRand() < 0.5) )
		return 0;

	if ( B.CanCombo() && B.ProficientWithWeapon() )
	{
		bRegisterTarget = true;
		return 1;
	}

	// consider using altfire to block incoming enemy fire
	if (EnemyDist < 1000.0 && B.Enemy.Weapon != None && B.Enemy.Weapon.Class != Class && B.ProficientWithWeapon())
	{
		return (FRand() < 0.3) ? 0 : 1;
	}
	else
	{
		return (FRand() < 0.7) ? 0 : 1;
	}
}

// for bot combos
simulated function Projectile ProjectileFire()
{
	local Projectile p;

	p = Super.ProjectileFire();
	if (UTProj_ShockBall(p) != None)
	{
		SetComboTarget(UTProj_ShockBall(P));
	}
	return p;
}

simulated function rotator GetAdjustedAim( vector StartFireLoc )
{
	local rotator ComboAim;

	// if ready to combo, aim at shockball
	if (UTBot(Instigator.Controller) != None && CurrentFireMode == 0 && ComboTarget != None && !ComboTarget.bDeleteMe)
	{
		// use bot yaw aim, so bots with lower skill/low rotation rate may miss
		ComboAim = rotator(ComboTarget.Location - StartFireLoc);
		ComboAim.Yaw = Instigator.Rotation.Yaw;
		return ComboAim;
	}

	return Super.GetAdjustedAim(StartFireLoc);
}

simulated state WeaponFiring
{
	/**
	 * Called when the weapon is done firing, handles what to do next.
	 */
	simulated event RefireCheckTimer()
	{
		if ( bWaitForCombo && (UTBot(Instigator.Controller) != None) )
		{
			if ( (ComboTarget == None) || ComboTarget.bDeleteMe )
				bWaitForCombo = false;
			else
			{
				StopFire(CurrentFireMode);
				GotoState('Active');
				return;
			}
		}

		Super.RefireCheckTimer();
	}
}

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList)
{
	local ImpactInfo II;
	II = Super.CalcWeaponFire(StartTrace, EndTrace, ImpactList);
	bWasACombo = (II.HitActor != None && UTProj_ShockBall(II.HitActor) != none );
	return ii;
}

function SetFlashLocation( vector HitLocation )
{
	local byte NewFireMode;
	if( Instigator != None )
	{
		if (bWasACombo)
		{
			NewFireMode = 3;
		}
		else
		{
			NewFireMode = CurrentFireMode;
		}
		Instigator.SetFlashLocation( Self, NewFireMode , HitLocation );
	}
}


simulated function SetMuzzleFlashParams(ParticleSystemComponent PSC)
{
	local float PathValues[3];
	local int NewPath;
	Super.SetMuzzleFlashparams(PSC);
	if (CurrentFireMode == 0)
	{
		if ( !bWasACombo )
		{
			NewPath = Rand(3);
			if (NewPath == CurrentPath)
			{
				NewPath++;
			}
			CurrentPath = NewPath % 3;

			PathValues[CurrentPath % 3] = 1.0;
			PSC.SetFloatParameter('Path1',PathValues[0]);
			PSC.SetFloatParameter('Path2',PathValues[1]);
			PSC.SetFloatParameter('Path3',PathValues[2]);
		}
		else
		{
			PSC.SetFloatParameter('Path1',1.0);
			PSC.SetFloatParameter('Path2',1.0);
			PSC.SetFloatParameter('Path3',1.0);
		}
	}
	else
	{
		PSC.SetFloatParameter('Path1',0.0);
		PSC.SetFloatParameter('Path2',0.0);
		PSC.SetFloatParameter('Path3',0.0);
	}

}

simulated function PlayFireEffects( byte FireModeNum, optional vector HitLocation )
{
	if (FireModeNum>1)
	{
		Super.PlayFireEffects(0,HitLocation);
	}
	else
	{
		Super.PlayFireEffects(FireModeNum, HitLocation);
	}
}

/**
 * Skip over the Instagib rifle code */

simulated function SetSkin(Material NewMaterial)
{
	Super(UTWeapon).SetSkin(NewMaterial);
}

simulated function AttachWeaponTo(SkeletalMeshComponent MeshCpnt, optional name SocketName)
{
	Super(UTWeapon).AttachWeaponTo(MeshCpnt, SocketName);
}

defaultproperties
{
   bSniping=True
   bTargetFrictionEnabled=True
   bTargetAdhesionEnabled=True
   AmmoCount=20
   LockerAmmoCount=30
   MaxAmmoCount=50
   FireCameraAnim(0)=None
   FireCameraAnim(1)=CameraAnim'Camera_FX.ShockRifle.C_WP_ShockRifle_Alt_Fire_Shake'
   WeaponFireWaveForm=ForceFeedbackWaveform'UTGame.Default__UTWeap_ShockRifle:ForceFeedbackWaveformShooting1'
   IconX=400
   IconY=129
   IconWidth=22
   IconHeight=48
   IconCoordinates=(U=728.000000,V=382.000000,UL=162.000000,VL=45.000000)
   CrossHairCoordinates=(U=256.000000,V=0.000000)
   InventoryGroup=4
   AttachmentClass=Class'UTGame.UTAttachment_ShockRifle'
   GroupWeight=0.500000
   QuickPickGroup=0
   QuickPickWeight=0.900000
   WeaponFireAnim(1)="WeaponAltFire"
   WeaponFireSnd(0)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_FireCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireCue'
   WeaponPutDownSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_LowerCue'
   WeaponEquipSnd=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_RaiseCue'
   WeaponColor=(B=255,G=0,R=160,A=255)
   MuzzleFlashSocket="MF"
   MuzzleFlashPSCTemplate=ParticleSystem'WP_ShockRifle.Particles.P_ShockRifle_MF_Alt'
   MuzzleFlashAltPSCTemplate=ParticleSystem'WP_ShockRifle.Particles.P_ShockRifle_MF_Alt'
   MuzzleFlashColor=(B=255,G=120,R=200,A=255)
   MuzzleFlashLightClass=Class'UTGame.UTShockMuzzleFlashLight'
   PlayerViewOffset=(X=17.000000,Y=10.000000,Z=-8.000000)
   LockerRotation=(Pitch=32768,Yaw=0,Roll=16384)
   CurrentRating=0.650000
   ShouldFireOnRelease(1)=1
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(1)=Class'UTGame.UTProj_ShockBall'
   FireInterval(0)=0.770000
   FireInterval(1)=0.600000
   InstantHitDamage(0)=45.000000
   InstantHitMomentum(0)=60000.000000
   InstantHitDamageTypes(0)=Class'UTGame.UTDmgType_ShockPrimary'
   InstantHitDamageTypes(1)=None
   FireOffset=(X=20.000000,Y=5.000000,Z=0.000000)
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      FOV=60.000000
      SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGame.Default__UTWeap_ShockRifle:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_ShockRifle.Anim.K_WP_ShockRifle_1P_Base'
      Rotation=(Pitch=0,Yaw=-16384,Roll=0)
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   Priority=4.200000
   AIRating=0.650000
   ItemName="Fucile Shock"
   MaxDesireability=0.650000
   PickupMessage="Fucile Shock"
   PickupSound=SoundCue'A_Pickups.Weapons.Cue.A_Pickup_Weapons_Shock_Cue'
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
      SkeletalMesh=SkeletalMesh'WP_ShockRifle.Mesh.SK_WP_ShockRifle_3P'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTWeap_ShockRifle"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
