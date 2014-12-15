/**
 * A special button used as the marker in the UIScrollbar class.  It processes input axis events while in the pressed state and
 * sends notifications to the owning scrollbar widget.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIScrollbarMarkerButton extends UIScrollbarButton
	native(inherit)
	notplaceable;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/* == Delegates == */
/**
 * Called when the user presses the button and draggs it with a mouse
 * @param	Sender			the button that is submitting the event
 * @param	PlayerIndex		the index of the player that generated the call to this method; used as the PlayerIndex when activating
 *							UIEvents; if not specified, the value of GetBestPlayerIndex() is used instead.
 */
delegate OnButtonDragged( UIScrollbarMarkerButton Sender, int PlayerIndex );

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIScrollbarButton:BackgroundImageTemplate'
      StyleResolverTag="MarkerStyle"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIScrollbarButton:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIScrollbarButton:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIScrollbarButton:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIScrollbarMarkerButton"
   ObjectArchetype=UIScrollbarButton'Engine.Default__UIScrollbarButton'
}
