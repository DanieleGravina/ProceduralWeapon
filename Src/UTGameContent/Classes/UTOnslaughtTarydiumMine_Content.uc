/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTOnslaughtTarydiumMine_Content extends UTOnslaughtTarydiumMine;

defaultproperties
{
   MineColor=(B=255,G=255,R=0,A=0)
   bDestinationOnly=True
   bMustTouchToReach=False
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTOnslaughtTarydiumMine:CollisionCylinder'
      CollisionRadius=250.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTOnslaughtTarydiumMine:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumMine:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumMine:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumMine:Sprite2'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTOnslaughtTarydiumMine:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTOnslaughtTarydiumMine:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTOnslaughtTarydiumMine:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTOnslaughtTarydiumMine:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTOnslaughtTarydiumMine:PathRenderer'
   End Object
   Components(4)=PathRenderer
   Begin Object Class=StaticMeshComponent Name=StaticMeshComponent0 ObjName=StaticMeshComponent0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'UN_Cave.SM.Mesh.S_UN_Cave_SM_Crystal'
      bUseAsOccluder=False
      Translation=(X=0.000000,Y=0.000000,Z=-50.000000)
      Name="StaticMeshComponent0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(5)=StaticMeshComponent0
   bCollideActors=True
   bCollideWorld=True
   bBlockActors=True
   CollisionComponent=StaticMeshComponent0
   Name="Default__UTOnslaughtTarydiumMine_Content"
   ObjectArchetype=UTOnslaughtTarydiumMine'UTGame.Default__UTOnslaughtTarydiumMine'
}
