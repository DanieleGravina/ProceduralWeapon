/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class DistributionFloatParameterBase extends DistributionFloatConstant
	abstract
	native
	collapsecategories
	hidecategories(Object)
	editinlinenew;
	
var()	name	ParameterName;
var()	float	MinInput;
var()	float	MaxInput;
var()	float	MinOutput;
var()	float	MaxOutput;

enum DistributionParamMode
{
	DPM_Normal,
	DPM_Abs,
	DPM_Direct
};

var()	DistributionParamMode	ParamMode;

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
   MaxInput=1.000000
   MaxOutput=1.000000
   Name="Default__DistributionFloatParameterBase"
   ObjectArchetype=DistributionFloatConstant'Engine.Default__DistributionFloatConstant'
}
