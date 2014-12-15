/**
 * Changes the value of a label's text
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIAction_SetLabelText extends UIAction_SetValue;

var() string	NewText;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="New Value",PropertyName="NewText",MinVars=1,MaxVars=255)
   ObjName="Set Text Value"
   Name="Default__UIAction_SetLabelText"
   ObjectArchetype=UIAction_SetValue'Engine.Default__UIAction_SetValue'
}
