/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class WindDirectionalSource extends Info
	placeable;

var() const editconst WindDirectionalSourceComponent	Component;

defaultproperties
{
   Begin Object Class=WindDirectionalSourceComponent Name=WindDirectionalSourceComponent0 ObjName=WindDirectionalSourceComponent0 Archetype=WindDirectionalSourceComponent'Engine.Default__WindDirectionalSourceComponent'
      Name="WindDirectionalSourceComponent0"
      ObjectArchetype=WindDirectionalSourceComponent'Engine.Default__WindDirectionalSourceComponent'
   End Object
   Component=WindDirectionalSourceComponent0
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Info:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Info:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=WindDirectionalSourceComponent0
   Begin Object Class=ArrowComponent Name=ArrowComponent0 ObjName=ArrowComponent0 Archetype=ArrowComponent'Engine.Default__ArrowComponent'
      ArrowColor=(B=255,G=200,R=150,A=255)
      Name="ArrowComponent0"
      ObjectArchetype=ArrowComponent'Engine.Default__ArrowComponent'
   End Object
   Components(2)=ArrowComponent0
   bStatic=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__WindDirectionalSource"
   ObjectArchetype=Info'Engine.Default__Info'
}
