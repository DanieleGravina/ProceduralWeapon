/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DrawCapsuleComponent extends PrimitiveComponent
	native
	noexport
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var()	color			CapsuleColor;
var()	material		CapsuleMaterial;
var()	float			CapsuleHeight;
var()	float			CapsuleRadius;
var()	bool			bDrawWireCapsule;
var()	bool			bDrawLitCapsule;

defaultproperties
{
   CapsuleColor=(B=0,G=0,R=255,A=255)
   CapsuleHeight=200.000000
   CapsuleRadius=200.000000
   bDrawWireCapsule=True
   HiddenGame=True
   Name="Default__DrawCapsuleComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
