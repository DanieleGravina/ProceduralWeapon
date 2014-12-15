/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_Invisibility extends UTPowerupPickupFactory;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
   End Object
   Spinner=StaticMeshComponent1
   Begin Object Class=UTParticleSystemComponent Name=InvisParticles ObjName=InvisParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Invis.Effects.P_Pickups_Invis_Idle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=-20.000000)
      Name="InvisParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ParticleEffects=InvisParticles
   bHasLocationSpeech=True
   BaseBrightEmissive=(R=4.000000,G=4.000000,B=3.000000,A=1.000000)
   BaseDimEmissive=(R=0.500000,G=0.500000,B=0.250000,A=1.000000)
   RespawnSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_SpawnCue'
   Begin Object Class=AudioComponent Name=InvisReady ObjName=InvisReady Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Invisibility_GroundLoopCue'
      Name="InvisReady"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   PickupReadySound=InvisReady
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   PickupStatName="PICKUPS_INVISIBILITY"
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheInvisibility'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheInvisibility'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheInvisibility'
   InventoryType=Class'UTGameContent.UTInvisibility'
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
   Components(5)=InvisReady
   Components(6)=InvisParticles
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_Invisibility"
   ObjectArchetype=UTPowerupPickupFactory'UTGame.Default__UTPowerupPickupFactory'
}
