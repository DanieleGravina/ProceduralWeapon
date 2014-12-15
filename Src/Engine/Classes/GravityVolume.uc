/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class GravityVolume extends PhysicsVolume
	native
	placeable;

/**
 *	Simple PhysicsVolume that modifies the gravity inside it.
 */

/** Gravity along Z axis applied to objects inside this volume. */
var()	float	GravityZ;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   GravityZ=-520.000000
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
      ObjectArchetype=BrushComponent'Engine.Default__PhysicsVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   CollisionComponent=BrushComponent0
   CollisionType=COLLIDE_CustomDefault
   Name="Default__GravityVolume"
   ObjectArchetype=PhysicsVolume'Engine.Default__PhysicsVolume'
}
