/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class SpotLight extends Light
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

defaultproperties
{
   Begin Object Class=SpotLightComponent Name=SpotLightComponent0 ObjName=SpotLightComponent0 Archetype=SpotLightComponent'Engine.Default__SpotLightComponent'
      PreviewInnerCone=DrawLightConeComponent'Engine.Default__SpotLight:DrawInnerCone0'
      PreviewOuterCone=DrawLightConeComponent'Engine.Default__SpotLight:DrawOuterCone0'
      PreviewLightRadius=DrawLightRadiusComponent'Engine.Default__SpotLight:DrawLightRadius0'
      CastDynamicShadows=False
      UseDirectLightMap=True
      LightingChannels=(Dynamic=False)
      LightAffectsClassification=LAC_STATIC_AFFECTING
      Name="SpotLightComponent0"
      ObjectArchetype=SpotLightComponent'Engine.Default__SpotLightComponent'
   End Object
   LightComponent=SpotLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Light:Sprite'
      Sprite=Texture2D'EngineResources.LightIcons.Light_Spot_Stationary_Statics'
      ObjectArchetype=SpriteComponent'Engine.Default__Light:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=DrawLightRadiusComponent Name=DrawLightRadius0 ObjName=DrawLightRadius0 Archetype=DrawLightRadiusComponent'Engine.Default__DrawLightRadiusComponent'
      Name="DrawLightRadius0"
      ObjectArchetype=DrawLightRadiusComponent'Engine.Default__DrawLightRadiusComponent'
   End Object
   Components(1)=DrawLightRadius0
   Begin Object Class=DrawLightConeComponent Name=DrawInnerCone0 ObjName=DrawInnerCone0 Archetype=DrawLightConeComponent'Engine.Default__DrawLightConeComponent'
      Name="DrawInnerCone0"
      ObjectArchetype=DrawLightConeComponent'Engine.Default__DrawLightConeComponent'
   End Object
   Components(2)=DrawInnerCone0
   Begin Object Class=DrawLightConeComponent Name=DrawOuterCone0 ObjName=DrawOuterCone0 Archetype=DrawLightConeComponent'Engine.Default__DrawLightConeComponent'
      ConeColor=(B=255,G=255,R=200,A=255)
      Name="DrawOuterCone0"
      ObjectArchetype=DrawLightConeComponent'Engine.Default__DrawLightConeComponent'
   End Object
   Components(3)=DrawOuterCone0
   Components(4)=SpotLightComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=255,G=200,R=150,A=255)
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(5)=ArrowComponent0
   Rotation=(Pitch=-16384,Yaw=0,Roll=0)
   DesiredRotation=(Pitch=-16384,Yaw=0,Roll=0)
   Name="Default__SpotLight"
   ObjectArchetype=Light'Engine.Default__Light'
}
