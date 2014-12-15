/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_SuperHealth extends UTHealthPickupFactory;


var ParticleSystemComponent Crackle; // the crackling lightning effect that surrounds the keg on spawn

simulated function RespawnEffect()
{
	super.RespawnEffect();
	Crackle.SetActive(true);
}

simulated function SetPickupHidden()
{
	Glow.SetFloatParameter('LightStrength',0.0f);
	Super.SetPickupHidden();
}

simulated function SetPickupVisible()
{
	Super.SetPickupVisible();
	Glow.SetFloatParameter('LightStrength', 1.0f);
}

defaultproperties
{
   Begin Object Class=UTParticleSystemComponent Name=ParticleCrackle ObjName=ParticleCrackle Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Health_Large.Effects.P_Pickups_Base_Health_Spawn'
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      Name="ParticleCrackle"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   Crackle=ParticleCrackle
   HealingAmount=100
   bSuperHeal=True
   PickupSound=SoundCue'A_Pickups.Health.Cue.A_Pickups_Health_Super_Cue'
   RespawnTime=60.000000
   bRotatingPickup=True
   bHasLocationSpeech=True
   YawRotationRate=16384.000000
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHealthPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTHealthPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   Begin Object Class=UTParticleSystemComponent Name=ParticleGlow ObjName=ParticleGlow Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Health_Large.Effects.P_Pickups_Base_Health_Glow'
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      Name="ParticleGlow"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   Glow=ParticleGlow
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheSuperhealth'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheSuperhealth'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheSuperHealth'
   bPredictRespawns=True
   bIsSuperItem=True
   MaxDesireability=2.000000
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
      Rotation=(Pitch=0,Yaw=16384,Roll=0)
      Scale=0.800000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Begin Object Class=StaticMeshComponent Name=HealthPickUpMesh ObjName=HealthPickUpMesh Archetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:HealthPickUpMesh'
      StaticMesh=StaticMesh'PICKUPS.Health_Large.Mesh.S_Pickups_Health_Large_Keg'
      Materials(0)=Material'PICKUPS.Health_Large.Materials.M_Pickups_Health_Large_Keg'
      CullDistance=7000.000000
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTHealthPickupFactory:HealthPickUpMesh'
   End Object
   Components(4)=HealthPickUpMesh
   Components(5)=ParticleGlow
   Components(6)=ParticleCrackle
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_SuperHealth"
   ObjectArchetype=UTHealthPickupFactory'UTGame.Default__UTHealthPickupFactory'
}
