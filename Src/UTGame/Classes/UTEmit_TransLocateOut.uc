/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTEmit_TransLocateOut extends UTReplicatedEmitter;

var float	TLTrailKillWindow;
var ParticleSystem FirstPersonTemplate;

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	if (Owner != none)
	{
		Owner.TakeDamage(Damage, EventInstigator, Owner.Location - (Location - HitLocation), Momentum * 0.25, DamageType, HitInfo, DamageCauser);
	}
	return;
}

simulated function PostBeginPlay()
{
	// Set Notification Delegate
	if (ParticleSystemComponent != None)
	{
		ParticleSystemComponent.OnSystemFinished = OnParticleSystemFinished;
	}

	SetTimer(TLTrailKillWindow, false);
}

simulated function Timer()
{
	CollisionComponent.SetActorCollision(false, false);
	RemoteRole = ROLE_None;
	if (WorldInfo.NetMode == NM_DedicatedServer)
	{
		Destroy();
	}
}

/** we set the template on the first tick instead of in PostBeginPlay() so the client has a chance to get Owner */
auto state FirstTick
{
	simulated function Tick(float DeltaTime)
	{
		if (WorldInfo.NetMode != NM_DedicatedServer)
		{
			if (Pawn(Owner) != none && Pawn(Owner).IsFirstPerson())
			{
				SetTemplate(FirstPersonTemplate,true);
			}
			else
			{
				SetTemplate(EmitterTemplate,true);
			}
		}

		GotoState('');
	}
}

defaultproperties
{
   TLTrailKillWindow=0.100000
   FirstPersonTemplate=ParticleSystem'Envy_Effects.Particles.P_Player_Spawn_Blue'
   EmitterTemplate=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_Teleport'
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=44.000000
      CollisionRadius=21.000000
      Name="CollisionCylinder"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   Components(1)=CollisionCylinder
   TickGroup=TG_PostAsyncWork
   bCollideActors=True
   bCollideWorld=True
   bBlockActors=True
   bProjTarget=True
   CollisionComponent=CollisionCylinder
   Name="Default__UTEmit_TransLocateOut"
   ObjectArchetype=UTReplicatedEmitter'UTGame.Default__UTReplicatedEmitter'
}
