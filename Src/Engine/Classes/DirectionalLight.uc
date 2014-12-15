/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DirectionalLight extends Light
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

defaultproperties
{
   Begin Object Class=DirectionalLightComponent Name=DirectionalLightComponent0 ObjName=DirectionalLightComponent0 Archetype=DirectionalLightComponent'Engine.Default__DirectionalLightComponent'
      UseDirectLightMap=True
      Name="DirectionalLightComponent0"
      ObjectArchetype=DirectionalLightComponent'Engine.Default__DirectionalLightComponent'
   End Object
   LightComponent=DirectionalLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Light:Sprite'
      Sprite=Texture2D'EngineResources.LightIcons.Light_Directional_Stationary_UserSelected'
      ObjectArchetype=SpriteComponent'Engine.Default__Light:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=DirectionalLightComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=255,G=200,R=150,A=255)
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(2)=ArrowComponent0
   Rotation=(Pitch=-16384,Yaw=0,Roll=0)
   DesiredRotation=(Pitch=-16384,Yaw=0,Roll=0)
   Name="Default__DirectionalLight"
   ObjectArchetype=Light'Engine.Default__Light'
}
