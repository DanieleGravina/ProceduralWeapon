/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTProj_TransDisc_ContentBlue extends UTProj_TransDisc;

defaultproperties
{
   Begin Object Class=UTParticleSystemComponent Name=BrokenPCS ObjName=BrokenPCS Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_Broken_Blue'
      HiddenGame=True
      Name="BrokenPCS"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   DisruptedEffect=BrokenPCS
   DisruptedSound=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Disrupted_Cue'
   Begin Object Class=AudioComponent Name=DisruptionSound ObjName=DisruptionSound Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_DisruptedLoop_Cue'
      Name="DisruptionSound"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   DisruptedLoop=DisruptionSound
   BounceTemplate=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_BounceEffect_Blue'
   BounceSound=SoundCue'A_Weapon_Translocator.Translocator.A_Weapon_Translocator_Bounce_Cue'
   Begin Object Class=ParticleSystemComponent Name=ConstantEffect ObjName=ConstantEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_Beacon_Blue'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      Name="ConstantEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LandEffects=ConstantEffect
   ProjFlightTemplate=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_Trail'
   ProjectileLightClass=Class'UTGame.UTTranslocatorLightBlue'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTProj_TransDisc:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTProj_TransDisc:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=StaticMeshComponent Name=ProjectileMesh ObjName=ProjectileMesh Archetype=StaticMeshComponent'UTGame.Default__UTProj_TransDisc:ProjectileMesh'
      StaticMesh=StaticMesh'WP_Translocator.Mesh.S_Translocator_Disk'
      Materials(0)=Material'WP_Translocator.Materials.M_WP_Translocator_1PBlue_unlit'
      Scale=2.000000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTProj_TransDisc:ProjectileMesh'
   End Object
   Components(1)=ProjectileMesh
   Components(2)=ConstantEffect
   Components(3)=BrokenPCS
   Components(4)=DisruptionSound
   CollisionComponent=CollisionCylinder
   Name="Default__UTProj_TransDisc_ContentBlue"
   ObjectArchetype=UTProj_TransDisc'UTGame.Default__UTProj_TransDisc'
}
