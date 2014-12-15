//=============================================================================
// LiftCenter.
// Used to support AI navigation on lifts.
// should be placed in the center of the navigable lift surface.
// Used in conjunction with LiftExits
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class LiftCenter extends NavigationPoint
	placeable
	native;

var		InterpActor		MyLift;
var		float			MaxDist2D;
var		vector			LiftOffset;		// starting vector between MyLift location and LiftCenter location
var		bool			bJumpLift;
var		float			CollisionHeight;
/** if specified, must touch this to start the lift */
var() Trigger LiftTrigger;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

event PostBeginPlay()
{
	Super.PostBeginPlay();

	if (Base == MyLift && MyLift != None)
	{
		LiftOffset = Location - MyLift.Location;
		MyLift.bIsLift = true;
	}
}

/** SpecialHandling is called by the navigation code when the next path has been found.
It gives that path an opportunity to modify the result based on any special considerations
Here, we check if the mover needs to be triggered
*/
event Actor SpecialHandling(Pawn Other)
{
	// if no lift, no trigger, or trigger already hit, no special handling
	if (MyLift == None || LiftTrigger == None || LiftTrigger.bRecentlyTriggered)
	{
		return self;
	}
	else
	{
		return LiftTrigger;
	}
}

/*
Check if mover is positioned to allow Pawn to get on
*/
event bool SuggestMovePreparation(Pawn Other)
{
	// if already on lift, no problem
	if ( Other.base == MyLift )
		return false;

	// make sure LiftCenter is correctly positioned on the lift
	if ( (Base != MyLift) || (Location != MyLift.Location + LiftOffset) )
	{
		SetLocation(MyLift.Location + LiftOffset);
		SetBase(MyLift);
	}

	// if mover is moving, wait
	if (!IsZero(MyLift.velocity) || !ProceedWithMove(Other))
	{
		Other.Controller.WaitForMover(MyLift);
		return true;
	}

	return false;
}

function bool ProceedWithMove(Pawn Other)
{
	// see if mover is at appropriate location
	if ( Other.Controller == None )
		return false;
	else if ( (LiftExit(Other.Controller.MoveTarget) != None) && Other.ReachedDestination(self) )
		return LiftExit(Other.Controller.MoveTarget).CanBeReachedFromLiftBy(Other);
	else
	{
		//check distance directly - make sure close
		if ( (Location.Z - CollisionHeight < Other.Location.Z - Other.GetCollisionHeight() + Other.MAXSTEPHEIGHT + 2.0)
			&& (Location.Z - CollisionHeight > Other.Location.Z - Other.GetCollisionHeight() - 1200)
			&& (VSize2D(Location - Other.Location) < MaxDist2D || (IsZero(MyLift.Velocity) && Other.ValidAnchor() && LiftExit(Other.Anchor) != None)) )
		{
			return true;
		}
	}

	// if we need to hit the trigger, go do that
	if (LiftTrigger != None && !LiftTrigger.bRecentlyTriggered && IsZero(MyLift.Velocity))
	{
		Other.SetMoveTarget(LiftTrigger);
		return true;
	}

	return false;
}

defaultproperties
{
   MaxDist2D=400.000000
   CollisionHeight=50.000000
   bNeverUseStrafing=True
   bForceNoStrafing=True
   bSpecialMove=True
   bNoAutoConnect=True
   ExtraCost=400
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      Sprite=Texture2D'EngineResources.lift_center'
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
   bStatic=False
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__LiftCenter"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
