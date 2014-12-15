/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_Berserk extends UTPowerupPickupFactory;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
   End Object
   Spinner=StaticMeshComponent1
   Begin Object Class=UTParticleSystemComponent Name=BerserkParticles ObjName=BerserkParticles Archetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
      Template=ParticleSystem'PICKUPS.Berserk.Effects.P_Pickups_Berserk_Idle'
      bAutoActivate=False
      Translation=(X=0.000000,Y=0.000000,Z=5.000000)
      Name="BerserkParticles"
      ObjectArchetype=UTParticleSystemComponent'UTGame.Default__UTParticleSystemComponent'
   End Object
   ParticleEffects=BerserkParticles
   bHasLocationSpeech=True
   BaseBrightEmissive=(R=50.000000,G=1.000000,B=0.000000,A=1.000000)
   BaseDimEmissive=(R=5.000000,G=0.100000,B=0.000000,A=1.000000)
   RespawnSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Berzerk_SpawnCue'
   Begin Object Class=AudioComponent Name=BerserkReady ObjName=BerserkReady Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_Berzerk_GroundLoopCue'
      Name="BerserkReady"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   PickupReadySound=BerserkReady
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   PickupStatName="PICKUPS_BERSERK"
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheBerserk'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheBerserk'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheBerserk'
   InventoryType=Class'UTGameContent.UTBerserk'
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
   Components(5)=BerserkParticles
   Components(6)=BerserkReady
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_Berserk"
   ObjectArchetype=UTPowerupPickupFactory'UTGame.Default__UTPowerupPickupFactory'
}
