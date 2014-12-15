/**
 * This button is identical to UIButton, with the exception that pressing this button toggles its pressed state, rather
 * than only remaining in the pressed state while the mouse/key is depressed.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIToggleButton extends UILabelButton
	native(inherit);

/** the data store that this togglebutton retrieves its checked/unchecked value from */
var(Data)	private					UIDataStoreBinding		ValueDataSource;

/**
 * Controls whether this button is considered checked.  When bIsChecked is TRUE, CheckedImage will be rendered over
 * the button background image, using the current style.
 */
var(Value)	private					bool					bIsChecked;

/** Renders the caption for this button when it is checked */
var(Data)	editinline	const noclear	UIComp_DrawString		CheckedStringRenderComponent;

/** Component for rendering the button background image when checked */
var(Image)	editinline	const	noclear	UIComp_DrawImage		CheckedBackgroundImageComponent;

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
 * Sets the caption for this button.
 *
 * @param	NewText			the new caption for the button
 */
native function SetCaption( string NewText );

/* === Unrealscript === */
/**
 * Returns TRUE if this button is in the checked state, FALSE if in the
 */
final function bool IsChecked()
{
	return bIsChecked;
}

/**
 * Changed the checked state of this checkbox and activates a checked event.
 *
 * @param	bShouldBeChecked	TRUE to turn the checkbox on, FALSE to turn it off
 * @param	PlayerIndex			the index of the player that generated the call to SetValue; used as the PlayerIndex when activating
 *								UIEvents; if not specified, the value of GetBestPlayerIndex() is used instead.
 */
native final function SetValue( bool bShouldBeChecked, optional int PlayerIndex=INDEX_NONE );

/**
 * Default handler for the toggle button's OnClick
 */
function bool ButtonClicked( UIScreenObject Sender, int PlayerIndex )
{
	SetValue( !IsChecked() );
	return false;
}

/* === Kismet action handlers === */
final function OnSetBoolValue( UIAction_SetBoolValue Action )
{
	SetValue(Action.bNewValue);
}

defaultproperties
{
   ValueDataSource=
   Begin Object Class=UIComp_DrawString Name=CheckedLabelStringRenderer ObjName=CheckedLabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
      StyleResolverTag="Caption Style (Checked)"
      StringStyle=(DefaultStyleTag="DefaultToggleButtonStyle")
      Name="CheckedLabelStringRenderer"
      ObjectArchetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
   End Object
   CheckedStringRenderComponent=CheckedLabelStringRenderer
   Begin Object Class=UIComp_DrawImage Name=CheckedBackgroundImageTemplate ObjName=CheckedBackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Background Image Style (Checked)"
      ImageStyle=(DefaultStyleTag="DefaultToggleButtonBackgroundStyle")
      Name="CheckedBackgroundImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   CheckedBackgroundImageComponent=CheckedBackgroundImageTemplate
   Begin Object Class=UIComp_DrawString Name=LabelStringRenderer ObjName=LabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UILabelButton:LabelStringRenderer'
      ObjectArchetype=UIComp_DrawString'Engine.Default__UILabelButton:LabelStringRenderer'
   End Object
   StringRenderComponent=LabelStringRenderer
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UILabelButton:BackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UILabelButton:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   __OnClicked__Delegate=Default__UIToggleButton.ButtonClicked
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UILabelButton:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UILabelButton:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIToggleButton"
   ObjectArchetype=UILabelButton'Engine.Default__UILabelButton'
}
