/**
 * effect that links the orb to a node it's protecting. In C++ we do extra work to make sure the beam start point stays inside the orb mesh 
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 **/
class UTEmit_OrbLinkEffect extends UTEmitter
	native(Onslaught);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTEmitter:ParticleSystemComponent0'
      bUpdateComponentInTick=True
      Translation=(X=0.000000,Y=5.000000,Z=5.000000)
      AbsoluteRotation=True
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTEmitter:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   LifeSpan=0.000000
   Name="Default__UTEmit_OrbLinkEffect"
   ObjectArchetype=UTEmitter'UTGame.Default__UTEmitter'
}
