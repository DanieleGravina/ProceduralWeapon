/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTShapedCharge_Red extends UTShapedCharge;

defaultproperties
{
   Begin Object Class=ParticleSystemComponent Name=ConstantEffect ObjName=ConstantEffect Archetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
      Template=ParticleSystem'WP_Translocator.Particles.P_WP_Translocator_Beacon'
      bAutoActivate=False
      SecondsBeforeInactive=1.000000
      Name="ConstantEffect"
      ObjectArchetype=ParticleSystemComponent'Engine.Default__ParticleSystemComponent'
   End Object
   LandEffects=ConstantEffect
   Begin Object Class=SkeletalMeshComponent Name=DeployableMesh ObjName=DeployableMesh Archetype=SkeletalMeshComponent'UTGameContent.Default__UTShapedCharge:DeployableMesh'
      ObjectArchetype=SkeletalMeshComponent'UTGameContent.Default__UTShapedCharge:DeployableMesh'
   End Object
   Mesh=DeployableMesh
   Begin Object Class=DynamicLightEnvironmentComponent Name=DeployedLightEnvironment ObjName=DeployedLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTShapedCharge:DeployedLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGameContent.Default__UTShapedCharge:DeployedLightEnvironment'
   End Object
   LightEnvironment=DeployedLightEnvironment
   Components(0)=DeployedLightEnvironment
   Components(1)=DeployableMesh
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGameContent.Default__UTShapedCharge:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGameContent.Default__UTShapedCharge:CollisionCylinder'
   End Object
   Components(2)=CollisionCylinder
   Components(3)=ConstantEffect
   CollisionComponent=CollisionCylinder
   Name="Default__UTShapedCharge_Red"
   ObjectArchetype=UTShapedCharge'UTGameContent.Default__UTShapedCharge'
}
