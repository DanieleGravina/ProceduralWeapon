/**
* A special button used by the UIOptionListBase class for incrementing or decrementing the current position of the list's label
*
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
*/
class UIOptionListButton extends UIButton
	within UIOptionListBase
	native(inherit)
	notplaceable;

/**
 * Determines which states this button should be in based on the state of the owner UIOptionListBase and synchronizes to those states.
 *
 * @param	PlayerIndex		the index of the player that generated the update; if not specified, states will be activated for all
 *							players that are eligible to generate input for this button.
 */
native final function UpdateButtonState( optional int PlayerIndex=INDEX_NONE );

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   PrivateFlags=111
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIOptionListButton"
   ObjectArchetype=UIButton'Engine.Default__UIButton'
}
