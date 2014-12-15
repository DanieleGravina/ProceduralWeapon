/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTPickupLight extends Light
	abstract
	native;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Light:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Light:Sprite'
   End Object
   Components(0)=Sprite
   DrawScale=0.250000
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTPickupLight"
   ObjectArchetype=Light'Engine.Default__Light'
}
