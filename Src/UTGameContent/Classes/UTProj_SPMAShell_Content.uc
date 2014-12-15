/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */

class UTProj_SPMAShell_Content extends UTProj_SPMAShell;

defaultproperties
{
   ChildProjectileClass=Class'UTGameContent.UTProj_SPMAShellChild'
   ExplosionSound=SoundCue'A_Vehicle_SPMA.SoundCues.A_Vehicle_SPMA_ShellBrakingExplode'
   ProjFlightTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_PrimaryProjectile'
   ProjExplosionTemplate=ParticleSystem'VH_SPMA.Effects.P_VH_SPMA_Primary_Shell_InAir_Explo'
   MyDamageType=Class'UTGameContent.UTDmgType_SPMAShell'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_SPMAShell:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_SPMAShell:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   DrawScale=0.700000
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_SPMAShell_Content"
   ObjectArchetype=UTProj_SPMAShell'UTGame.Default__UTProj_SPMAShell'
}
