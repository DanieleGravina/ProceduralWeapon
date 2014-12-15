/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DrawConeComponent extends PrimitiveComponent
	native
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var()	color			ConeColor;
var()	float			ConeRadius;
var()	float			ConeAngle;
var()	int				ConeSides;

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
   ConeColor=(B=255,G=200,R=150,A=255)
   ConeRadius=100.000000
   ConeAngle=44.000000
   ConeSides=16
   HiddenGame=True
   Name="Default__DrawConeComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
