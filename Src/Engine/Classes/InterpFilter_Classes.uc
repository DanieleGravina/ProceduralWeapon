/** 
 * InterpFilter_Classes.uc: Filter class for filtering matinee groups.  
 * Used by the matinee editor to filter groups to specific classes of attached actors.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */

class InterpFilter_Classes extends InterpFilter
	native(Interpolation);

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

/** Which class to filter groups by. */
var editoronly class<Object>	ClassToFilterBy;

defaultproperties
{
   Name="Default__InterpFilter_Classes"
   ObjectArchetype=InterpFilter'Engine.Default__InterpFilter'
}
