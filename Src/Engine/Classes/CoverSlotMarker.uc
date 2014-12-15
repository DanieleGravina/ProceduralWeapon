/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class CoverSlotMarker extends NavigationPoint
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() editconst CoverInfo OwningSlot;

event PostBeginPlay()
{
	super.PostBeginPlay();

	if (OwningSlot.Link != None)
	{
		bBlocked = OwningSlot.Link.bBlocked;
	}
}

simulated function int ExtraPathCost( Controller AI )
{
	if( !OwningSlot.Link.IsValidClaim( AI, OwningSlot.SlotIdx, TRUE ) )
	{
		return class'ReachSpec'.const.BLOCKEDPATHCOST;
	}
	return 0;
}

simulated function Vector GetSlotLocation()
{
	if( OwningSlot.Link != None )
	{
		return OwningSlot.Link.GetSlotLocation(OwningSlot.SlotIdx);
	}

	return vect(0,0,0);
}

simulated function Rotator GetSlotRotation()
{
	if( OwningSlot.Link != None )
	{
		return OwningSlot.Link.GetSlotRotation(OwningSlot.SlotIdx);
	}

	return rot(0,0,0);
}

defaultproperties
{
   bSpecialMove=True
   Cost=300
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      CollisionHeight=40.000000
      CollisionRadius=40.000000
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
   Components(0)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__NavigationPoint:PathRenderer'
   End Object
   Components(1)=PathRenderer
   bCollideWhenPlacing=False
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__CoverSlotMarker"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
