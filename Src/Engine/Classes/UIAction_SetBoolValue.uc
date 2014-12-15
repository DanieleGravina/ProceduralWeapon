/**
 * This action allows designers to change the value of a widget that contains boolean data.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetBoolValue extends UIAction_SetValue;

var()				bool					bNewValue;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_Bool',LinkDesc="New Value",PropertyName="bNewValue",MinVars=1,MaxVars=255)
   ObjName="Set Bool Value"
   Name="Default__UIAction_SetBoolValue"
   ObjectArchetype=UIAction_SetValue'Engine.Default__UIAction_SetValue'
}
