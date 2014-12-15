/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class EmitterSpawnable extends Emitter
	notplaceable;

var repnotify ParticleSystem ParticleTemplate;

replication
{
	if (bNetInitial)
		ParticleTemplate;
}

simulated event SetTemplate(ParticleSystem NewTemplate, optional bool bDestroyOnFinish)
{
	Super.SetTemplate(NewTemplate, bDestroyOnFinish);

	ParticleTemplate = NewTemplate;
}

simulated event ReplicatedEvent(name VarName)
{
	if (VarName == 'ParticleTemplate')
	{
		SetTemplate(ParticleTemplate, bDestroyOnSystemFinish);
		ParticleSystemComponent.ActivateSystem();
		if (ParticleTemplate == None && bDestroyOnSystemFinish)
		{
			// prevent emitter from hanging around forever with no template
			Destroy();
		}
	}
	else
	{
		Super.ReplicatedEvent(VarName);
	}
}

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'Engine.Default__Emitter:ParticleSystemComponent0'
      SecondsBeforeInactive=0.000000
      ObjectArchetype=ParticleSystemComponent'Engine.Default__Emitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   bDestroyOnSystemFinish=True
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Emitter:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Emitter:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=ParticleSystemComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__Emitter:ArrowComponent0'
      ObjectArchetype=ArrowComponent'Engine.Default__Emitter:ArrowComponent0'
   End Object
   Components(2)=ArrowComponent0
   bNoDelete=False
   bNetTemporary=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__EmitterSpawnable"
   ObjectArchetype=Emitter'Engine.Default__Emitter'
}
