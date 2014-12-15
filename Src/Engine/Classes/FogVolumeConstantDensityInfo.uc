/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class FogVolumeConstantDensityInfo extends FogVolumeDensityInfo
	showcategories(Movement)
	native(FogVolume)
	placeable;

defaultproperties
{
   Begin Object Class=FogVolumeConstantDensityComponent Name=FogVolumeComponent0 ObjName=FogVolumeComponent0 Archetype=FogVolumeConstantDensityComponent'Engine.Default__FogVolumeConstantDensityComponent'
      Name="FogVolumeComponent0"
      ObjectArchetype=FogVolumeConstantDensityComponent'Engine.Default__FogVolumeConstantDensityComponent'
   End Object
   DensityComponent=FogVolumeComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__FogVolumeDensityInfo:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=FogVolumeComponent0
   Name="Default__FogVolumeConstantDensityInfo"
   ObjectArchetype=FogVolumeDensityInfo'Engine.Default__FogVolumeDensityInfo'
}
