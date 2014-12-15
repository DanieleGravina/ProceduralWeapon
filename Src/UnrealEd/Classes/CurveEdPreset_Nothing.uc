/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class CurveEdPreset_Nothing extends CurveEdPresetBase
	native
	editinlinenew
	hidecategories(Object);

/** Virtual function to get the user-readable name for the curve	*/
function string GetDisplayName()
{
	local string RetVal;
	
	RetVal = "Do not preset";
	
	return RetVal;
}

/** */
// (cpptext)
// (cpptext)
// (cpptext)

/** */

defaultproperties
{
   Name="Default__CurveEdPreset_Nothing"
   ObjectArchetype=CurveEdPresetBase'UnrealEd.Default__CurveEdPresetBase'
}
