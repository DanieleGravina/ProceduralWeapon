/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class UTEmit_TransLocateOutRed extends UTEmit_TransLocateOut;

defaultproperties
{
   FirstPersonTemplate=ParticleSystem'Envy_Effects.Particles.P_Player_Spawn_Red'
   EmitterTemplate=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_Teleport_Red'
   Begin Object Class=ParticleSystemComponent Name=ParticleSystemComponent0 ObjName=ParticleSystemComponent0 Archetype=ParticleSystemComponent'UTGame.Default__UTEmit_TransLocateOut:ParticleSystemComponent0'
      ObjectArchetype=ParticleSystemComponent'UTGame.Default__UTEmit_TransLocateOut:ParticleSystemComponent0'
   End Object
   ParticleSystemComponent=ParticleSystemComponent0
   Components(0)=ParticleSystemComponent0
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTEmit_TransLocateOut:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTEmit_TransLocateOut:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTEmit_TransLocateOutRed"
   ObjectArchetype=UTEmit_TransLocateOut'UTGame.Default__UTEmit_TransLocateOut'
}
