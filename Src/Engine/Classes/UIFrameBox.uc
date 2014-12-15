/**
 * More configurable image widget that allows the user to specify 9 image components to have 
 * a background box that scales properly while maintaining the aspect ratio of its corners.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIFrameBox extends UIContainer
	placeable
	native(UIPrivate);

/** Enum describing all of the image components used in this widget. */
enum EFrameBoxImage
{
	FBI_TopLeft,
	FBI_Top,
	FBI_TopRight,
	FBI_CenterLeft,
	FBI_Center,
	FBI_CenterRight,
	FBI_BottomLeft,
	FBI_Bottom,
	FBI_BottomRight
};

/** Sizes of the corners.  The corner image components will always render at these sizes. */
struct native CornerSizes
{
	var() float TopLeft[2];
	var() float TopRight[2];
	var() float BottomLeft[2];
	var() float BottomRight[2];
	var() float TopHeight;
	var() float BottomHeight;
	var() float CenterLeftWidth;
	var() float CenterRightWidth;
};


/** Component for rendering the background images */
var(Image)	editinline	const	noclear	UIComp_DrawImage		BackgroundImageComponent[9];
var(Image)  editinline  CornerSizes								BackgroundCornerSizes;

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

/* === Unrealscript === */
/**
 * Changes the background image for this panel, creating the wrapper UITexture if necessary.
 *
 * @param	NewImage		the new surface to use for this UIImage
 */
final function SetBackgroundImage( EFrameBoxImage ImageToSet, Surface NewImage )
{
	if ( BackgroundImageComponent[ImageToSet] != None )
	{
		BackgroundImageComponent[ImageToSet].SetImage(NewImage);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=TemplateTopLeft ObjName=TemplateTopLeft Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Top Left Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateTopLeft"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(0)=TemplateTopLeft
   Begin Object Class=UIComp_DrawImage Name=TemplateTop ObjName=TemplateTop Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Top Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateTop"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(1)=TemplateTop
   Begin Object Class=UIComp_DrawImage Name=TemplateTopRight ObjName=TemplateTopRight Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Top Right Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateTopRight"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(2)=TemplateTopRight
   Begin Object Class=UIComp_DrawImage Name=TemplateCenterLeft ObjName=TemplateCenterLeft Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Center Left Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateCenterLeft"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(3)=TemplateCenterLeft
   Begin Object Class=UIComp_DrawImage Name=TemplateCenter ObjName=TemplateCenter Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Center Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateCenter"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(4)=TemplateCenter
   Begin Object Class=UIComp_DrawImage Name=TemplateCenterRight ObjName=TemplateCenterRight Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Center Right Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateCenterRight"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(5)=TemplateCenterRight
   Begin Object Class=UIComp_DrawImage Name=TemplateBottomLeft ObjName=TemplateBottomLeft Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Bottom Left Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateBottomLeft"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(6)=TemplateBottomLeft
   Begin Object Class=UIComp_DrawImage Name=TemplateBottom ObjName=TemplateBottom Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Bottom Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateBottom"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(7)=TemplateBottom
   Begin Object Class=UIComp_DrawImage Name=TemplateBottomRight ObjName=TemplateBottomRight Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Bottom Right Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="TemplateBottomRight"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent(8)=TemplateBottomRight
   BackgroundCornerSizes=(TopLeft[0]=16.000000,TopLeft[1]=16.000000,TopRight[0]=16.000000,TopRight[1]=16.000000,BottomLeft[0]=16.000000,BottomLeft[1]=16.000000,BottomRight[0]=16.000000,BottomRight[1]=16.000000,TopHeight=16.000000,BottomHeight=16.000000,CenterLeftWidth=16.000000,CenterRightWidth=16.000000)
   PrimaryStyle=(DefaultStyleTag="PanelBackground",RequiredStyleClass=Class'Engine.UIStyle_Image')
   bSupportsPrimaryStyle=False
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIContainer:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIContainer:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIFrameBox"
   ObjectArchetype=UIContainer'Engine.Default__UIContainer'
}
