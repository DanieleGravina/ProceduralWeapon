/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeConeDensityInfo extends FogVolumeDensityInfo
	showcategories(Movement)
	native(FogVolume)
	abstract;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=FogVolumeConeDensityComponent Name=FogVolumeComponent0 ObjName=FogVolumeComponent0 Archetype=FogVolumeConeDensityComponent'Engine.Default__FogVolumeConeDensityComponent'
      PreviewCone=DrawLightConeComponent'Engine.Default__FogVolumeConeDensityInfo:DrawCone0'
      Name="FogVolumeComponent0"
      ObjectArchetype=FogVolumeConeDensityComponent'Engine.Default__FogVolumeConeDensityComponent'
   End Object
   DensityComponent=FogVolumeComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=DrawLightConeComponent Name=DrawCone0 ObjName=DrawCone0 Archetype=DrawLightConeComponent'Engine.Default__DrawLightConeComponent'
      ConeColor=(B=255,G=255,R=200,A=255)
      Name="DrawCone0"
      ObjectArchetype=DrawLightConeComponent'Engine.Default__DrawLightConeComponent'
   End Object
   Components(1)=DrawCone0
   Components(2)=FogVolumeComponent0
   Name="Default__FogVolumeConeDensityInfo"
   ObjectArchetype=FogVolumeDensityInfo'Engine.Default__FogVolumeDensityInfo'
}
