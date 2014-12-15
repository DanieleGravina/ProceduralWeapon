/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_ShockBall extends UTProjectile;

var class<UTDamageType>	ComboDamageType;
var class<UTDamageType> ComboTriggerType;
var ParticleSystem ComboTemplate;
var float ComboRadius;
var int   ComboDamage;
var float ComboMomentumTransfer;
var int ComboAmmoCost;
var SoundCue ComboExplosionSound;
var class<UTReplicatedEmitter> ComboExplosionEffect;

/** true if we have been combo'ed (so don't play normal explosion effects) */
var repnotify bool bComboed;

var Pawn ComboTarget;		// for AI use

replication
{
	if (Role == ROLE_Authority)
		bComboed;
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'bComboed')
	{
		bSuppressExplosionFX = true;
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

/** CreateProjectileLight() called from TickSpecial() once if Instigator is local player
always create shock light, even at low frame rates (since critical for timing combos)
*/
simulated event CreateProjectileLight()
{
	ProjectileLight = new(Outer) ProjectileLightClass;
	AttachComponent(ProjectileLight);
}

function ComboExplosion()
{
	HurtRadius(ComboDamage, ComboRadius, ComboDamageType, ComboMomentumTransfer, Location );
	Spawn(ComboExplosionEffect);
	PlaySound(ComboExplosionSound);

	bSuppressExplosionFX = true;
	bComboed = true;
	Shutdown();
}

simulated function ProcessTouch(Actor Other, vector HitLocation, vector HitNormal)
{
	local UTProj_ShockBall ShockProj;

	Super.ProcessTouch(Other, HitLocation, HitNormal);

	// when shock projectiles collide, make sure they both blow up
	ShockProj = UTProj_ShockBall(Other);
	if (ShockProj != None)
	{
		ShockProj.Explode(HitLocation, -HitNormal);
	}
}

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if ( DamageType==ComboTriggerType )
	{
		InstigatorController = EventInstigator;
		Instigator = EventInstigator.Pawn;
		ComboExplosion();
		if (EventInstigator.Pawn != None && EventInstigator.Pawn.Weapon != None)
		{
			EventInstigator.Pawn.Weapon.AddAmmo(-ComboAmmoCost);
		}
	}
	else
	{
		Super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	}
}

function Monitor(Pawn P)
{
	ComboTarget = P;
	if ( ComboTarget != None )
	{
		GotoState('WaitForCombo');
	}
}

state WaitForCombo
{
	function Tick(float DeltaTime)
	{
		local float Dist;
		local UTBot B;

		if ( (ComboTarget == None) || ComboTarget.bDeleteMe
			|| (Instigator == None) || (UTWeap_ShockRifle(Instigator.Weapon) == None) )
		{
			if (Instigator != None && UTWeap_ShockRifle(Instigator.Weapon) != None)
			{
				UTWeap_ShockRifle(Instigator.Weapon).ClearCombo();
			}
			GotoState('');
			return;
		}



		// if I'm close enough or have passed target, do combo
		Dist = VSize(ComboTarget.Location - Location);
		if ( Dist <= 0.5 * ComboRadius + ComboTarget.GetCollisionRadius()
			|| (Velocity Dot (ComboTarget.Location - Location)) <= 0.0 )
		{
			UTWeap_ShockRifle(Instigator.Weapon).DoCombo();
			GotoState('');
			return;
		}
		else if (Dist <= ComboRadius + ComboTarget.GetCollisionRadius())
		{
			// if close to combo time, make bot look at me
			B = UTBot(Instigator.Controller);
			if (B != None)
			{
				B.TemporaryFocus = self;
			}
		}

		if ( PointDistToLine(ComboTarget.Location, Normal(Velocity), Location) > ComboRadius + FMax(ComboTarget.GroundSpeed,VSize(ComboTarget.Velocity)) )
		{
			UTWeap_ShockRifle(Instigator.Weapon).ClearCombo();
			GotoState('');
			return;
		}
	}

	event EndState(name NextStateName)
	{
		local UTBot B;

		if (Instigator != None)
		{
			B = UTBot(Instigator.Controller);
			if (B != None && B.TemporaryFocus == self)
			{
				B.TemporaryFocus = None;
			}
		}
	}
}

defaultproperties
{
   ComboDamageType=Class'UTGame.UTDmgType_ShockCombo'
   ComboTriggerType=Class'UTGame.UTDmgType_ShockPrimary'
   ComboTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Explo'
   ComboRadius=275.000000
   ComboDamage=215
   ComboMomentumTransfer=150000.000000
   ComboAmmoCost=3
   ComboExplosionSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_ComboExplosionCue'
   ComboExplosionEffect=Class'UTGame.UTEmit_ShockCombo'
   bCheckProjectileLight=True
   AmbientSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireTravelCue'
   ExplosionSound=SoundCue'A_Weapon_ShockRifle.Cue.A_Weapon_SR_AltFireImpactCue'
   ProjFlightTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
   ProjExplosionTemplate=ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball_Impact'
   MaxEffectDistance=7000.000000
   CheckRadius=40.000000
   ProjectileLightClass=Class'UTGame.UTShockBallLight'
   Speed=1150.000000
   MaxSpeed=1150.000000
   Damage=55.000000
   DamageRadius=120.000000
   MomentumTransfer=70000.000000
   MyDamageType=Class'UTGame.UTDmgType_ShockBall'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      CollisionHeight=16.000000
      CollisionRadius=16.000000
      CollideActors=True
      BlockActors=True
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   bNetTemporary=False
   bCollideComplex=False
   bProjTarget=True
   LifeSpan=8.000000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_ShockBall"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
