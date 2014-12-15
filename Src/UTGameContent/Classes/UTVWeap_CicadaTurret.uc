/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTVWeap_CicadaTurret extends UTVehicleWeapon
	HideDropDown;

var Projectile Incoming;
var Projectile IgnoredMissile, WatchedMissile;
/** array of all missiles known to be targeting us */
var array<Projectile> Missiles;

simulated function AddMissile(Projectile P)
{
	local int i;

	for (i = 0; i < Missiles.length; i++)
	{
		if (Missiles[i] == P)
		{
			// already in list
			return;
		}
	}

	Missiles[Missiles.length] = P;
}

//Notify vehicle that an enemy has locked on to it
simulated function IncomingMissile(Projectile P)
{
	local UTBot B;

	AddMissile(P);
	if (Role == ROLE_Authority && IgnoredMissile != P && Instigator != None)
	{
		if (WatchedMissile != P)
		{
			B = UTBot(Instigator.Controller);
			if (B == None || B.Skill < 2.0 + 3.0 * FRand())
			{
				if (Instigator.Controller != None || UTBot(MyVehicle.Controller) == None || UTBot(MyVehicle.Controller).Skill < 3.0 + 3.0 * FRand())
				{
					IgnoredMissile = P;
					return;
				}
			}
			WatchedMissile = P;
		}

		// FIRE CHAFF if missile nearby
		if (VSize(MyVehicle.Location - P.Location) < 1000.0 + class'UTDecoy'.default.DecoyRange)
		{
			if (Instigator.Controller == None)
			{
				if (UTBot(MyVehicle.Controller) == None)
				{
					IgnoredMissile = P;
					return;
				}
				MyVehicle.StopFiring();
			}
			else if (UTBot(Instigator.Controller) == None)
			{
				IgnoredMissile = P;
				return;
			}
			Incoming = P;
			IgnoredMissile = P;
			Instigator.StartFire(1);
		}
	}
}

simulated function rotator GetAdjustedAim(vector StartFireLoc)
{
	local rotator Result;

	if (CurrentFireMode == 1 && Instigator.Controller == None && Incoming != None)
	{
		Result = rotator(Incoming.Location + Incoming.Velocity * (VSize(Incoming.Location - StartFireLoc) / class'UTDecoy'.default.Speed) - StartFireLoc);
		if (Result.Pitch > 0 && Result.Pitch < 32768)
		{
			Result.Pitch = 0;
		}
		return Result;
	}
	else
	{
		return Super.GetAdjustedAim(StartFireLoc);
	}
}

simulated function Projectile ProjectileFire()
{
	local UTDecoy D;
	local UTVehicle_Cicada_Content V;

	D = UTDecoy(Super.ProjectileFire());
	if (D != None)
	{
		V = UTVehicle_Cicada_Content(MyVehicle);
		if (V != None)
		{
			V.Decoys[V.Decoys.length] = D;
			D.ProtectedTarget = V;
		}
	}

	return D;
}

defaultproperties
{
   FireTriggerTags(0)="TurretWeapon00"
   FireTriggerTags(1)="TurretWeapon01"
   FireTriggerTags(2)="TurretWeapon02"
   FireTriggerTags(3)="TurretWeapon03"
   DefaultImpactEffect=(Sound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue',ParticleTemplate=ParticleSystem'VH_Cicada.Effects.P_VH_Cicada_2ndPrim_impact')
   VehicleClass=Class'UTGameContent.UTVehicle_Cicada_Content'
   bFastRepeater=True
   WeaponFireSnd(0)=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_TurretFire'
   WeaponFireSnd(1)=SoundCue'A_Vehicle_Cicada.SoundCues.A_Vehicle_Cicada_TurretAltFire'
   WeaponFireTypes(1)=EWFT_Projectile
   WeaponProjectiles(1)=Class'UTGameContent.UTDecoy'
   FireInterval(0)=0.200000
   FireInterval(1)=1.500000
   InstantHitDamage(0)=25.000000
   InstantHitMomentum(0)=20000.000000
   InstantHitDamageTypes(0)=Class'UTGameContent.UTDmgType_CicadaLaser'
   InstantHitDamageTypes(1)=None
   bInstantHit=True
   Begin Object Class=UTSkeletalMeshComponent Name=FirstPersonMesh ObjName=FirstPersonMesh Archetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
      ObjectArchetype=UTSkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:FirstPersonMesh'
   End Object
   Mesh=FirstPersonMesh
   ItemName="Cannoniere Cicada "
   Begin Object Class=SkeletalMeshComponent Name=PickupMesh ObjName=PickupMesh Archetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGame.Default__UTVehicleWeapon:PickupMesh'
   End Object
   DroppedPickupMesh=PickupMesh
   PickupFactoryMesh=PickupMesh
   Name="Default__UTVWeap_CicadaTurret"
   ObjectArchetype=UTVehicleWeapon'UTGame.Default__UTVehicleWeapon'
}
