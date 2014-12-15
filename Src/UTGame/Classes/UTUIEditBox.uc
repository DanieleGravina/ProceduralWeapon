/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Extended version of editbox for UT3.
 */
class UTUIEditBox extends UIEditBox
	native(UI);

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

defaultproperties
{
   Begin Object Class=UIComp_DrawStringEditbox Name=EditboxStringRenderer ObjName=EditboxStringRenderer Archetype=UIComp_DrawStringEditbox'Engine.Default__UIEditBox:EditboxStringRenderer'
      ObjectArchetype=UIComp_DrawStringEditbox'Engine.Default__UIEditBox:EditboxStringRenderer'
   End Object
   StringRenderComponent=EditboxStringRenderer
   Begin Object Class=UIComp_DrawImage Name=EditboxBackgroundTemplate ObjName=EditboxBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__UIEditBox:EditboxBackgroundTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIEditBox:EditboxBackgroundTemplate'
   End Object
   BackgroundImageComponent=EditboxBackgroundTemplate
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIEditBox:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIEditBox:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIEditBox"
   ObjectArchetype=UIEditBox'Engine.Default__UIEditBox'
}
