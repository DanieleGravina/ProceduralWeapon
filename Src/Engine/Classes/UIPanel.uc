/**
 * Base class for all containers which need a background image.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIPanel extends UIContainer
	placeable
	native(UIPrivate);

/** Component for rendering the background image */
var(Image)	editinline	const	UIComp_DrawImage		BackgroundImageComponent;

/** If ture, this panel will clip anything that attempts to render outside of it's bounds */
var() bool bEnforceClipping;

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

/* === Unrealscript === */
/**
 * Changes the background image for this panel, creating the wrapper UITexture if necessary.
 *
 * @param	NewImage		the new surface to use for this UIImage
 */
final function SetBackgroundImage( Surface NewImage )
{
	if ( BackgroundImageComponent != None )
	{
		BackgroundImageComponent.SetImage(NewImage);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=PanelBackgroundTemplate ObjName=PanelBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Panel Background Style"
      ImageStyle=(DefaultStyleTag="PanelBackground")
      Name="PanelBackgroundTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent=PanelBackgroundTemplate
   PrimaryStyle=(DefaultStyleTag="PanelBackground",RequiredStyleClass=Class'Engine.UIStyle_Image')
   bSupportsPrimaryStyle=False
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIContainer:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIContainer:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIPanel"
   ObjectArchetype=UIContainer'Engine.Default__UIContainer'
}
