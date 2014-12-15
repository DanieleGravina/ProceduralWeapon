/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class LightFunction extends Object
	native
	hidecategories(Object)
	collapsecategories
	editinlinenew;

var() const MaterialInterface	SourceMaterial;
var() vector					Scale;

defaultproperties
{
   Scale=(X=1024.000000,Y=1024.000000,Z=1024.000000)
   Name="Default__LightFunction"
   ObjectArchetype=Object'Core.Default__Object'
}
