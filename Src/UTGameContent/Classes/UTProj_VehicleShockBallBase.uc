/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_VehicleShockBallBase extends UTProj_ShockBall;

/** Holds a link to the weapon that fired this gun */
var repnotify UTVWeap_ShockTurretBase InstigatorWeapon;

/** How long to wait before continuing the chain */
var float ChainReactionDelay;

/** The maximum distance to search for a combo */
var float MaxChainReactionDist;

var repnotify vector EndPoint;

/** template for the beam during a chain reaction */
var ParticleSystem BeamTemplate;

/** cached cast of InstigatorController for replication test */
var PlayerController InstigatorPlayerController;

replication
{
	if (bNetDirty)
		EndPoint;
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
	if (VarName == 'EndPoint')
	{
		SpawnBeam();
	}
	else if (VarName == 'InstigatorWeapon')
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

simulated function SpawnBeam()
{
	local ParticleSystemComponent ShockBeam;

	ShockBeam = WorldInfo.MyEmitterPool.SpawnEmitter(BeamTemplate, Location);
	ShockBeam.SetVectorParameter('ShockBeamEnd', EndPoint);
}

/**
 * Look to see if this should be combo
 */

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if (DamageType == ComboTriggerType)
	{
		InstigatorController = EventInstigator;
		Instigator = (EventInstigator.Pawn != None) ? EventInstigator.Pawn : None;
		GotoState('ChainReaction');
	}
	else
	{
		Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	}
}

state ChainReaction
{
	/**
	 * Explode this ball and then find a new one to explode
	 */

	function BeginState(name PreviousStateName)
	{
		ComboExplosion();
		SetTimer(ChainReactionDelay,false,'ComboNextBall');
	}

	simulated function ShutDown()
	{
	}

	/**
	 * Explode the next ShockBall
	 */

	function ComboNextBall()
	{
		local int x;
		local UTProj_VehicleShockBallBase ChainTarget;
		local float BestDist;

		if (InstigatorWeapon != None)
		{
			BestDist = MaxChainReactionDist;
			for (x = 0; x < InstigatorWeapon.ShockBalls.length; x++)
			{
				if ( InstigatorWeapon.ShockBalls[x] == None || InstigatorWeapon.ShockBalls[x] == self || InstigatorWeapon.ShockBalls[x].Physics == PHYS_None )
				{
					InstigatorWeapon.ShockBalls.Remove(x, 1);
					x--;
				}
				else if (VSize(Location - InstigatorWeapon.ShockBalls[x].Location) < BestDist)
				{
					if ( FastTrace(Location, InstigatorWeapon.ShockBalls[x].Location) )
					{
						ChainTarget = InstigatorWeapon.ShockBalls[x];
						BestDist = VSize(Location - InstigatorWeapon.ShockBalls[x].Location);
					}
				}
			}

			if (ChainTarget != None)
			{
				ChainTarget.EndPoint = Location;

				if (WorldInfo.NetMode == NM_StandAlone || WorldInfo.NetMode == NM_ListenServer)
				{
					ChainTarget.SpawnBeam();
				}

				ChainTarget.TakeDamage(1,InstigatorController, ChainTarget.Location, vect(0,0,0), ComboTriggerType,, self);
			}
		}

		Global.ShutDown();
	}
}

state WaitForCombo
{
	function Tick(float DeltaTime)
	{
		if (ComboTarget == None || ComboTarget.bDeleteMe || Instigator == None || InstigatorWeapon == None)
		{
			GotoState('');
		}
		// if I'm close enough or have passed target, do combo
		else if ( VSize(ComboTarget.Location - Location) <= 0.75 * ComboRadius + ComboTarget.GetCollisionRadius()
				|| (Velocity Dot (ComboTarget.Location - Location)) <= 0 )
		{
			InstigatorWeapon.bDoCombo = true;
			GotoState('');
		}
	}
}

defaultproperties
{
   ChainReactionDelay=0.250000
   MaxChainReactionDist=2500.000000
   BeamTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Beam'
   ComboRadius=525.000000
   ComboDamage=200
   ComboAmmoCost=0
   ComboExplosionEffect=Class'UTGameContent.UTEmit_VehicleShockCombo'
   Speed=1100.000000
   MaxSpeed=1100.000000
   Damage=25.000000
   MomentumTransfer=25000.000000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_ShockBall:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_ShockBall:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   DrawScale=0.700000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_VehicleShockBallBase"
   ObjectArchetype=UTProj_ShockBall'UTGame.Default__UTProj_ShockBall'
}
