/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
//=============================================================================
// CascadeOptions
//
// A configuration class that holds information for the setup of Cascade.
// Supplied so that the editor 'remembers' the last setup the user had.
//=============================================================================
class CascadeOptions extends Object	
	hidecategories(Object)
	config(Editor)
	native;	

var(Options)		config bool			bShowModuleDump;
var(Options)		config color		BackgroundColor;
var(Options)		config bool			bUseSubMenus;
var(Options)		config bool			bUseSpaceBarReset;
var(Options)		config color		Empty_Background;
var(Options)		config color		Emitter_Background;
var(Options)		config color		Emitter_Unselected;
var(Options)		config color		Emitter_Selected;
var(Options)		config color		ModuleColor_General_Unselected;
var(Options)		config color		ModuleColor_General_Selected;
var(Options)		config color		ModuleColor_TypeData_Unselected;
var(Options)		config color		ModuleColor_TypeData_Selected;
var(Options)		config color		ModuleColor_Beam_Unselected;
var(Options)		config color		ModuleColor_Beam_Selected;
var(Options)		config color		ModuleColor_Trail_Unselected;
var(Options)		config color		ModuleColor_Trail_Selected;

var(Options)		config bool			bShowGrid;
var(Options)		config color		GridColor_Hi;
var(Options)		config color		GridColor_Low;
var(Options)		config float		GridPerspectiveSize;

var(Options)		config bool			bShowParticleCounts;
var(Options)		config bool			bShowParticleTimes;
var(Options)		config bool			bShowParticleDistance;

var(Options)		config bool			bShowFloor;
var(Options)		config string		FloorMesh;
var(Options)		config vector		FloorPosition;
var(Options)		config rotator		FloorRotation;
var(Options)		config float		FloorScale;
var(Options)		config vector		FloorScale3D;

var(Options)		config string		PostProcessChainName;

var(Options)		config int			ShowPPFlags;

defaultproperties
{
   bUseSubMenus=True
   BackgroundColor=(B=25,G=20,R=20,A=0)
   Empty_Background=(B=25,G=20,R=20,A=0)
   Emitter_Background=(B=25,G=20,R=20,A=0)
   Emitter_Unselected=(B=0,G=100,R=255,A=0)
   Emitter_Selected=(B=180,G=180,R=180,A=0)
   ModuleColor_General_Unselected=(B=49,G=40,R=40,A=0)
   ModuleColor_General_Selected=(B=0,G=100,R=255,A=0)
   ModuleColor_TypeData_Unselected=(B=20,G=20,R=15,A=0)
   ModuleColor_TypeData_Selected=(B=0,G=100,R=255,A=0)
   ModuleColor_Beam_Unselected=(B=235,G=150,R=160,A=0)
   ModuleColor_Beam_Selected=(B=0,G=100,R=255,A=0)
   ModuleColor_Trail_Unselected=(B=170,G=235,R=130,A=0)
   ModuleColor_Trail_Selected=(B=0,G=100,R=255,A=0)
   GridColor_Hi=(B=255,G=100,R=0,A=0)
   GridColor_Low=(B=255,G=100,R=0,A=0)
   GridPerspectiveSize=1024.000000
   PostProcessChainName="EditorMaterials.Cascade.DefaultCascadePostProcess"
   Name="Default__CascadeOptions"
   ObjectArchetype=Object'Core.Default__Object'
}
