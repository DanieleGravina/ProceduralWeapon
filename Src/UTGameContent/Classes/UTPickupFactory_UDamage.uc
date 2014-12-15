/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_UDamage extends UTPowerupPickupFactory;


simulated event InitPickupMeshEffects()
{
	Super.InitPickupMeshEffects();

	// Create a material instance for the pickup
	if (bDoVisibilityFadeIn && MeshComponent(PickupMesh) != None)
	{
		MIC_VisibilitySecondMaterial = MeshComponent(PickupMesh).CreateAndSetMaterialInstanceConstant(1);
		MIC_VisibilitySecondMaterial.SetScalarParameterValue(VisibilityParamName, bIsSuperItem ? 1.f : 0.f);
	}
}


simulated function SetResOut()
{
	Super.SetResOut();

	if (bDoVisibilityFadeIn && MIC_VisibilitySecondMaterial != None)
	{
		MIC_VisibilitySecondMaterial.SetScalarParameterValue(VisibilityParamName, 1.f);
	}
}

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
   End Object
   Spinner=StaticMeshComponent1
   Begin Object Class=UTParticleSystemComponent Name=DamageParticles ObjName=DamageParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.UDamage.Effects.P_Pickups_UDamage_Idle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Name="DamageParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ParticleEffects=DamageParticles
   bHasLocationSpeech=True
   BaseBrightEmissive=(R=4.000000,G=1.000000,B=10.000000,A=1.000000)
   BaseDimEmissive=(R=1.000000,G=0.250000,B=2.500000,A=1.000000)
   RespawnSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_SpawnCue'
   Begin Object Class=AudioComponent Name=DamageReady ObjName=DamageReady Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_UDamage_GroundLoopCue'
      Name="DamageReady"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   PickupReadySound=DamageReady
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   PickupStatName="PICKUPS_UDAMAGE"
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheUDamage'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheUDamage'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheUDamage'
   InventoryType=Class'UTGameContent.UTUDamage'
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTPowerupPickupFactory:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTPowerupPickupFactory:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTPowerupPickupFactory:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTPowerupPickupFactory:PathRenderer'
   End Object
   Components(1)=PathRenderer
   Components(2)=PickupLightEnvironment
   Begin Object Class=StaticMeshComponent Name=BaseMeshComp ObjName=BaseMeshComp Archetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:BaseMeshComp'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:BaseMeshComp'
   End Object
   Components(3)=BaseMeshComp
   Components(4)=StaticMeshComponent1
   Components(5)=DamageParticles
   Components(6)=DamageReady
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_UDamage"
   ObjectArchetype=UTPowerupPickupFactory'UTGame.Default__UTPowerupPickupFactory'
}
