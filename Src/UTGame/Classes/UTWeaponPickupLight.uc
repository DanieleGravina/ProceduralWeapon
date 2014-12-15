/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTWeaponPickupLight extends UTPickupLight
	native
	placeable;

defaultproperties
{
   Begin Object Class=PointLightComponent Name=PointLightComponent0 ObjName=PointLightComponent0 Archetype=PointLightComponent'Engine.Default__PointLightComponent'
      Radius=128.000000
      Brightness=4.000000
      LightColor=(B=200,G=244,R=251,A=0)
      CastDynamicShadows=False
      UseDirectLightMap=True
      LightingChannels=(Dynamic=False)
      LightAffectsClassification=LAC_STATIC_AFFECTING
      Name="PointLightComponent0"
      ObjectArchetype=PointLightComponent'Engine.Default__PointLightComponent'
   End Object
   LightComponent=PointLightComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTPickupLight:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTPickupLight:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=PointLightComponent0
   Name="Default__UTWeaponPickupLight"
   ObjectArchetype=UTPickupLight'UTGame.Default__UTPickupLight'
}
