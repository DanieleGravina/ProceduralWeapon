//=============================================================================
// Scout used for path generation.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class Scout extends Pawn
	native
	config(Game)
	notplaceable
	transient
	dependsOn(ReachSpec);

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

struct native PathSizeInfo
{
	var Name		Desc;
	var	float		Radius,
					Height,
					CrouchHeight;
	var byte		PathColor;
};
var array<PathSizeInfo>			PathSizes;		// dimensions of reach specs to test for
var float						TestJumpZ,
								TestGroundSpeed,
								TestMaxFallSpeed,
								TestFallSpeed;

var const float MaxLandingVelocity;

var int MinNumPlayerStarts;

/** Specifies the default class to use when constructing reachspecs connecting NavigationPoints */
var class<ReachSpec> DefaultReachSpecClass;

simulated event PreBeginPlay()
{
	// make sure this scout has all collision disabled
	if (bCollideActors)
	{
		SetCollision(FALSE,FALSE);
	}
}

defaultproperties
{
   PathSizes(0)=(Desc="Human",Radius=48.000000,Height=80.000000)
   PathSizes(1)=(Desc="Common",Radius=72.000000,Height=100.000000)
   PathSizes(2)=(Desc="Max",Radius=120.000000,Height=120.000000)
   PathSizes(3)=(Desc="Vehicle",Radius=260.000000,Height=120.000000)
   TestJumpZ=420.000000
   TestGroundSpeed=600.000000
   TestMaxFallSpeed=2500.000000
   TestFallSpeed=1200.000000
   MinNumPlayerStarts=1
   DefaultReachSpecClass=Class'Engine.ReachSpec'
   AccelRate=1.000000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Pawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__Pawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   RemoteRole=ROLE_None
   bCollideActors=False
   bCollideWorld=False
   bBlockActors=False
   bProjTarget=False
   bPathColliding=True
   CollisionComponent=CollisionCylinder
   Name="Default__Scout"
   ObjectArchetype=Pawn'Engine.Default__Pawn'
}
