/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class VolumeTimer extends info;

var PhysicsVolume V;

event PostBeginPlay()
{
	Super.PostBeginPlay();
	SetTimer(1.0, true);
	V = PhysicsVolume(Owner);
}

event Timer()
{
	V.TimerPop(self);
}

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Info:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Info:Sprite'
   End Object
   Components(0)=Sprite
   CollisionType=COLLIDE_CustomDefault
   Name="Default__VolumeTimer"
   ObjectArchetype=Info'Engine.Default__Info'
}
