/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeLinearHalfspaceDensityInfo extends FogVolumeDensityInfo
	showcategories(Movement)
	native(FogVolume)
	placeable;

defaultproperties
{
   Begin Object Class=FogVolumeLinearHalfspaceDensityComponent Name=FogVolumeComponent0 ObjName=FogVolumeComponent0 Archetype=FogVolumeLinearHalfspaceDensityComponent'Engine.Default__FogVolumeLinearHalfspaceDensityComponent'
      Name="FogVolumeComponent0"
      ObjectArchetype=FogVolumeLinearHalfspaceDensityComponent'Engine.Default__FogVolumeLinearHalfspaceDensityComponent'
   End Object
   DensityComponent=FogVolumeComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=FogVolumeComponent0
   Name="Default__FogVolumeLinearHalfspaceDensityInfo"
   ObjectArchetype=FogVolumeDensityInfo'Engine.Default__FogVolumeDensityInfo'
}
