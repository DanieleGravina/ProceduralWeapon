/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================================================================
// TerrainEditOptions
//
// A configuration class that holds information for the setup of TerrainEditing.
// Supplied so that the editor 'remembers' the last setup the user had.
//=============================================================================
class TerrainEditOptions extends Object	
	hidecategories(Object)
	config(Editor)
	native;	

// TerrainEdit
var(Options)		config int			Solid1_Strength;
var(Options)		config int			Solid1_Radius;
var(Options)		config int			Solid1_Falloff;
var(Options)		config int			Solid2_Strength;
var(Options)		config int			Solid2_Radius;
var(Options)		config int			Solid2_Falloff;
var(Options)		config int			Solid3_Strength;
var(Options)		config int			Solid3_Radius;
var(Options)		config int			Solid3_Falloff;
var(Options)		config int			Solid4_Strength;
var(Options)		config int			Solid4_Radius;
var(Options)		config int			Solid4_Falloff;
var(Options)		config int			Solid5_Strength;
var(Options)		config int			Solid5_Radius;
var(Options)		config int			Solid5_Falloff;
var(Options)		config int			Noisy1_Strength;
var(Options)		config int			Noisy1_Radius;
var(Options)		config int			Noisy1_Falloff;
var(Options)		config int			Noisy2_Strength;
var(Options)		config int			Noisy2_Radius;
var(Options)		config int			Noisy2_Falloff;
var(Options)		config int			Noisy3_Strength;
var(Options)		config int			Noisy3_Radius;
var(Options)		config int			Noisy3_Falloff;
var(Options)		config int			Noisy4_Strength;
var(Options)		config int			Noisy4_Radius;
var(Options)		config int			Noisy4_Falloff;
var(Options)		config int			Noisy5_Strength;
var(Options)		config int			Noisy5_Radius;
var(Options)		config int			Noisy5_Falloff;

var(Options)		config int			Current_Tool;

var(Options)		config int			Current_Brush;
var(Options)		config int			Current_Strength;
var(Options)		config int			Current_Radius;
var(Options)		config int			Current_Falloff;
var(Options)		config bool			bSoftSelectEnabled;
var(Options)		config bool			bConstrainedEditing;

var(Options)		config int			Current_MirrorFlag;

var(Options)		config int			SliderRange_Low_Strength;
var(Options)		config int			SliderRange_High_Strength;
var(Options)		config int			SliderRange_Low_Radius;
var(Options)		config int			SliderRange_High_Radius;
var(Options)		config int			SliderRange_Low_Falloff;
var(Options)		config int			SliderRange_High_Falloff;

// TerrainLayerBrowser
var(Options)		config bool			bShowFoliageMeshes;
var(Options)		config bool			bShowDecoarationMeshes;
var(Options)		config color		TerrainLayerBrowser_BackgroundColor;
var(Options)		config color		TerrainLayerBrowser_BackgroundColor2;
var(Options)		config color		TerrainLayerBrowser_BackgroundColor3;
var(Options)		config color		TerrainLayerBrowser_SelectedColor;
var(Options)		config color		TerrainLayerBrowser_SelectedColor2;
var(Options)		config color		TerrainLayerBrowser_SelectedColor3;
var(Options)		config color		TerrainLayerBrowser_BorderColor;

defaultproperties
{
   Solid1_Strength=100
   Solid1_Radius=1
   Solid1_Falloff=1
   Solid2_Strength=100
   Solid2_Radius=8
   Solid2_Falloff=8
   Solid3_Strength=100
   Solid3_Radius=32
   Solid3_Falloff=32
   Solid4_Strength=100
   Solid4_Radius=64
   Solid4_Falloff=64
   Solid5_Strength=100
   Solid5_Radius=128
   Solid5_Falloff=128
   Noisy1_Strength=100
   Noisy1_Radius=1
   Noisy1_Falloff=16
   Noisy2_Strength=100
   Noisy2_Radius=8
   Noisy2_Falloff=32
   Noisy3_Strength=100
   Noisy3_Radius=32
   Noisy3_Falloff=64
   Noisy4_Strength=100
   Noisy4_Radius=64
   Noisy4_Falloff=128
   Noisy5_Strength=100
   Noisy5_Radius=128
   Noisy5_Falloff=256
   Current_Tool=2
   Current_Strength=100
   Current_Radius=64
   Current_Falloff=128
   bShowFoliageMeshes=True
   bShowDecoarationMeshes=True
   SliderRange_High_Strength=100
   SliderRange_High_Radius=2048
   SliderRange_High_Falloff=2048
   TerrainLayerBrowser_BackgroundColor=(B=162,G=162,R=162,A=0)
   TerrainLayerBrowser_BackgroundColor2=(B=192,G=192,R=192,A=0)
   TerrainLayerBrowser_BackgroundColor3=(B=212,G=212,R=212,A=0)
   TerrainLayerBrowser_SelectedColor=(B=0,G=162,R=162,A=0)
   TerrainLayerBrowser_SelectedColor2=(B=0,G=192,R=192,A=0)
   TerrainLayerBrowser_SelectedColor3=(B=0,G=212,R=212,A=0)
   TerrainLayerBrowser_BorderColor=(B=64,G=64,R=64,A=0)
   Name="Default__TerrainEditOptions"
   ObjectArchetype=Object'Core.Default__Object'
}
