/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTEmit_LeviathanExplosion extends UTReplicatedEmitter;

var float Damage;
var float DamageRadius;
var float MomentumTransfer;
var Class<DamageType> MyDamageType;
var class<UTExplosionLight> ExplosionLightClass;
var Controller InstigatorController;
var CameraAnim ExplosionShake;

simulated function PostBeginPlay()
{
	local UTPlayerController PC;
	local float Dist, Scale;

	Super.PostBeginPlay();

	if ( WorldInfo.NetMode != NM_DedicatedServer && !WorldInfo.bDropDetail )
	{
		AttachComponent(new(Outer) ExplosionLightClass);
	}

	foreach LocalPlayerControllers(class'UTPlayerController', PC)
	{
		if (PC.ViewTarget != None)
		{
			Dist = VSize(Location - PC.ViewTarget.Location);
			if (Dist < DamageRadius * 2.0)
			{
				if (Dist < DamageRadius)
				{
					Scale = 1.0;
				}
				else
				{
					Scale = (DamageRadius * 2.0 - Dist) / DamageRadius;
				}
				PC.PlayCameraAnim(ExplosionShake, Scale);
			}
		}
	}
}


/** special version of HurtRadius() for the Redeemer that works better with the giant radius by tracing to edges
 * of large objects instead of just the center
 * static so that it can be shared with UTRemoteRedeemer
 */
function RedeemerHurtRadius(float RadiusFactor, Controller InstigatedByController)
{
	local Actor Victim, HitActor;
	local bool bCauseDamage;
	local float HurtRadius, Radius, Height;
	local vector Side, Up, ExplosionCenter, HitNormal, HitLocation;

	HurtRadius = default.DamageRadius * RadiusFactor;

	if (InstigatedByController == None && Instigator != None)
	{
		InstigatedByController = Instigator.Controller;
	}

	// move explosion center up a bit to address not hitting pawns
	ExplosionCenter = Location + vect(0,0,200);
	HitActor = Trace(HitLocation, HitNormal, ExplosionCenter, Location, true,,,TRACEFLAG_Blocking);
	ExplosionCenter = (HitActor == None) ? Location + vect(0,0,100) : 0.5 * (ExplosionCenter + HitLocation);

	foreach CollidingActors(class'Actor', Victim, HurtRadius, ExplosionCenter)
	{
		if (!Victim.bStatic && (Victim != self) )
		{
			Victim.GetBoundingCylinder(Radius, Height);
			Up = vect(0,0,1) * Height;
			bCauseDamage = FastTrace(Victim.Location + Up, ExplosionCenter);
			if (!bCauseDamage)
			{
				bCauseDamage = FastTrace(Victim.Location , ExplosionCenter);
				if ( !bCauseDamage && (Radius > 100.0) )
				{
					// try sides
					Side = (Normal(Victim.Location - ExplosionCenter) Cross vect(0,0,1)) * Radius;
					bCauseDamage = FastTrace(Victim.Location + Side + Up, ExplosionCenter) ||
							FastTrace(Victim.Location - Side + Up, ExplosionCenter);
				}
			}
			if (bCauseDamage)
			{
				Victim.TakeRadiusDamage( InstigatedByController, Damage, HurtRadius, default.MyDamageType,
							default.MomentumTransfer, ExplosionCenter, false, self );
			}
		}
	}
}

auto state Dying
{
Begin:
    RedeemerHurtRadius(0.125, InstigatorController);
    Sleep(0.5);
    RedeemerHurtRadius(0.3, InstigatorController);
    Sleep(0.2);
    RedeemerHurtRadius(0.475, InstigatorController);
    Sleep(0.2);
    RedeemerHurtRadius(0.650, InstigatorController);
    Sleep(0.2);
    RedeemerHurtRadius(0.825, InstigatorController);
    Sleep(0.2);
    RedeemerHurtRadius(1.0, InstigatorController);
}

defaultproperties
{
   Damage=250.000000
   DamageRadius=2000.000000
   MomentumTransfer=250000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_LeviathanExplosion'
   ExplosionLightClass=Class'UTGame.UTHugeExplosionLight'
   ExplosionShake=CameraAnim'Camera_FX.Leviathan_Impact'
   EmitterTemplate=ParticleSystem'VH_Leviathan.Effects.P_VH_Leviathan_BigBeam_Explode'
   ServerLifeSpan=3.000000
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   Begin Object Class=AudioComponent Name=ExplosionAC ObjName=ExplosionAC Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Vehicle_leviathan.SoundCues.A_Vehicle_Leviathan_BigBang'
      bAutoPlay=True
      bAutoDestroy=True
      Name="ExplosionAC"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   Components(1)=ExplosionAC
   TickGroup=TG_PreAsyncWork
   bGameRelevant=False
   LifeSpan=0.000000
   Name="Default__UTEmit_LeviathanExplosion"
   ObjectArchetype=UTReplicatedEmitter'UTGame.Default__UTReplicatedEmitter'
}
