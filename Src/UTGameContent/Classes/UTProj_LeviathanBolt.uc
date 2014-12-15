/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_LeviathanBolt extends UTProjectile;

var vector TargetLoc;
var vector InitialDir;

replication
{
    if( bNetInitial && (Role==ROLE_Authority) )
        TargetLoc, InitialDir;
}

/**
 * Clean up
 */
simulated function Shutdown()
{
	Super.ShutDown();
	SetTimer(0.0,false);
}
simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(0.1,true);
}

simulated function Timer()
{
    local vector ForceDir;
    local float VelMag;

    if ( InitialDir == vect(0,0,0) )
        InitialDir = Normal(Velocity);

	Acceleration = vect(0,0,0);

	ForceDir = Normal(TargetLoc - Location);

	if( (ForceDir Dot InitialDir) > 0 )
	{
		VelMag = VSize(Velocity);
		ForceDir = Normal(ForceDir * 0.9 * VelMag + Velocity);
		Velocity =  VelMag * ForceDir;
		Acceleration += 5 * ForceDir;
	}
	
	SetRotation( Rotator(Normal(Velocity)) );

	if ( LifeSpan < 3.5 )
	{
		ClearTimer();
	}	
}

defaultproperties
{
   ProjFlightTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_Bolt'
   ProjExplosionTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_BoltImpact'
   AccelRate=20000.000000
   CheckRadius=30.000000
   Speed=1200.000000
   MaxSpeed=3500.000000
   Damage=100.000000
   DamageRadius=300.000000
   MomentumTransfer=4000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_LeviathanBolt'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   LifeSpan=4.000000
   DrawScale=1.200000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_LeviathanBolt"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
