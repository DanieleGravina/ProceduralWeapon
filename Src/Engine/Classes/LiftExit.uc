//=============================================================================
// LiftExit.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class LiftExit extends NavigationPoint
	placeable
	native;

var()	LiftCenter				MyLiftCenter;
var()	bool					bExitOnly;			// if true, can only get off lift here.

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

function bool CanBeReachedFromLiftBy(Pawn Other)
{
	return ( (Location.Z < Other.Location.Z + Other.GetCollisionHeight())
			 && Other.LineOfSightTo(self) );
}

function WaitForLift(Pawn Other)
{
	if (MyLiftCenter != None)
	{
		Other.DesiredRotation = rotator(Location - Other.Location);
		Other.Controller.WaitForMover(MyLiftCenter.MyLift);
	}
}

event bool SuggestMovePreparation(Pawn Other)
{
	local Controller C;

	if ( (MyLiftCenter == None) || (Other.Controller == None) )
		return false;
	if ( Other.Physics == PHYS_Flying )
	{
		if ( Other.AirSpeed > 0 )
			Other.Controller.MoveTimer = 2+ VSize(Location - Other.Location)/Other.AirSpeed;
		return false;
	}
	if ( (Other.Base == MyLiftCenter.Base) || Other.ReachedDestination(MyLiftCenter) )
	{
		// if pawn is on the lift, see if it can get off and go to this lift exit
		if ( CanBeReachedFromLiftBy(Other) )
		{
			return false;
		}

		// make pawn wait on the lift
		WaitForLift(Other);
		return true;
	}
	else if (MyLiftCenter != None)
	{
		foreach WorldInfo.AllControllers(class'Controller', C)
		{
			if ( (C.Pawn != None) && (C.PendingMover == MyLiftCenter.MyLift) && WorldInfo.GRI.OnSameTeam(C,Other.Controller) && C.Pawn.ReachedDestination(self) )
			{
				WaitForLift(Other);
				return true;
			}
		}
		Other.Controller.ReadyForLift();
	}
	return false;
}

defaultproperties
{
   bNeverUseStrafing=True
   bForceNoStrafing=True
   bSpecialMove=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      Sprite=Texture2D'EngineResources.lift_exit'
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
   Name="Default__LiftExit"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
