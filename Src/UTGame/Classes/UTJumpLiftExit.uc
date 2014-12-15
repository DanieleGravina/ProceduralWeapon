/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTJumpLiftExit extends LiftExit;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( (MyLiftCenter != None) && (WorldInfo.Game.GameDifficulty < 4) )
	{
		ExtraCost = 10000000;
		bBlocked = true;
	}
}

function WaitForLift(Pawn Other)
{
	Super.WaitForLift(Other);
	if (MyLiftCenter != None && MyLiftCenter.MyLift != None)
	{
		MyLiftCenter.MyLift.bMonitorZVelocity = true;
	}
}


function bool CanBeReachedFromLiftBy(Pawn Other)
{
	local float RealJumpZ;
	local vector NewVelocity;

	if (Other.Base == MyLiftCenter.MyLift && MyLiftCenter.MyLift.MaxZVelocity > 0.f)
	{
		RealJumpZ = Other.JumpZ;
		Other.JumpZ += MyLiftCenter.MyLift.MaxZVelocity;
		if (!Other.SuggestJumpVelocity(NewVelocity, Location + vect(0,0,1) * Other.GetCollisionHeight(), Other.Location))
		{
			Other.JumpZ = RealJumpZ;
			return false;
		}
		Other.Velocity = NewVelocity;
		Other.bWantsToCrouch = false;
		Other.Controller.MoveTarget = self;
		Other.Controller.Destination = Location;
		Other.Acceleration = vect(0,0,0);
		if ( UTPawn(Other) != None )
		{
			UTPawn(Other).bNoJumpAdjust = true;
			UTPawn(Other).bReadyToDoubleJump = true;
		}
		Other.SetPhysics(PHYS_Falling);
		UTBot(Other.Controller).SetFall();
		if ( UTPawn(Other).bRequiresDoubleJump )
		{
			UTBot(Other.Controller).bNotifyApex = true;
			UTBot(Other.Controller).bPendingDoubleJump = true;
		}
		Other.DestinationOffset = 50;
		Other.JumpZ = RealJumpZ;
		return true;
	}
	return false;
}

defaultproperties
{
   bExitOnly=True
   ExtraCost=500
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__LiftExit:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__LiftExit:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__LiftExit:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__LiftExit:Sprite'
   End Object
   GoodSprite=Sprite
   Begin Object Class=SpriteComponent Name=Sprite2 ObjName=Sprite2 Archetype=SpriteComponent'Engine.Default__LiftExit:Sprite2'
      ObjectArchetype=SpriteComponent'Engine.Default__LiftExit:Sprite2'
   End Object
   BadSprite=Sprite2
   Components(0)=Sprite
   Components(1)=Sprite2
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__LiftExit:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__LiftExit:Arrow'
   End Object
   Components(2)=Arrow
   Components(3)=CollisionCylinder
   Begin Object Class=PathRenderingComponent Name=PathRenderer ObjName=PathRenderer Archetype=PathRenderingComponent'Engine.Default__LiftExit:PathRenderer'
      ObjectArchetype=PathRenderingComponent'Engine.Default__LiftExit:PathRenderer'
   End Object
   Components(4)=PathRenderer
   CollisionComponent=CollisionCylinder
   Name="Default__UTJumpLiftExit"
   ObjectArchetype=LiftExit'Engine.Default__LiftExit'
}
