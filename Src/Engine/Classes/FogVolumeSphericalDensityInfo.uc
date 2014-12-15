/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeSphericalDensityInfo extends FogVolumeDensityInfo
	showcategories(Movement)
	native(FogVolume)
	placeable;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Begin Object Class=FogVolumeSphericalDensityComponent Name=FogVolumeComponent0 ObjName=FogVolumeComponent0 Archetype=FogVolumeSphericalDensityComponent'Engine.Default__FogVolumeSphericalDensityComponent'
      PreviewSphereRadius=DrawLightRadiusComponent'Engine.Default__FogVolumeSphericalDensityInfo:DrawSphereRadius0'
      Name="FogVolumeComponent0"
      ObjectArchetype=FogVolumeSphericalDensityComponent'Engine.Default__FogVolumeSphericalDensityComponent'
   End Object
   DensityComponent=FogVolumeComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=DrawLightRadiusComponent Name=DrawSphereRadius0 ObjName=DrawSphereRadius0 Archetype=DrawLightRadiusComponent'Engine.Default__DrawLightRadiusComponent'
      Name="DrawSphereRadius0"
      ObjectArchetype=DrawLightRadiusComponent'Engine.Default__DrawLightRadiusComponent'
   End Object
   Components(1)=DrawSphereRadius0
   Components(2)=FogVolumeComponent0
   Name="Default__FogVolumeSphericalDensityInfo"
   ObjectArchetype=FogVolumeDensityInfo'Engine.Default__FogVolumeDensityInfo'
}
