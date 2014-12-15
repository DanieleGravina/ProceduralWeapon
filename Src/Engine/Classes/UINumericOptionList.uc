/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Widget which looks like a UIOptionList but contains a numeric range for its data instead of a list of strings
 */
class UINumericOptionList extends UIOptionListBase
	native(UIPrivate)
	placeable;

/**
 * The value and range parameters for this numeric optionlist.
 */
var(Data)	UIRangeData		RangeValue;

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
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/* === Natives === */
/**
 * Change the value of this slider at runtime.
 *
 * @param	NewValue			the new value for the slider.
 * @param	bPercentageValue	TRUE indicates that the new value is formatted as a percentage of the total range of this slider.
 *
 * @return	TRUE if the slider's value was changed
 */
native final function bool SetValue( coerce float NewValue, optional bool bPercentageValue );

/**
 * Gets the current value of this slider
 *
 * @param	bPercentageValue	TRUE to format the result as a percentage of the total range of this slider.
 */
native final function float GetValue( optional bool bPercentageValue ) const;

defaultproperties
{
   RangeValue=(NudgeValue=1.000000)
   DecrementButton=UIOptionListButton'Engine.Default__UINumericOptionList:DecrementButtonTemplate'
   IncrementButton=UIOptionListButton'Engine.Default__UINumericOptionList:IncrementButtonTemplate'
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIOptionListBase:BackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIOptionListBase:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   Begin Object Class=UIComp_DrawString Name=LabelStringRenderer ObjName=LabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UIOptionListBase:LabelStringRenderer'
      ObjectArchetype=UIComp_DrawString'Engine.Default__UIOptionListBase:LabelStringRenderer'
   End Object
   StringRenderComponent=LabelStringRenderer
   DataSource=(RequiredFieldType=DATATYPE_RangeProperty)
   Children(0)=UIOptionListButton'Engine.Default__UINumericOptionList:DecrementButtonTemplate'
   Children(1)=UIOptionListButton'Engine.Default__UINumericOptionList:IncrementButtonTemplate'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIOptionListBase:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIOptionListBase:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UINumericOptionList"
   ObjectArchetype=UIOptionListBase'Engine.Default__UIOptionListBase'
}
