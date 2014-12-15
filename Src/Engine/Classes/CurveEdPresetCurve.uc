//=============================================================================
// CurveEdPresetCurve
// A preset curve data object
// Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
//=============================================================================
class CurveEdPresetCurve extends object
	native
	hidecategories(Object)
	editinlinenew
	;

/** Preset Generated Point							*/
struct native PresetGeneratedPoint
{
	var		float				KeyIn;
	var		float				KeyOut;
	var		bool				TangentsValid;
	var		float				TangentIn;
	var		float				TangentOut;
	var		EInterpCurveMode	IntepMode;
};

/** Name of the curve								*/
var()	localized string     			CurveName;

/** The points of the curve							*/
var		array<PresetGeneratedPoint>		Points;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   Name="Default__CurveEdPresetCurve"
   ObjectArchetype=Object'Core.Default__Object'
}
