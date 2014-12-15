/**
 * Movable version of SpotLight.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SpotLightMovable extends SpotLight
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

defaultproperties
{
   Begin Object Class=SpotLightComponent Name=SpotLightComponent0 ObjName=SpotLightComponent0 Archetype=SpotLightComponent'Engine.Default__SpotLight:SpotLightComponent0'
      CastDynamicShadows=True
      UseDirectLightMap=False
      LightingChannels=(Dynamic=True)
      LightAffectsClassification=LAC_DYNAMIC_AND_STATIC_AFFECTING
      ObjectArchetype=SpotLightComponent'Engine.Default__SpotLight:SpotLightComponent0'
   End Object
   LightComponent=SpotLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpotLight:Sprite'
      Sprite=Texture2D'EngineResources.LightIcons.Light_Spot_Moveable_DynamicsAndStatics'
      ObjectArchetype=SpriteComponent'Engine.Default__SpotLight:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=DrawLightRadiusComponent Name=DrawLightRadius0 ObjName=DrawLightRadius0 Archetype=DrawLightRadiusComponent'Engine.Default__SpotLight:DrawLightRadius0'
      ObjectArchetype=DrawLightRadiusComponent'Engine.Default__SpotLight:DrawLightRadius0'
   End Object
   Components(1)=DrawLightRadius0
   Begin Object Class=DrawLightConeComponent Name=DrawInnerCone0 ObjName=DrawInnerCone0 Archetype=DrawLightConeComponent'Engine.Default__SpotLight:DrawInnerCone0'
      ObjectArchetype=DrawLightConeComponent'Engine.Default__SpotLight:DrawInnerCone0'
   End Object
   Components(2)=DrawInnerCone0
   Begin Object Class=DrawLightConeComponent Name=DrawOuterCone0 ObjName=DrawOuterCone0 Archetype=DrawLightConeComponent'Engine.Default__SpotLight:DrawOuterCone0'
      ObjectArchetype=DrawLightConeComponent'Engine.Default__SpotLight:DrawOuterCone0'
   End Object
   Components(3)=DrawOuterCone0
   Components(4)=SpotLightComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__SpotLight:ArrowComponent0'
      ObjectArchetype=ArrowComponent'Engine.Default__SpotLight:ArrowComponent0'
   End Object
   Components(5)=ArrowComponent0
   TickGroup=TG_DuringAsyncWork
   bStatic=False
   bHardAttach=True
   bMovable=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__SpotLightMovable"
   ObjectArchetype=SpotLight'Engine.Default__SpotLight'
}
