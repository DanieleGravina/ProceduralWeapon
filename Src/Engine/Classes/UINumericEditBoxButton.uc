/**
 * This  widget is a simple extension of the UIButton class with minor changes made specificly for its application
 * in the UINumericEditBox class.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 */
class UINumericEditBoxButton extends UIButton
	native(inherit)
	notplaceable;

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   PrivateFlags=47
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UINumericEditBoxButton"
   ObjectArchetype=UIButton'Engine.Default__UIButton'
}
