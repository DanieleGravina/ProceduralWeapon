/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SkyLightToggleable extends SkyLight
	native
	placeable;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=SkyLightComponent Name=SkyLightComponent0 ObjName=SkyLightComponent0 Archetype=SkyLightComponent'Engine.Default__SkyLight:SkyLightComponent0'
      ObjectArchetype=SkyLightComponent'Engine.Default__SkyLight:SkyLightComponent0'
   End Object
   LightComponent=SkyLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SkyLight:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__SkyLight:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=SkyLightComponent0
   TickGroup=TG_DuringAsyncWork
   bStatic=False
   bHardAttach=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__SkyLightToggleable"
   ObjectArchetype=SkyLight'Engine.Default__SkyLight'
}
