/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Modified version of numeric edit box that has some styles replaced.
 */
class UTUINumericEditBox extends UINumericEditBox
	native(UI);

defaultproperties
{
   IncrementStyle=(DefaultStyleTag="SpinnerIncrementButtonBackground")
   DecrementStyle=(DefaultStyleTag="SpinnerDecrementButtonBackground")
   Begin Object Class=UIComp_DrawStringEditbox Name=EditboxStringRenderer ObjName=EditboxStringRenderer Archetype=UIComp_DrawStringEditbox'Engine.Default__UINumericEditBox:EditboxStringRenderer'
      ObjectArchetype=UIComp_DrawStringEditbox'Engine.Default__UINumericEditBox:EditboxStringRenderer'
   End Object
   StringRenderComponent=EditboxStringRenderer
   Begin Object Class=UIComp_DrawImage Name=UTNumericEditboxBackgroundTemplate ObjName=UTNumericEditboxBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Background Image Style"
      ImageStyle=(DefaultStyleTag="DefaultEditboxImageStyle")
      Name="UTNumericEditboxBackgroundTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent=UTNumericEditboxBackgroundTemplate
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UINumericEditBox:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UINumericEditBox:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUINumericEditBox"
   ObjectArchetype=UINumericEditBox'Engine.Default__UINumericEditBox'
}
