/**
 * Copyright 1998-2007 Epic Games, Inc. All Rights Reserved.
 */
class UTWarfareBarricade_Concrete extends UTWarfareBarricade;

defaultproperties
{
   ShieldHitSound=SoundCue'A_Gameplay.ONS.A_GamePlay_ONS_CoreImpactShieldedCue'
   DisabledAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_BarricadeDestroyed')
   AttackAnnouncement=(AnnouncementSound=SoundNodeWave'A_Announcer_Status.Status.A_StatusAnnouncer_DestroyTheBarricade')
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTWarfareBarricade:CollisionCylinder'
      CollisionRadius=100.000000
      ObjectArchetype=CylinderComponent'UTGame.Default__UTWarfareBarricade:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTWarfareBarricade:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTWarfareBarricade:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'UTGame.Default__UTWarfareBarricade:Sprite2'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTWarfareBarricade:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTWarfareBarricade:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTWarfareBarricade:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTWarfareBarricade:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTWarfareBarricade:PathRenderer'
   End Object
   Components(4)=PathRenderer
   Begin Object Class=StaticMeshComponent Name=Mesh0 ObjName=Mesh0 Archetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
      StaticMesh=StaticMesh'HU_Deco.SM.Mesh.S_HU_DECO_Barrier'
      bForceDirectLightMap=True
      LightingChannels=(BSP=True,Static=True)
      Translation=(X=0.000000,Y=0.000000,Z=-60.000000)
      Scale=2.000000
      Name="Mesh0"
      ObjectArchetype=StaticMeshComponent'Engine.Default__StaticMeshComponent'
   End Object
   Components(5)=Mesh0
   CollisionComponent=Mesh0
   Name="Default__UTWarfareBarricade_Concrete"
   ObjectArchetype=UTWarfareBarricade'UTGame.Default__UTWarfareBarricade'
}
