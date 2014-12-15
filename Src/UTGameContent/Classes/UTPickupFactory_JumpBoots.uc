/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupFactory_JumpBoots extends UTPowerupPickupFactory;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent1 ObjName=StaticMeshComponent1 Archetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
      ObjectArchetype=StaticMeshComponent'UTGame.Default__UTPowerupPickupFactory:StaticMeshComponent1'
   End Object
   Spinner=StaticMeshComponent1
   bHasLocationSpeech=True
   BaseBrightEmissive=(R=25.000000,G=25.000000,B=1.000000,A=1.000000)
   BaseDimEmissive=(R=1.000000,G=1.000000,B=0.010000,A=1.000000)
   RespawnSound=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_JumpBoots_SpawnCue'
   Begin Object Class=AudioComponent Name=BootsReady ObjName=BootsReady Archetype=AudioComponent'Engine.Default__AudioComponent'
      SoundCue=SoundCue'A_Pickups_Powerups.Powerups.A_Powerup_JumpBoots_GroundLoopCue'
      Name="BootsReady"
      ObjectArchetype=AudioComponent'Engine.Default__AudioComponent'
   End Object
   PickupReadySound=BootsReady
   Begin Object Class=DynamicLightEnvironmentComponent Name=PickupLightEnvironment ObjName=PickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTPowerupPickupFactory:PickupLightEnvironment'
   End Object
   LightEnvironment=PickupLightEnvironment
   PivotTranslation=(X=0.000000,Y=20.000000,Z=0.000000)
   PickupStatName="PICKUPS_JUMPBOOTS"
   LocationSpeech(0)=SoundNodeWave'A_Character_IGMale.BotStatus.A_BotStatus_IGMale_HeadingForTheJumpBoots'
   LocationSpeech(1)=SoundNodeWave'A_Character_Jester.BotStatus.A_BotStatus_Jester_HeadingForTheJumpBoots'
   LocationSpeech(2)=SoundNodeWave'A_Character_Othello.BotStatus.A_BotStatus_Othello_HeadingForTheJumpBoots'
   bIsSuperItem=False
   InventoryType=Class'UTGameContent.UTJumpBoots'
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
   Components(5)=BootsReady
   CollisionComponent=CollisionCylinder
   Name="Default__UTPickupFactory_JumpBoots"
   ObjectArchetype=UTPowerupPickupFactory'UTGame.Default__UTPowerupPickupFactory'
}
