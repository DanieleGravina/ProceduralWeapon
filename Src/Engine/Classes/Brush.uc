//=============================================================================
// The brush class.
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class Brush extends Actor
	hidecategories(Object)
	hidecategories(Movement)
	hidecategories(Display)
	native;

//-----------------------------------------------------------------------------
// Variables.

// CSG operation performed in editor.
var() enum ECsgOper
{
	CSG_Active,			// Active brush.
	CSG_Add,			// Add to world.
	CSG_Subtract,		// Subtract from world.
	CSG_Intersect,		// Form from intersection with world.
	CSG_Deintersect,	// Form from negative intersection with world.
} CsgOper;

// Information.
var() color BrushColor;
var	  int	PolyFlags;
var() bool  bColored;
var bool	bSolidWhenSelected;

var export const Model	Brush;
var editconst const BrushComponent BrushComponent;

// Selection information for geometry mode

struct native export GeomSelection
{
	var int		Type;			// EGeometrySelectionType_
	var int		Index;			// Index into the geometry data structures
	var int		SelectionIndex;	// The selection index of this item
	var float	SelStrength;	// The strength of the selection (used for soft selection)
};

/**
 * Stores selection information from geometry mode.  This is the only information that we can't
 * regenerate by looking at the source brushes following an undo operation.
 */
 
var array<GeomSelection>	SavedSelections;

//-----------------------------------------------------------------------------
// cpptext.

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

defaultproperties
{
   Begin Object Class=BrushComponent Name=BrushComponent0 ObjName=BrushComponent0 Archetype=BrushComponent'Engine.Default__BrushComponent'
      Name="BrushComponent0"
      ObjectArchetype=BrushComponent'Engine.Default__BrushComponent'
   End Object
   BrushComponent=BrushComponent0
   Components(0)=BrushComponent0
   bStatic=True
   bHidden=True
   bNoDelete=True
   bEdShouldSnap=True
   CollisionComponent=BrushComponent0
   Name="Default__Brush"
   ObjectArchetype=Actor'Engine.Default__Actor'
}
