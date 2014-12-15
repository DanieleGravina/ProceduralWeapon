/**
 * This event is activated when the value of a UIComboBox is changed.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIEvent_NumericOptionListValueChanged extends UIEvent_ValueChanged
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
	return TargetObject == None || UINumericOptionList(TargetObject) != None || TargetObject.ContainsChildOfClass(class'UINumericOptionList');
}

defaultproperties
{
   VariableLinks(3)=(ExpectedType=Class'Engine.SeqVar_String',LinkDesc="Text Value",MinVars=1,MaxVars=255)
   VariableLinks(4)=(ExpectedType=Class'Engine.SeqVar_Float',LinkDesc="Numeric Value",MinVars=1,MaxVars=255)
   ObjName="NumericOptionList Value Changed"
   Name="Default__UIEvent_NumericOptionListValueChanged"
   ObjectArchetype=UIEvent_ValueChanged'Engine.Default__UIEvent_ValueChanged'
}
