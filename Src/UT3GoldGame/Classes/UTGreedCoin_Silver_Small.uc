/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGreedCoin_Silver_Small extends UTGreedCoin_Silver;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'UT3GoldGame.Default__UTGreedCoin_Silver:MeshComponentA'
      ObjectArchetype=StaticMeshComponent'UT3GoldGame.Default__UTGreedCoin_Silver:MeshComponentA'
   End Object
   PickupMesh=MeshComponentA
   Begin Object Class=DynamicLightEnvironmentComponent Name=DroppedPickupLightEnvironment ObjName=DroppedPickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UT3GoldGame.Default__UTGreedCoin_Silver:DroppedPickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UT3GoldGame.Default__UTGreedCoin_Silver:DroppedPickupLightEnvironment'
   End Object
   MyLightEnvironment=DroppedPickupLightEnvironment
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UT3GoldGame.Default__UTGreedCoin_Silver:Sprite'
      ObjectArchetype=SpriteComponent'UT3GoldGame.Default__UTGreedCoin_Silver:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UT3GoldGame.Default__UTGreedCoin_Silver:CollisionCylinder'
      CollisionRadius=21.000000
      ObjectArchetype=CylinderComponent'UT3GoldGame.Default__UTGreedCoin_Silver:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Components(2)=DroppedPickupLightEnvironment
   Components(3)=MeshComponentA
   CollisionComponent=CollisionCylinder
   Name="Default__UTGreedCoin_Silver_Small"
   ObjectArchetype=UTGreedCoin_Silver'UT3GoldGame.Default__UTGreedCoin_Silver'
}
