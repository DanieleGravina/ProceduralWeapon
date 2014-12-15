//=============================================================================
// Player start location.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class PlayerStart extends NavigationPoint
	placeable
	native
	hidecategories(Collision);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

var() bool bEnabled;
var() bool bPrimaryStart;		// None primary starts used only if no primary start available

/* epic ===============================================
* ::OnToggle
*
* Scripted support for toggling a playerstart, checks which
* operation to perform by looking at the action input.
*
* Input 1: turn on
* Input 2: turn off
* Input 3: toggle
*
* =====================================================
*/
simulated function OnToggle(SeqAct_Toggle action)
{
	if (action.InputLinks[0].bHasImpulse)
	{
		// turn on
		bEnabled = true;
	}
	else
	if (action.InputLinks[1].bHasImpulse)
	{
		// turn off
		bEnabled = false;
	}
	else
	if (action.InputLinks[2].bHasImpulse)
	{
		// toggle
		bEnabled = !bEnabled;
	}
}

defaultproperties
{
   bEnabled=True
   bPrimaryStart=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
      CollisionHeight=80.000000
      CollisionRadius=40.000000
      ObjectArchetype=CylinderComponent'Engine.Default__NavigationPoint:CollisionCylinder'
   End Object
   CylinderComponent=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__NavigationPoint:Sprite'
      Sprite=Texture2D'EngineResources.S_Player'
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
   Name="Default__PlayerStart"
   ObjectArchetype=NavigationPoint'Engine.Default__NavigationPoint'
}
