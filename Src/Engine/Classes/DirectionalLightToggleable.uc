/**
 * Toggleable version of DirectionalLight.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DirectionalLightToggleable extends DirectionalLight
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
   Begin Object Class=DirectionalLightComponent Name=DirectionalLightComponent0 ObjName=DirectionalLightComponent0 Archetype=DirectionalLightComponent'Engine.Default__DirectionalLight:DirectionalLightComponent0'
      UseDirectLightMap=False
      LightAffectsClassification=LAC_DYNAMIC_AND_STATIC_AFFECTING
      ObjectArchetype=DirectionalLightComponent'Engine.Default__DirectionalLight:DirectionalLightComponent0'
   End Object
   LightComponent=DirectionalLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__DirectionalLight:Sprite'
      Sprite=Texture2D'EngineResources.LightIcons.Light_Directional_Toggleable_DynamicsAndStatics'
      ObjectArchetype=SpriteComponent'Engine.Default__DirectionalLight:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=DirectionalLightComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__DirectionalLight:ArrowComponent0'
      ObjectArchetype=ArrowComponent'Engine.Default__DirectionalLight:ArrowComponent0'
   End Object
   Components(2)=ArrowComponent0
   TickGroup=TG_DuringAsyncWork
   bStatic=False
   bHardAttach=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__DirectionalLightToggleable"
   ObjectArchetype=DirectionalLight'Engine.Default__DirectionalLight'
}
