/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class CoverGroup extends Info
	native
	placeable
	dependson(CoverLink);

/** 
 * Defines a group of cover links they can be acted on as a single unit
 * (ie enable/disable)
 */
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

enum ECoverGroupFillAction
{
	CGFA_Overwrite,
	CGFA_Add,
	CGFA_Remove,
	CGFA_Clear,
	CGFA_Cylinder,
};

/** List of cover links in the group */
var() array<NavReference> CoverLinkRefs;

/** Radius around group actor to select nodes */
var() float	AutoSelectRadius;
/** Z distance below group actor to select nodes */
var() float AutoSelectHeight;

native function EnableGroup();
native function DisableGroup();
native function ToggleGroup();

simulated function OnToggle( SeqAct_Toggle Action )
{
	// On
	if( Action.InputLinks[0].bHasImpulse )
	{
		EnableGroup();
	}
	// Off
	if( Action.InputLinks[1].bHasImpulse )
	{
		DisableGroup();
	}
	// Toggle
	if( Action.InputLinks[2].bHasImpulse )
	{
		ToggleGroup();
	}
}

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Info:Sprite'
      Sprite=Texture2D'EditorMaterials.CovergroupIcon'
      ObjectArchetype=SpriteComponent'Engine.Default__Info:Sprite'
   End Object
   Components(0)=Sprite
   Begin Object Class=CoverGroupRenderingComponent Name=CoverGroupRenderer ObjName=CoverGroupRenderer Archetype=CoverGroupRenderingComponent'Engine.Default__CoverGroupRenderingComponent'
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="CoverGroupRenderer"
      ObjectArchetype=CoverGroupRenderingComponent'Engine.Default__CoverGroupRenderingComponent'
   End Object
   Components(1)=CoverGroupRenderer
   bStatic=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__CoverGroup"
   ObjectArchetype=Info'Engine.Default__Info'
}
