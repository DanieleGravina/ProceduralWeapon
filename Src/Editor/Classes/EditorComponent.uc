/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


class EditorComponent extends PrimitiveComponent
	native
	noexport;

/** These mirror the C++ side properties. I'm making a class here so
    ModelComponent will get the defaultprops from the PrimitiveComponent base class */

	var const bool bDrawGrid;
	var const bool bDrawPivot;
	var const bool bDrawBaseInfo;
	var const bool bDrawWorldBox;
	var const bool bDrawColoredOrigin;
	var const bool bDrawKillZ;

	var const color GridColorHi;
	var const color GridColorLo;
	var const float PerspectiveGridSize;

	var const color PivotColor;
	var const float PivotSize;

	var const color BaseBoxColor;

defaultproperties
{
   bDrawGrid=True
   bDrawPivot=True
   bDrawBaseInfo=True
   bDrawWorldBox=True
   bDrawKillZ=True
   GridColorHi=(B=127,G=0,R=0,A=0)
   GridColorLo=(B=63,G=0,R=0,A=0)
   PerspectiveGridSize=262143.000000
   PivotColor=(B=0,G=0,R=255,A=0)
   PivotSize=0.020000
   BaseBoxColor=(B=0,G=255,R=0,A=0)
   DepthPriorityGroup=SDPG_UnrealEdBackground
   Name="Default__EditorComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
