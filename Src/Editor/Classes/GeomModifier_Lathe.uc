/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

/**
 * Lathes selected objects around the widget.
 */
class GeomModifier_Lathe
	extends GeomModifier_Edit
	native;
	
var(Settings) int	TotalSegments;
var(Settings) int	Segments;
var(Settings) EAxis	Axis;

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
   TotalSegments=16
   Segments=4
   Axis=AXIS_Z
   Description="Lathe"
   Name="Default__GeomModifier_Lathe"
   ObjectArchetype=GeomModifier_Edit'Editor.Default__GeomModifier_Edit'
}
