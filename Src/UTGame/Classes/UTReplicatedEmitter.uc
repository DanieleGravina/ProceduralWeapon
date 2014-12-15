/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTReplicatedEmitter extends UTEmitter
	native
	notplaceable
	abstract;

/** The Template to use for this emitter */
var ParticleSystem EmitterTemplate;

/** How long this actor lives on a dedicated server */
var float ServerLifeSpan;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	if( WorldInfo.NetMode == NM_DedicatedServer )
	{
		LifeSpan = ServerLifeSpan;
	}
	else
	{
		SetTemplate(EmitterTemplate,true);
	}
}

defaultproperties
{
   ServerLifeSpan=0.200000
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTEmitter:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   RemoteRole=ROLE_SimulatedProxy
   bNetTemporary=True
   bNetInitialRotation=True
   Name="Default__UTReplicatedEmitter"
   ObjectArchetype=UTEmitter'UTGame.Default__UTEmitter'
}
