/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTEmit_HitEffect extends UTEmitter;

simulated function AttachTo(Pawn P, name NewBoneName)
{
	if (NewBoneName == '')
	{
		SetBase(P);
	}
	else
	{
		SetBase(P,, P.Mesh, NewBoneName);
	}
}

simulated function PawnBaseDied()
{
	if (ParticleSystemComponent != None)
	{
		ParticleSystemComponent.DeactivateSystem();
	}
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTEmitter:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   Name="Default__UTEmit_HitEffect"
   ObjectArchetype=UTEmitter'UTGame.Default__UTEmitter'
}
