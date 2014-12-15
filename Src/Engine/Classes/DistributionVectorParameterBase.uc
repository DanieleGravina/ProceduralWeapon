/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DistributionVectorParameterBase extends DistributionVectorConstant
	abstract
	native
	collapsecategories
	hidecategories(Object)
	editinlinenew;
	
var()	name	ParameterName;
var()	vector	MinInput;
var()	vector	MaxInput;
var()	vector	MinOutput;
var()	vector	MaxOutput;
var()	DistributionFloatParameterBase.DistributionParamMode ParamModes[3];

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
// (cpptext)

defaultproperties
{
   MaxInput=(X=1.000000,Y=1.000000,Z=1.000000)
   MaxOutput=(X=1.000000,Y=1.000000,Z=1.000000)
   Name="Default__DistributionVectorParameterBase"
   ObjectArchetype=DistributionVectorConstant'Engine.Default__DistributionVectorConstant'
}
