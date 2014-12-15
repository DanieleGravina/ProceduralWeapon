/**
 * A special button used by the UIScrollbar class for incrementing or decrementing the current position of the scrollbar's
 * marker button.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIScrollbarButton extends UIButton
	within UIScrollbar
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
   Name="Default__UIScrollbarButton"
   ObjectArchetype=UIButton'Engine.Default__UIButton'
}
