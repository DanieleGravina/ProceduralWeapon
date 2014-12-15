/**
 *
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */


class UTEmit_OnslaughtOrbExplosion_Blue extends UTReplicatedEmitter;

simulated event PostBeginPlay()
{
	Super.PostBeginPlay();
	
	if ( WorldInfo.NetMode != NM_DedicatedServer )
	{
		PlaySound(class'UTOnslaughtFlag_Content'.default.ReturnedSound, true);
	}
}

defaultproperties
{
   EmitterTemplate=ParticleSystem'PICKUPS.PowerCell.Effects.P_Pickups_PowerCell_Explode_Blue'
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTReplicatedEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   Name="Default__UTEmit_OnslaughtOrbExplosion_Blue"
   ObjectArchetype=UTReplicatedEmitter'UTGame.Default__UTReplicatedEmitter'
}
