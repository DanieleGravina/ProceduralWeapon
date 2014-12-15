/**
 * Changes the current value of a UIProgressBar
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetProgressBarValue extends UIAction_SetValue;

/** Specifies new progressbar value */
var()	float	NewValue;

/** Specifies whether the NewValue should be treated as a precentage */
var()   bool	bPercentageValue;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="New Value",PropertyName="NewValue",MinVars=1,MaxVars=255)
   ObjName="Set ProgressBar Value"
   Name="Default__UIAction_SetProgressBarValue"
   ObjectArchetype=UIAction_SetValue'Engine.Default__UIAction_SetValue'
}
