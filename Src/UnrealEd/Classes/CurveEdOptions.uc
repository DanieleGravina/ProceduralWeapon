/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================================================================
// CurveEdOptions
//
// A configuration class that holds information for the setup of the CurveEd.
// Supplied so that the editor 'remembers' the last setup the user had.
//=============================================================================
class CurveEdOptions extends Object	
	hidecategories(Object)
	config(Editor)
	native;	

var(Options)		config float		MinViewRange;
var(Options)		config float		MaxViewRange;
var(Options)		config linearcolor	BackgroundColor;
var(Options)		config linearcolor	LabelColor;
var(Options)		config linearcolor	SelectedLabelColor;
var(Options)		config linearcolor	GridColor;
var(Options)		config linearcolor	GridTextColor;
var(Options)		config linearcolor	LabelBlockBkgColor;
var(Options)		config linearcolor	SelectedKeyColor;

defaultproperties
{
   MinViewRange=0.001000
   MaxViewRange=1000000.000000
   BackgroundColor=(R=0.235294,G=0.235294,B=0.235294,A=1.000000)
   LabelColor=(R=0.705882,G=0.705882,B=0.705882,A=1.000000)
   SelectedLabelColor=(R=1.000000,G=0.509804,B=0.117647,A=1.000000)
   GridColor=(R=0.490196,G=0.490196,B=0.490196,A=1.000000)
   GridTextColor=(R=0.784314,G=0.784314,B=0.784314,A=1.000000)
   LabelBlockBkgColor=(R=0.509804,G=0.509804,B=0.509804,A=1.000000)
   SelectedKeyColor=(R=1.000000,G=1.000000,B=0.000000,A=1.000000)
   Name="Default__CurveEdOptions"
   ObjectArchetype=Object'Core.Default__Object'
}
