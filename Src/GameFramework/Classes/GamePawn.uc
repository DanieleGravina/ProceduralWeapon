/**
 * GamePawn
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class GamePawn extends Pawn
	config(Game)
	native
	abstract
	notplaceable;




/**
 * Returns cylinder information used for target friction.
 * @todo call the native version of this directly
 **/
simulated function GetTargetFrictionCylinder( out float CylinderRadius, out float CylinderHeight )
{
	GetBoundingCylinder( CylinderRadius, CylinderHeight );	
}

defaultproperties
{
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__Pawn:CollisionCylinder'
      ObjectArchetype=CylinderComponent'Engine.Default__Pawn:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Pawn:Sprite'
      ObjectArchetype=SpriteComponent'Engine.Default__Pawn:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=CollisionCylinder
   Begin Object Class=ArrowComponent Name=Arrow ObjName=Arrow Archetype=ArrowComponent'Engine.Default__Pawn:Arrow'
      ObjectArchetype=ArrowComponent'Engine.Default__Pawn:Arrow'
   End Object
   Components(2)=Arrow
   bCanBeAdheredTo=True
   bCanBeFrictionedTo=True
   CollisionComponent=CollisionCylinder
   Name="Default__GamePawn"
   ObjectArchetype=Pawn'Engine.Default__Pawn'
}
