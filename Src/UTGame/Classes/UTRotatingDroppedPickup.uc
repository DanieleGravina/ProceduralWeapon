/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class UTRotatingDroppedPickup extends UTDroppedPickup;

defaultproperties
{
   bRotatingPickup=True
   Begin Object Class=DynamicLightEnvironmentComponent Name=DroppedPickupLightEnvironment ObjName=DroppedPickupLightEnvironment Archetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDroppedPickup:DroppedPickupLightEnvironment'
      ObjectArchetype=DynamicLightEnvironmentComponent'UTGame.Default__UTDroppedPickup:DroppedPickupLightEnvironment'
   End Object
   MyLightEnvironment=DroppedPickupLightEnvironment
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTDroppedPickup:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTDroppedPickup:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTDroppedPickup:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTDroppedPickup:CollisionCylinder'
   End Object
   Components(1)=CollisionCylinder
   Components(2)=DroppedPickupLightEnvironment
   CollisionComponent=CollisionCylinder
   Name="Default__UTRotatingDroppedPickup"
   ObjectArchetype=UTDroppedPickup'UTGame.Default__UTDroppedPickup'
}
