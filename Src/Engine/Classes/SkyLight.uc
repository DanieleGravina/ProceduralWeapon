/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SkyLight extends Light
	native
	placeable;

defaultproperties
{
   Begin Object Class=SkyLightComponent Name=SkyLightComponent0 ObjName=SkyLightComponent0 Archetype=SkyLightComponent'Engine.Default__SkyLightComponent'
      UseDirectLightMap=True
      bCanAffectDynamicPrimitivesOutsideDynamicChannel=True
      Name="SkyLightComponent0"
      ObjectArchetype=SkyLightComponent'Engine.Default__SkyLightComponent'
   End Object
   LightComponent=SkyLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Light:Sprite'
      Sprite=Texture2D'EngineResources.S_SkyLight'
      ObjectArchetype=SpriteComponent'Engine.Default__Light:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=SkyLightComponent0
   Name="Default__SkyLight"
   ObjectArchetype=Light'Engine.Default__Light'
}
