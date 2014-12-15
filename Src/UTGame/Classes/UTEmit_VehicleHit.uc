/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTEmit_VehicleHit extends UTEmit_HitEffect;

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTEmit_HitEffect:ParticleSystemComponent0'
      Template=ParticleSystem'FX_VehicleExplosions.Effects.PS_Vehicle_DamageImpact'
      bOwnerNoSee=True
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTEmit_HitEffect:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   Name="Default__UTEmit_VehicleHit"
   ObjectArchetype=UTEmit_HitEffect'UTGame.Default__UTEmit_HitEffect'
}
