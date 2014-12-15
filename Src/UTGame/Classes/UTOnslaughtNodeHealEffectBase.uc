/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTOnslaughtNodeHealEffectBase extends UTReplicatedEmitter;

simulated function ShutDown()
{
	bTearOff = true;
	ParticleSystemComponent.DeactivateSystem();
	bDestroyOnSystemFinish = true;
	LifeSpan = 1.0;
}

simulated event TornOff()
{
	ShutDown();
}

defaultproperties
{
   ServerLifeSpan=0.000000
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   bNetTemporary=False
   LifeSpan=0.000000
   Name="Default__UTOnslaughtNodeHealEffectBase"
   ObjectArchetype=UTReplicatedEmitter'UTGame.Default__UTReplicatedEmitter'
}
