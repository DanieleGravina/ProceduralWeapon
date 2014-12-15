/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_TurretShockBall extends UTProj_ShockBall;

/** Holds a link to the weapon that fired this gun */
var repnotify UTVehicleWeapon InstigatorWeapon;
/** cached cast of InstigatorController for replication test */
var PlayerController InstigatorPlayerController;

replication
{
	// replicate InstigatorWeapon only to the player that fired it
	if (bNetInitial && (InstigatorWeapon == None || WorldInfo.ReplicationViewers.Find('InViewer', InstigatorPlayerController) != INDEX_NONE))
		InstigatorWeapon;
}

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();

	InstigatorPlayerController = PlayerController(InstigatorController);
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'InstigatorWeapon')
	{
		if (InstigatorWeapon != None)
		{
			InstigatorWeapon.AimingTraceIgnoredActors[InstigatorWeapon.AimingTraceIgnoredActors.Length] = self;
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

simulated event Destroyed()
{
	Super.Destroyed();

	if (InstigatorWeapon != None)
	{
		InstigatorWeapon.AimingTraceIgnoredActors.RemoveItem(self);
	}
}

/**
 * Explode this Projectile
 */
simulated function Explode(vector HitLocation, vector HitNormal)
{
	ComboExplosion();
}

defaultproperties
{
   ComboDamageType=Class'UTGameContent.UTDmgType_TurretShockBall'
   ComboTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_ShockballCombo'
   ComboDamage=120
   bWideCheck=True
   ProjFlightTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_ShockBall'
   ProjExplosionTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_ShockBallImpact'
   CheckRadius=300.000000
   Speed=1500.000000
   MaxSpeed=1500.000000
   Damage=45.000000
   DamageRadius=128.000000
   MyDamageType=Class'UTGameContent.UTDmgType_TurretShockBall'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_ShockBall:CollisionCylinder'
      CollisionHeight=10.000000
      CollisionRadius=10.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_ShockBall:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_TurretShockBall"
   ObjectArchetype=UTProj_ShockBall'UTGame.Default__UTProj_ShockBall'
}
