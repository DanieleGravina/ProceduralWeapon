/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_SPMAShellChild extends UTProjectile;

defaultproperties
{
   ExplosionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_ShellFragmentExplode'
   ProjFlightTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_MiniProjectile'
   ProjExplosionTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_Primary_Shell_Ground_Explo'
   ExplosionLightClass=Class'UTGame.UTCicadaRocketExplosionLight'
   Speed=4000.000000
   MaxSpeed=4000.000000
   bRotationFollowsVelocity=True
   Damage=220.000000
   DamageRadius=500.000000
   MomentumTransfer=175000.000000
   MyDamageType=Class'UTGameContent.UTDmgType_SPMASmallShell'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProjectile:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Physics=PHYS_Falling
   bNetTemporary=False
   LifeSpan=8.000000
   DrawScale=0.700000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SPMAShellChild"
   ObjectArchetype=UTProjectile'UTGame.Default__UTProjectile'
}
