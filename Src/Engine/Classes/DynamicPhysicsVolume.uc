/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * This is a movable physics volume. It can be moved by matinee, being based on
 * dynamic objects, etc.
 */
class DynamicPhysicsVolume extends PhysicsVolume
	showcategories(Movement)
	placeable;

defaultproperties
{
   BrushColor=(B=255,G=255,R=100,A=255)
   bColored=True
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
      ObjectArchetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   Physics=PHYS_Interpolating
   bStatic=False
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__DynamicPhysicsVolume"
   ObjectArchetype=PhysicsVolume'Engine.Default__PhysicsVolume'
}
