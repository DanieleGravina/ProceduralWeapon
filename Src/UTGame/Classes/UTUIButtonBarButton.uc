/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Modified version of label button that doesn't accept focus on console.
 */
class UTUIButtonBarButton extends UILabelButton
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

/** === Focus Handling === */
/**
 * Determines whether this widget can become the focused control.
 *
 * @param	PlayerIndex		the index [into the Engine.GamePlayers array] for the player to check focus availability
 *
 * @return	TRUE if this widget (or any of its children) is capable of becoming the focused control.
 */
native function bool CanAcceptFocus( optional int PlayerIndex=0 ) const;

defaultproperties
{
   Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
      StyleResolverTag="Caption Style"
      AutoSizeParameters(0)=(bAutoSizeEnabled=True)
      StringStyle=(DefaultStyleTag="UTButtonBarButtonCaption")
      Name="ButtonBarStringRenderer"
      ObjectArchetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
   End Object
   StringRenderComponent=ButtonBarStringRenderer
   Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Background Image Style"
      ImageStyle=(DefaultStyleTag="UTButtonBarButtonBG")
      Name="ButtonBarBackgroundImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent=ButtonBarBackgroundImageTemplate
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UILabelButton:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UILabelButton:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIButtonBarButton"
   ObjectArchetype=UILabelButton'Engine.Default__UILabelButton'
}
