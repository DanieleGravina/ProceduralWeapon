/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Extended version of the slider for UT3.
 */
class UTUISlider extends UISlider
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

/** Updates the slider's caption render component. */
native virtual function UpdateCaption();

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=SliderBackgroundImageTemplate ObjName=SliderBackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UISlider:SliderBackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UISlider:SliderBackgroundImageTemplate'
   End Object
   BackgroundImageComponent=SliderBackgroundImageTemplate
   Begin Object Class=UIComp_DrawImage Name=SliderBarImageTemplate ObjName=SliderBarImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UISlider:SliderBarImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UISlider:SliderBarImageTemplate'
   End Object
   SliderBarImageComponent=SliderBarImageTemplate
   Begin Object Class=UIComp_DrawImage Name=SliderMarkerImageTemplate ObjName=SliderMarkerImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UISlider:SliderMarkerImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UISlider:SliderMarkerImageTemplate'
   End Object
   MarkerImageComponent=SliderMarkerImageTemplate
   Begin Object Class=UIComp_DrawStringSlider Name=CaptionStringRenderer ObjName=CaptionStringRenderer Archetype=UIComp_DrawStringSlider'Engine.Default__UIComp_DrawStringSlider'
      StyleResolverTag="UTSliderText"
      StringStyle=(DefaultStyleTag="UTButtonBarButtonCaption")
      Name="CaptionStringRenderer"
      ObjectArchetype=UIComp_DrawStringSlider'Engine.Default__UIComp_DrawStringSlider'
   End Object
   CaptionRenderComponent=CaptionStringRenderer
   BarSize=(Value=16.000000)
   MarkerHeight=(Value=32.000000)
   MarkerWidth=(Value=32.000000)
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UISlider:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UISlider:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUISlider"
   ObjectArchetype=UISlider'Engine.Default__UISlider'
}
