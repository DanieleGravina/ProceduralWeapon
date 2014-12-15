/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DrawSphereComponent extends PrimitiveComponent
	native
	noexport
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var()	color			SphereColor;
var()	material		SphereMaterial;
var()	float			SphereRadius;
var()	int				SphereSides;
var()	bool			bDrawWireSphere;
var()	bool			bDrawLitSphere;

defaultproperties
{
   SphereColor=(B=0,G=0,R=255,A=255)
   SphereRadius=100.000000
   SphereSides=16
   bDrawWireSphere=True
   HiddenGame=True
   Name="Default__DrawSphereComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
