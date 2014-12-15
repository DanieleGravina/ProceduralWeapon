/**
 * This specialized label is used for rendering tooltips in the UI.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved
 */
class UIToolTip extends UILabel
	native(inherit)
	notplaceable
	HideDropDown;

/*
	@todo
	- override all methods which trigger full scene updates; these won't be necessary for UIToolTips
	- hide the tooltip when the console is being displayed
*/

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** Used to indicate that the position of this tool tip widget should be updated during the next tick */
var	const	transient	bool				bPendingPositionUpdate;

/** used to indicate that this tooltip's position has been updated and needs to be resolved into actual screen values */
var	const	transient	bool				bResolveToolTipPosition;

/**
 * The amount of time this tooltip has been active, in seconds.  Updated from TickToolTip().
 */
var	const	transient	float				SecondsActive;

/** Confguration variables */

/**
 * Indicates whether the tooltip will remain in the location where it was initially shown, or follow the cursor.
 */
var()				bool					bFollowCursor;

/**
 * Determines whether this tooltip will automatically deactivate if input is received by the UI system.
 */
var()				bool					bAutoHideOnInput;

/* == Delegates == */

/** Wrapper for BeginTracking which allows owning widgets to easily override the default behavior for tooltip activation */
delegate UIToolTip ActivateToolTip( UIToolTip Sender )
{
	return BeginTracking();
}

/** Wrapper for EndTracking which allows owning widgets to easily override the default behavior for tooltip de-activation */
delegate bool DeactivateToolTip()
{
	return EndTracking();
}

/**
 * Allows widgets to prevent a tooltip from being displayed; called every tick once the number of seconds since the tooltip
 * was linked to a widget (i.e. when ActivateToolTip was called) is greater than UIInteraction.ToolTipInitialDelaySeconds.
 *
 * @param	Sender		the tooltip that will be shown
 *
 * @return	returning FALSE resets the tooltip's activation timer to 0; returning TRUE causes the tooltip to be made visible immediately.
 */
delegate bool CanShowToolTip( UIToolTip Sender );

/* == Events == */

/* == Natives == */
/**
 * Initializes the timer used to determine when this tooltip should be shown.  Called when the a widet that supports a tooltip
 * becomes the scene client's ActiveControl.
 *
 * @return	returns the tooltip that began tracking, or None if no tooltips were activated.
 */
native final function UIToolTip BeginTracking();

/**
 * Hides the tooltip and resets all internal tracking variables.  Called when a widget that supports tooltips is no longer
 * the scene client's ActiveControl.
 *
 * @return	FALSE if the tooltip wishes to abort the deactivation and continue displaying the tooltip.  The return value
 * 			may be ignored if the UIInteraction needs to force the tooltip to disappear, for example if the scene is being
 *			closed or a context menu is being activated.
 */
native final function bool EndTracking();

/**
 * Repositions this tool-tip to appear below the mouse cursor (or above if too near the bottom of the screen), without
 * triggering a full scene update.
 */
native final function UpdateToolTipPosition();

/* == UnrealScript == */

defaultproperties
{
   bAutoHideOnInput=True
   Begin Object Class=UIComp_DrawString Name=LabelStringRenderer ObjName=LabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UILabel:LabelStringRenderer'
      StyleResolverTag="ToolTip String Style"
      AutoSizeParameters(0)=(Extent=(Value[1]=0.300000,EvalType[1]=UIEXTENTEVAL_PercentScene),bAutoSizeEnabled=True)
      AutoSizeParameters(1)=(bAutoSizeEnabled=True)
      TextStyleCustomization=(ClipMode=CLIP_Normal,bOverrideClipMode=True)
      StringStyle=(DefaultStyleTag="DefaultToolTipStringStyle")
      ObjectArchetype=UIComp_DrawString'Engine.Default__UILabel:LabelStringRenderer'
   End Object
   StringRenderComponent=LabelStringRenderer
   Begin Object Class=UIComp_DrawImage Name=TooltipBackgroundRenderer ObjName=TooltipBackgroundRenderer Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="ToolTip Background Style"
      ImageStyle=(DefaultStyleTag="DefaultToolTipBackgroundStyle")
      Name="TooltipBackgroundRenderer"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   LabelBackground=TooltipBackgroundRenderer
   PrivateFlags=986
   EventProvider=None
   Name="Default__UIToolTip"
   ObjectArchetype=UILabel'Engine.Default__UILabel'
}
