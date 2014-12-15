/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class LeviathanBlockingVolume extends BlockingVolume
	placeable;

defaultproperties
{
   bClampFluid=False
   BrushColor=(B=128,G=200,R=32,A=255)
   bColored=True
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__BlockingVolume:BrushComponent0'
      CollideActors=False
      BlockActors=False
      BlockNonZeroExtent=False
      RBChannel=RBCC_Untitled2
      ObjectArchetype=BrushComponent'Engine.Default__BlockingVolume:BrushComponent0'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   bCollideActors=False
   bBlockActors=False
   CollisionComponent=BrushComponent0
   Name="Default__LeviathanBlockingVolume"
   ObjectArchetype=BlockingVolume'Engine.Default__BlockingVolume'
}
