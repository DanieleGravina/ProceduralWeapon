/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================================================================
// LensFlareEditorOptions
//
// A configuration class that holds information for the setup of the LensFlare editor.
// Supplied so that the editor 'remembers' the last setup the user had.
//=============================================================================
class LensFlareEditorOptions extends Object	
	hidecategories(Object)
	config(Editor)
	native;	

var(Options)		config linearcolor	LFED_BackgroundColor;
var(Options)		config linearcolor	LFED_Empty_Background;
var(Options)		config linearcolor	LFED_Source_ElementEd_Background;
var(Options)		config linearcolor	LFED_Source_Unselected;
var(Options)		config linearcolor	LFED_Source_Selected;
var(Options)		config linearcolor	LFED_ElementEd_Background;
var(Options)		config linearcolor	LFED_Element_Unselected;
var(Options)		config linearcolor	LFED_Element_Selected;

var(Options)		config bool			bShowGrid;
var(Options)		config color		GridColor_Hi;
var(Options)		config color		GridColor_Low;
var(Options)		config float		GridPerspectiveSize;

var(Options)		config string		PostProcessChainName;

var(Options)		config int			ShowPPFlags;

defaultproperties
{
   LFED_BackgroundColor=(R=0.078000,G=0.078000,B=0.098000,A=1.000000)
   LFED_Empty_Background=(R=0.000000,G=0.000000,B=0.000000,A=1.000000)
   LFED_Source_ElementEd_Background=(R=0.078000,G=0.078000,B=0.098000,A=1.000000)
   LFED_Source_Unselected=(R=0.784000,G=0.784000,B=0.784000,A=1.000000)
   LFED_Source_Selected=(R=1.000000,G=0.588000,B=0.196000,A=1.000000)
   LFED_ElementEd_Background=(R=0.078000,G=0.078000,B=0.098000,A=1.000000)
   LFED_Element_Unselected=(R=0.506000,G=0.506000,B=0.506000,A=1.000000)
   LFED_Element_Selected=(R=1.000000,G=0.392000,B=0.000000,A=1.000000)
   GridColor_Hi=(B=255,G=100,R=0,A=0)
   GridColor_Low=(B=255,G=100,R=0,A=0)
   GridPerspectiveSize=1024.000000
   Name="Default__LensFlareEditorOptions"
   ObjectArchetype=Object'Core.Default__Object'
}
