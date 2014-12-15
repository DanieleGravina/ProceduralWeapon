/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_RaptorRocket extends UTProj_SeekingRocket;

defaultproperties
{
   bSuperSeekAirTargets=True
   LockWarningInterval=1.500000
   ProjFlightTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_Rocket_trail_Blue'
   ProjExplosionTemplate=ParticleSystem'VH_Raptor.Effects.P_Raptor_RocketExplosion_Blue'
   AccelRate=16000.000000
   Speed=2000.000000
   MaxSpeed=4000.000000
   DamageRadius=150.000000
   MomentumTransfer=50000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_RaptorRocket'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_SeekingRocket:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_SeekingRocket:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_RaptorRocket"
   ObjectArchetype=UTProj_SeekingRocket'UTGame.Default__UTProj_SeekingRocket'
}
