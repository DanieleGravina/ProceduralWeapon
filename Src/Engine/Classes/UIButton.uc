#linenumber 1

/**
 * Base class for all widget types which act as buttons.  Buttons trigger events when
 * they are clicked on or activated using the keyboard.
 * This basic button contains only a background image.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIButton extends UIObject
	native(UIPrivate);
























































































































 



#linenumber 13

/** Component for rendering the button background image */
var(Image)	editinline	const	noclear	UIComp_DrawImage		BackgroundImageComponent;

/** this sound is played when this widget is clicked */
var(Sound)				name						ClickedCue;

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

/* === Unrealscript === */
/**
 * Changes the background image for this button, creating the wrapper UITexture if necessary.
 *
 * @param	NewImage		the new surface to use for this UIImage
 */
final function SetImage( Surface NewImage )
{
	if ( BackgroundImageComponent != None )
	{
		BackgroundImageComponent.SetImage(NewImage);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Background Image Style"
      ImageStyle=(DefaultStyleTag="ButtonBackground")
      Name="BackgroundImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   ClickedCue="Clicked"
   PrimaryStyle=(DefaultStyleTag="ButtonBackground",RequiredStyleClass=Class'Engine.UIStyle_Image')
   bSupportsPrimaryStyle=False
   DefaultStates(2)=Class'Engine.UIState_Focused'
   DefaultStates(3)=Class'Engine.UIState_Active'
   DefaultStates(4)=Class'Engine.UIState_Pressed'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
      DefaultEvents(1)=(EventTemplate=UIEvent_OnClick'Engine.Default__UIButton:ButtonClickHandler',EventState=Class'Engine.UIState_Focused')
      ObjectArchetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIButton"
   ObjectArchetype=UIObject'Engine.Default__UIObject'
}
