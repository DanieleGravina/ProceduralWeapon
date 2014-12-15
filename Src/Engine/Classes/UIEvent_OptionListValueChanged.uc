/**
 * This event is activated when the value of a UIComboBox is changed.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIEvent_OptionListValueChanged extends UIEvent_ValueChanged
	native(inherit);

/**
 * Determines whether this class should be displayed in the list of available ops in the UI's kismet editor.
 *
 * @param	TargetObject	the widget that this SequenceObject would be attached to.
 *
 * @return	TRUE if this sequence object should be available for use in the UI kismet editor
 */
event bool IsValidUISequenceObject( optional UIScreenObject TargetObject )
{
	return TargetObject == None || UIOptionList(TargetObject) != None || TargetObject.ContainsChildOfClass(class'UIOptionList');
}

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Text Value",MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Current Item",MinVars=1,MaxVars=255)
   VariableLinks(5)=(ExpectedType=Class'Engine.SeqVar_Int',LinkDesc="Current List Index",MinVars=1,MaxVars=255)
   ObjName="OptionList Value Changed"
   Name="Default__UIEvent_OptionListValueChanged"
   ObjectArchetype=UIEvent_ValueChanged'Engine.Default__UIEvent_ValueChanged'
}
