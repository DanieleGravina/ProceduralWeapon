/**
 * This action is used to retrieve the value from widgets that support string data.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIAction_GetTextValue extends UIAction_GetValue;

/** Stores the value from the GetTextValue handler */
var	string	StringValue;

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Text Value",PropertyName="StringValue",bWriteable=True,MinVars=1,MaxVars=255)
   ObjName="Get Text Value"
   Name="Default__UIAction_GetTextValue"
   ObjectArchetype=UIAction_GetValue'Engine.Default__UIAction_GetValue'
}
