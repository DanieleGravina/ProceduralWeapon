/**
 * This action retrieves the current value of the progressbar which is the target of this action.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_GetProgressBarValue extends UIAction_GetValue;

/** Value that will be set by the UIProgressBar handler */
var		float	 Value;

/** Specifies whether the output value will be returned as a percentage of total progressbar range */ 
var()   bool	bPercentageValue;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Value",PropertyName="Value",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get ProgressBar Value"
   Name="Default__UIAction_GetProgressBarValue"
   ObjectArchetype=UIAction_GetValue'Engine.Default__UIAction_GetValue'
}
