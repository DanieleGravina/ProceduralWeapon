/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTGreedCoin_Gold_Small extends UTGreedCoin_Gold;

defaultproperties
{
   Begin Object Class=StaticMeshComponent Name=MeshComponentA ObjName=MeshComponentA Archetype=StaticMeshComponent'UT3GoldGame.Default__UTGreedCoin_Gold:MeshComponentA'
      ObjectArchetype=StaticMeshComponent'UT3GoldGame.Default__UTGreedCoin_Gold:MeshComponentA'
   End Object
   PickupMesh=MeshComponentA
   Begin Object Class=DynamicLightEnvironmentComponent Name=DroppedPickupLightEnvironment ObjName=DroppedPickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UT3GoldGame.Default__UTGreedCoin_Gold:DroppedPickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UT3GoldGame.Default__UTGreedCoin_Gold:DroppedPickupLightEnvironment'
   End Object
   MyLightEnvironment=DroppedPickupLightEnvironment
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UT3GoldGame.Default__UTGreedCoin_Gold:Sprite'
      ObjectArchetype=SpriteComponent'UT3GoldGame.Default__UTGreedCoin_Gold:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UT3GoldGame.Default__UTGreedCoin_Gold:CollisionCylinder'
      CollisionHeight=20.000000
      CollisionRadius=21.000000
      ObjectArchetype=CylinderComponent'UT3GoldGame.Default__UTGreedCoin_Gold:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Components(2)=DroppedPickupLightEnvironment
   Components(3)=MeshComponentA
   CollisionComponent=CollisionCylinder
   Name="Default__UTGreedCoin_Gold_Small"
   ObjectArchetype=UTGreedCoin_Gold'UT3GoldGame.Default__UTGreedCoin_Gold'
}
