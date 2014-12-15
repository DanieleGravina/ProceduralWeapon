/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class Route extends Info
	placeable
	native;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

enum ERouteFillAction
{
	RFA_Overwrite,
	RFA_Add,
	RFA_Remove,
	RFA_Clear,
};
enum ERouteDirection
{
	ERD_Forward,
	ERD_Reverse,
};
enum ERouteType
{
	/** Move from beginning to end, then stop */
	ERT_Linear,
	/** Move from beginning to end and then reverse */
	ERT_Loop,
	/** Move from beginning to end, then start at beginning again */
	ERT_Circle,
};
var() ERouteType RouteType;

/** List of move targets in order */
var() array<NavReference> NavList;

defaultproperties
{
   Begin Object Class=SpriteComponent Name=Sprite ObjName=Sprite Archetype=SpriteComponent'Engine.Default__Info:Sprite'
      Sprite=Texture2D'EngineResources.S_Route'
      ObjectArchetype=SpriteComponent'Engine.Default__Info:Sprite'
   End Object
   Components(0)=Sprite
   Components(1)=Sprite
   Begin Object Class=RouteRenderingComponent Name=RouteRenderer ObjName=RouteRenderer Archetype=RouteRenderingComponent'Engine.Default__RouteRenderingComponent'
      HiddenGame=True
      AlwaysLoadOnClient=False
      AlwaysLoadOnServer=False
      Name="RouteRenderer"
      ObjectArchetype=RouteRenderingComponent'Engine.Default__RouteRenderingComponent'
   End Object
   Components(2)=RouteRenderer
   bStatic=True
   CollisionType=COLLIDE_CustomDefault
   Name="Default__Route"
   ObjectArchetype=Info'Engine.Default__Info'
}
