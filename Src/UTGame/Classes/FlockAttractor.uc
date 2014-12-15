/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class FlockAttractor extends Actor
	placeable
	native
	hidecategories(Advanced)
	hidecategories(Collision)
	hidecategories(Display)
	hidecategories(Actor);

var()	interp float	Attraction;
var()	bool			bAttractorEnabled;
var()	bool			bAttractionFalloff;
var()	bool			bActionAtThisAttractor;

var		CylinderComponent	CylinderComponent;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

simulated function OnToggle(SeqAct_Toggle action)
{
	if (action.InputLinks[0].bHasImpulse)
	{
		// turn on
		bAttractorEnabled = TRUE;
	}
	else if (action.InputLinks[1].bHasImpulse)
	{
		// turn off
		bAttractorEnabled = FALSE;
	}
	else if (action.InputLinks[2].bHasImpulse)
	{
		// toggle
		bAttractorEnabled = !bAttractorEnabled;
	}
}

defaultproperties
{
   Attraction=1.000000
   bAttractorEnabled=True
   bAttractionFalloff=True
   Begin Object Class=CylinderComponent Name=CollisionCylinder ObjName=CollisionCylinder Archetype=CylinderComponent'Engine.Default__CylinderComponent'
      CollisionHeight=40.000000
      CollisionRadius=200.000000
      CollideActors=True
      Name="CollisionCylinder"
      ObjectArchetype=CylinderComponent'Engine.Default__CylinderComponent'
   End Object
   CylinderComponent=CollisionCylinder
   Components(0)=CollisionCylinder
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__SpriteComponent'
      Sprite=Texture2D'EnvyEditorResources.RedDefense'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="Sprite"
      ObjectArchetype=SpriteComponent'Engine.Default__SpriteComponent'
   End Object
   Components(1)=Sprite
   bCollideActors=True
   CollisionComponent=CollisionCylinder
   CollisionType=COLLIDE_CustomDefault
   Name="Default__FlockAttractor"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
