/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTHoldSpot extends UTDefensePoint
	native
	notplaceable;

var UTVehicle HoldVehicle;

/** since HoldSpots aren't part of the prebuilt nav network we need to hook them to another NavigationPoint */
var NavigationPoint LastAnchor;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

function PreBeginPlay()
{
	Super(NavigationPoint).PreBeginPlay();
}

function Actor GetMoveTarget()
{
	if ( HoldVehicle != None )
	{
		if ( HoldVehicle.Health <= 0 )
			HoldVehicle = None;
		if ( HoldVehicle != None )
			return HoldVehicle.GetMoveTargetFor(None);
	}

	return self;
}

function FreePoint()
{
	Destroy();
}

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'UTGame.Default__UTDefensePoint:CollisionCylinder'
      ObjectArchetype=CylinderComponent'UTGame.Default__UTDefensePoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'UTGame.Default__UTDefensePoint:Sprite'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTDefensePoint:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'UTGame.Default__UTDefensePoint:Sprite2'
      ObjectArchetype=SpriteComponent'UTGame.Default__UTDefensePoint:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'UTGame.Default__UTDefensePoint:Arrow'
      ObjectArchetype=ArrowComponent'UTGame.Default__UTDefensePoint:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'UTGame.Default__UTDefensePoint:PathRenderer'
      ObjectArchetype=PathRenderingComponent'UTGame.Default__UTDefensePoint:PathRenderer'
   End Object
   Components(4)=PathRenderer
   bStatic=False
   bNoDelete=False
   bCollideWhenPlacing=False
   CollisionComponent=CollisionCylinder
   Name="Default__UTHoldSpot"
   ObjectArchetype=UTDefensePoint'UTGame.Default__UTDefensePoint'
}
