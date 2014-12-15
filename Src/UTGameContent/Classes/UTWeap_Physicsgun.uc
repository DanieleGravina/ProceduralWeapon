/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWeap_Physicsgun extends UTWeapon
	HideDropDown;

var()				float			WeaponImpulse;
var()				float			HoldDistanceMin;
var()				float			HoldDistanceMax;
var()				float			ThrowImpulse;
var()				float			ChangeHoldDistanceIncrement;

var					RB_Handle		PhysicsGrabber;
var					float			HoldDistance;
var					Quat			HoldOrientation;


simulated function PostBeginPlay()
{
	Super.PostbeginPlay();

	if ( WorldInfo.IsConsoleBuild() )
	{
		ChangeVisibility(false);
	}
}

/**
 * This function is called from the pawn when the visibility of the weapon changes
 */
simulated function ChangeVisibility(bool bIsVisible)
{
	if ( WorldInfo.IsConsoleBuild() )
	{
		bIsVisible = false;
	}
	Super.ChangeVisibility(bIsVisible);
}

simulated function StartFire(byte FireModeNum)
{
	local vector					StartShot, EndShot, PokeDir;
	local vector					HitLocation, HitNormal, Extent;
	local actor						HitActor;
	local float						HitDistance;
	local Quat						PawnQuat, InvPawnQuat, ActorQuat;
	local TraceHitInfo				HitInfo;
	local SkeletalMeshComponent		SkelComp;
	local Rotator					Aim;
	local PhysAnimTestActor			PATActor;

	if ( Role < ROLE_Authority )
		return;

	// Do ray check and grab actor
	StartShot	= Instigator.GetWeaponStartTraceLocation();
	Aim			= GetAdjustedAim( StartShot );
	EndShot		= StartShot + (10000.0 * Vector(Aim));
	Extent		= vect(0,0,0);
	HitActor	= Trace(HitLocation, HitNormal, EndShot, StartShot, True, Extent, HitInfo);
	HitDistance = VSize(HitLocation - StartShot);

	// POKE
	if(FireModeNum == 0)
	{
		PokeDir = Vector(Aim);

		if ( PhysicsGrabber.GrabbedComponent == None )
		{
			// `log("HitActor:"@HitActor@"Hit Bone:"@HitInfo.BoneName);
			if( HitActor != None &&
				HitActor != WorldInfo &&
				HitInfo.HitComponent != None )
			{
				PATActor = PhysAnimTestActor(HitActor);
				if(PATActor != None)
				{
					if( !PATActor.PrePokeActor(PokeDir) )
					{
						return;
					}
				}

				HitInfo.HitComponent.AddImpulse(PokeDir * WeaponImpulse, HitLocation, HitInfo.BoneName);
			}
		}
		else
		{
			PhysicsGrabber.GrabbedComponent.AddImpulse(PokeDir * ThrowImpulse, , PhysicsGrabber.GrabbedBoneName);
			PhysicsGrabber.ReleaseComponent();
		}
	}
	// GRAB
	else
	{
		if( HitActor != None &&
			HitActor != WorldInfo &&
			HitInfo.HitComponent != None &&
			HitDistance > HoldDistanceMin &&
			HitDistance < HoldDistanceMax )
		{
			PATActor = PhysAnimTestActor(HitActor);
			if(PATActor != None)
			{
				if( !PATActor.PreGrab() )
				{
					return;
				}
			}

			// If grabbing a bone of a skeletal mesh, dont constrain orientation.
			PhysicsGrabber.GrabComponent(HitInfo.HitComponent, HitInfo.BoneName, HitLocation, PlayerController(Instigator.Controller).bRun!=0);

			// If we succesfully grabbed something, store some details.
			if (PhysicsGrabber.GrabbedComponent != None)
			{
				HoldDistance	= HitDistance;
				PawnQuat		= QuatFromRotator( Rotation );
				InvPawnQuat		= QuatInvert( PawnQuat );

				if ( HitInfo.BoneName != '' )
				{
					SkelComp = SkeletalMeshComponent(HitInfo.HitComponent);
					ActorQuat = SkelComp.GetBoneQuaternion(HitInfo.BoneName);
				}
				else
				{
					ActorQuat = QuatFromRotator( PhysicsGrabber.GrabbedComponent.Owner.Rotation );
				}

				HoldOrientation = QuatProduct(InvPawnQuat, ActorQuat);
			}
		}
	}
}

simulated function StopFire(byte FireModeNum)
{
	local PhysAnimTestActor	PATActor;

	if ( PhysicsGrabber.GrabbedComponent != None )
	{
		PATActor = PhysAnimTestActor(PhysicsGrabber.GrabbedComponent.Owner);
		if(PATActor != None)
		{
			PATActor.EndGrab();
		}

		PhysicsGrabber.ReleaseComponent();
	}
}

simulated function bool DoOverridePrevWeapon()
{
	HoldDistance += ChangeHoldDistanceIncrement;
	HoldDistance = FMin(HoldDistance, HoldDistanceMax);
	return true;
}

simulated function bool DoOverrideNextWeapon()
{
	HoldDistance -= ChangeHoldDistanceIncrement;
	HoldDistance = FMax(HoldDistance, HoldDistanceMin);
	return true;
}

simulated function Tick( float DeltaTime )
{
	local vector	NewHandlePos, StartLoc;
	local Quat		PawnQuat, NewHandleOrientation;
	local Rotator	Aim;

	if ( PhysicsGrabber.GrabbedComponent == None )
	{
		GotoState( 'Active' );
		return;
	}

	PhysicsGrabber.GrabbedComponent.WakeRigidBody( PhysicsGrabber.GrabbedBoneName );

	// Update handle position on grabbed actor.
	StartLoc		= Instigator.GetWeaponStartTraceLocation();
	Aim				= GetAdjustedAim( StartLoc );
	NewHandlePos	= StartLoc + (HoldDistance * Vector(Aim));
	PhysicsGrabber.SetLocation( NewHandlePos );

	// Update handle orientation on grabbed actor.
	PawnQuat				= QuatFromRotator( Rotation );
	NewHandleOrientation	= QuatProduct(PawnQuat, HoldOrientation);
	PhysicsGrabber.SetOrientation( NewHandleOrientation );
}

defaultproperties
{
   WeaponImpulse=200.000000
   HoldDistanceMax=750.000000
   ThrowImpulse=100.000000
   ChangeHoldDistanceIncrement=50.000000
   Begin Object Class=RB_Handle Name=RB_Handle0 ObjName=RB_Handle0 Archetype=RB_Handle'Engine.Default__RB_Handle'
      LinearDamping=1.000000
      LinearStiffness=50.000000
      AngularDamping=1.000000
      AngularStiffness=50.000000
      Name="RB_Handle0"
      ObjectArchetype=RB_Handle'Engine.Default__RB_Handle'
   End Object
   PhysicsGrabber=RB_Handle0
   bExportMenuData=False
   AmmoCount=15
   LockerAmmoCount=15
   MaxAmmoCount=35
   InventoryGroup=154
   AttachmentClass=Class'UTGame.UTAttachment_FlakCannon'
   GroupWeight=0.500000
   WeaponFireSnd(0)=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_FireCue'
   WeaponFireSnd(1)=SoundCue'A_Weapon_FlakCannon.Weapons.A_FlakCannon_FireAltCue'
   WeaponColor=(B=128,G=255,R=255,A=255)
   PlayerViewOffset=(X=0.000000,Y=7.000000,Z=-9.000000)
   CurrentRating=0.750000
   WeaponFireTypes(0)=EWFT_Custom
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(0)=Class'UTGame.UTProj_FlakShard'
   WeaponProjectiles(1)=Class'UTGame.UTProj_FlakShell'
   FireOffset=(X=16.000000,Y=10.000000,Z=0.000000)
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
      SkeletalMesh=SkeletalMesh'WP_FlakCannon.Mesh.SK_WP_FlakCannon_1P'
      Begin Object Class=AnimNodeSequence Name=MeshSequenceA ObjName=MeshSequenceA Archetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
         Name="MeshSequenceA"
         ObjectArchetype=AnimNodeSequence'Engine.Default__AnimNodeSequence'
      End Object
      Animations=AnimNodeSequence'UTGameContent.Default__UTWeap_Physicsgun:MeshSequenceA'
      AnimSets(0)=AnimSet'WP_FlakCannon.Anims.K_WP_FlakCannon_1P_Base'
      Rotation=(Pitch=0,Yaw=-16384,Roll=0)
      Scale=0.500000
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   AIRating=0.750000
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'WP_FlakCannon.Mesh.S_WP_Flak_3P'
      bUseAsOccluder=False
      CastShadow=False
      bForceDirectLightMap=True
      bCastDynamicShadow=False
      CollideActors=False
      BlockRigidBody=False
      Translation=(X=0.000000,Y=0.000000,Z=-10.000000)
      Rotation=(Pitch=0,Yaw=32768,Roll=0)
      Scale=0.300000
      Name="StaticMeshComponent1"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   DroppedPickupMesh=StaticMeshComponent1
   PickupFactoryMesh=StaticMeshComponent1
   Components(0)=RB_Handle0
   Name="Default__UTWeap_Physicsgun"
   ObjectArchetype=UTWeapon'UTGame.Default__UTWeapon'
}
