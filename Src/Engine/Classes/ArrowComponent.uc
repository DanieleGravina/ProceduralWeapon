/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class ArrowComponent extends PrimitiveComponent
	native
	noexport
	collapsecategories
	hidecategories(Object)
	editinlinenew;

var() color					ArrowColor;
var() float					ArrowSize;

defaultproperties
{
   ArrowColor=(B=0,G=0,R=255,A=255)
   ArrowSize=1.000000
   HiddenGame=True
   AlwaysLoadOnClient=False
   AlwaysLoadOnServer=False
   Name="Default__ArrowComponent"
   ObjectArchetype=PrimitiveComponent'Engine.Default__PrimitiveComponent'
}
