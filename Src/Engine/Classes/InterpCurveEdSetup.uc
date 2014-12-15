/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class InterpCurveEdSetup extends Object
	native;

// Information about a particule curve being viewed.
// Property could be an FInterpCurve, a DistributionFloat or a DistributionVector
struct native CurveEdEntry
{
	var	Object	CurveObject;

	var color	CurveColor;
	var string	CurveName;

	var int		bHideCurve;
	var int		bColorCurve;
	var int		bFloatingPointColorCurve;
	var int		bClamp;
	var float	ClampLow;
	var float	ClampHigh;
};

struct native CurveEdTab
{
	var string					TabName;

	var array<CurveEdEntry>		Curves;

	// Remember the view setting for each tab.
	var float					ViewStartInput;
	var float					ViewEndInput;
	var float					ViewStartOutput;
	var float					ViewEndOutput;
};


var array<CurveEdTab>			Tabs;
var int							ActiveTab;

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
   Tabs(0)=(TabName="Default",ViewEndInput=1.000000,ViewStartOutput=-1.000000,ViewEndOutput=1.000000)
   Name="Default__InterpCurveEdSetup"
   ObjectArchetype=Object'Core.Default__Object'
}
