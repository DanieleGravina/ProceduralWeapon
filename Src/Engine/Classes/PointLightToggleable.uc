/**
 * Toggleable version of PointLight.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class PointLightToggleable extends PointLight
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
   Begin Object Class=PointLightComponent Name=PointLightComponent0 ObjName=PointLightComponent0 Archetype=PointLightComponent'Engine.Default__PointLight:PointLightComponent0'
      UseDirectLightMap=False
      ObjectArchetype=PointLightComponent'Engine.Default__PointLight:PointLightComponent0'
   End Object
   LightComponent=PointLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__PointLight:Sprite'
      Sprite=Texture2D'EngineResources.LightIcons.Light_Point_Toggleable_Statics'
      ObjectArchetype=SpriteComponent'Engine.Default__PointLight:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=DrawLightRadiusComponent Name=DrawLightRadius0 ObjName=DrawLightRadius0 Archetype=DrawLightRadiusComponent'Engine.Default__PointLight:DrawLightRadius0'
      ObjectArchetype=DrawLightRadiusComponent'Engine.Default__PointLight:DrawLightRadius0'
   End Object
   Components(1)=DrawLightRadius0
   Components(2)=PointLightComponent0
   TickGroup=TG_DuringAsyncWork
   bStatic=False
   bHardAttach=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__PointLightToggleable"
   ObjectArchetype=PointLight'Engine.Default__PointLight'
}
