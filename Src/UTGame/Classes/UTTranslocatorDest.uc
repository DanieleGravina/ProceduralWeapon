/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/** builds UTTranslocatorReachSpecs towards this node for each entry in the StartPoints array  */
class UTTranslocatorDest extends NavigationPoint
	native
	placeable;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

struct native TranslocatorSource
{
	/** the actual source point */
	var() NavigationPoint Point;
	/** if set, try to determine target translocator disc velocity/special jump Z automatically */
	var() bool bAutoDetectVelocity;
	/** translocator disc velocity the AI should use */
	var() vector RequiredTransVelocity;
	/** Jump Z velocity AI must be able to attain to jump here, or <= 0 if this point cannot be reached by jumping */
	var() float RequiredJumpZ;

	structdefaultproperties
	{
		bAutoDetectVelocity=true
	}
};

/** list of points that the AI can translocate/specialjump to this node from */
var() array<TranslocatorSource> StartPoints;

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__NavigationPoint:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__UTTranslocatorDest"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
