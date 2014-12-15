/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UTScout extends Scout
	native
	transient;

var bool bRequiresDoubleJump;
var float MaxDoubleJumpHeight;

/** Square of maximum distance that can be traversed by one translocator toss */
var float MaxTranslocDistSq;
/** Translocator projectile class to use for throw tests */
var class<UTProjectile> TranslocProjClass;

/* UTScout uses the properties from this class (jump height etc.) to override UTScout default settings */
var class<UTPawn> PrototypePawnClass;

var name SpecialReachSpecsWarningLog;

var name SizePersonFindName;
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

/**
SuggestJumpVelocity()
returns true if succesful jump from start to destination is possible
returns a suggested initial falling velocity in JumpVelocity
Uses GroundSpeed and JumpZ as limits
*/
native function bool SuggestJumpVelocity(out vector JumpVelocity, vector Destination, vector Start);

defaultproperties
{
   MaxDoubleJumpHeight=85.000000
   MaxTranslocDistSq=4000000.000000
   TranslocProjClass=Class'UTGame.UTProj_TransDisc'
   PrototypePawnClass=Class'UTGame.UTPawn'
   SpecialReachSpecsWarningLog="Adding Special Reachspecs"
   SizePersonFindName="Human"
   PathSizes(0)=(Desc="Crouched",Radius=22.000000,Height=29.000000)
   PathSizes(1)=(Desc="Human",Radius=22.000000,Height=44.000000)
   PathSizes(2)=(Desc="Small",Radius=72.000000,Height=44.000000)
   PathSizes(3)=(Desc="Common",Radius=100.000000,Height=44.000000)
   PathSizes(4)=(Desc="Max",Radius=140.000000,Height=100.000000)
   PathSizes(5)=(Desc="Vehicle",Radius=260.000000,Height=100.000000)
   TestJumpZ=322.000000
   TestGroundSpeed=440.000000
   MinNumPlayerStarts=16
   MaxStepHeight=26.000000
   MaxJumpHeight=49.000000
   WalkableFloorZ=0.780000
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Scout:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__Scout:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   CollisionComponent=CollisionCylinder
   Name="Default__UTScout"
   ObjectArchetype=Scout'Engine.Default__Scout'
}
