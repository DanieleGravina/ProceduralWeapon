/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_MediumHealth extends UTHealthPickupFactory;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	Glow.SetFloatParameter('LightStrength',1.0f);
}

defaultproperties
{
   HealingAmount=25
   PickupSound=SoundCue'A_Pickups.Health.Cue.A_Pickups_Health_Medium_Cue'
   bRotatingPickup=True
   bFloatingPickup=True
   bRandomStart=True
   bTrackPickup=False
   YawRotationRate=16384.000000
   BobOffset=5.000000
   BobSpeed=1.000000
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHealthPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHealthPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   Begin Object Class=UTParticleSystemComponent Name=Glowcomp ObjName=Glowcomp Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Health_Large.Effects.P_Pickups_Base_Health_Glow'
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      Name="Glowcomp"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   Glow=Glowcomp
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTHealthPickupFactory:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTHealthPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTHealthPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTHealthPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:BaseMeshComp'
      StaticMesh=StaticMesh'PICKUPS.Health_Large.Mesh.S_Pickups_Base_Health_Large'
      Translation=(X=0.000000,Y=0.000000,Z=-44.000000)
      Scale=0.800000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Begin Object Class=StaticMeshComponent Name=HealthPickUpMesh ObjName=HealthPickUpMesh Archetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:HealthPickUpMesh'
      StaticMesh=StaticMesh'PICKUPS.Health_Medium.Mesh.S_Pickups_Health_Medium'
      CullDistance=7000.000000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:HealthPickUpMesh'
   End Object
   Components(4)=HealthPickUpMesh
   Components(5)=Glowcomp
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_MediumHealth"
   ObjectArchetype=UTHealthPickupFactory'UTGame.Default__UTHealthPickupFactory'
}
