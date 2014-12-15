/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Container class that holds multiple UTUIButtonBarButton instances.  This class autopositions itself and its buttons at the bottom of the screen.
 */
class UTUIButtonBar extends UTUI_Widget
	placeable
	dependson(UIButton)
	native(UI);

const UTUIBUTTONBAR_MAX_BUTTONS	= 6;
const UTUIBUTTONBAR_BUTTON_SPACING = -20;

/** Array of actual label buttons for the button bar. */
var instanced UTUIButtonBarButton		Buttons[UTUIBUTTONBAR_MAX_BUTTONS];
/** Scaling factor to be applied to all buttons */
var Vector2D ButtonStringScale;
/** Flag indicating that the button scales require a reset */
var bool bResetButtonScale;
























































































































 



#linenumber 21

event PostInitialize()
{
	local int ButtonIdx;

	Super.PostInitialize();

	// Setup button properties.
	for(ButtonIdx=0; ButtonIdx<UTUIBUTTONBAR_MAX_BUTTONS; ButtonIdx++)
	{
		// Hide all buttons by default.
		Buttons[ButtonIdx].SetVisibility(false);
		Buttons[ButtonIdx].TabIndex = UTUIBUTTONBAR_MAX_BUTTONS - 1 - ButtonIdx;
		Buttons[ButtonIdx].DockTargets.bLockWidthWhenDocked = true;

		// Setup docking.
		if(ButtonIdx > 0)
		{
			Buttons[ButtonIdx].SetDockParameters(UIFACE_Right, Buttons[ButtonIdx-1], UIFACE_Left, UTUIBUTTONBAR_BUTTON_SPACING);
		}
		else
		{
			Buttons[ButtonIdx].SetDockParameters(UIFACE_Right, self, UIFACE_Right, 0);
		}

		Buttons[ButtonIdx].StringRenderComponent.EnableAutoSizing(UIORIENT_Horizontal, true);
	}
}

/**
 * Play an animation on this UIObject
 *
 * @Param AnimName			The Name of the Animation to play
 * @Param AnimSeq			Optional, A Sequence Template.  If that's set, we use it instead
 * @Param PlaybackRate  	Optional, How fast to play back the sequence
 * @Param InitialPosition	Optional, Where in the sequence should we start
 *
 */
event PlayUIAnimation(name AnimName, optional UIAnimationSeq AnimSeqTemplate,
						optional float PlaybackRate=1.0,optional bool bLoop, optional float InitialPosition=0.0)
{
	if ( AnimName == 'ButtonBarShow' )
	{
		StopUIAnimation('ButtonBarHide');
	}
	else if ( AnimName == 'ButtonBarHide' )
	{
		StopUIAnimation('ButtonBarShow');
	}

	Super.PlayUIAnimation(AnimName, AnimSeqTemplate, PlaybackRate, bLoop, InitialPosition);
}

/**
 * Appends a button to the button bar.
 *
 * @param ButtonTextMarkup	Markup for the button's caption
 * @param ButtonDelegate	Delegate to call when the button is clicked on.
 */
function int AppendButton(string ButtonTextMarkup, delegate<UIObject.OnClicked> ButtonDelegate)
{
	local int ButtonIdx;

	for(ButtonIdx=0; ButtonIdx<UTUIBUTTONBAR_MAX_BUTTONS; ButtonIdx++)
	{
		if ( Buttons[ButtonIdx].IsHidden() )
		{
			SetButton(ButtonIdx, ButtonTextMarkup, ButtonDelegate);
			return ButtonIdx;
		}
	}
	return INDEX_None;
}

/** Sets information for one of the button bar buttons. */
function SetButton(int ButtonIndex, string ButtonTextMarkup, delegate<UIObject.OnClicked> ButtonDelegate)
{
	Assert(ButtonIndex >= 0 && ButtonIndex<UTUIBUTTONBAR_MAX_BUTTONS);

	// Reset button scaling, since our set of buttons has changed
	ButtonStringScale.X = 1.0f;
	ButtonStringScale.Y = 1.0f;
	bResetButtonScale = true;

	Buttons[ButtonIndex].SetVisibility(true);
	Buttons[ButtonIndex].SetEnabled(true);
	Buttons[ButtonIndex].SetDatastoreBinding(ButtonTextMarkup);
	Buttons[ButtonIndex].OnClicked=ButtonDelegate;
}

function ClearButton(int ButtonIndex)
{
	Assert(ButtonIndex >= 0 && ButtonIndex<UTUIBUTTONBAR_MAX_BUTTONS);

	Buttons[ButtonIndex].SetVisibility(false);
	Buttons[ButtonIndex].SetDatastoreBinding("");
	Buttons[ButtonIndex].OnClicked=none;
}

/** Clears all set buttons. */
function Clear()
{
	local int ButtonIdx;

	for(ButtonIdx=0; ButtonIdx<UTUIBUTTONBAR_MAX_BUTTONS; ButtonIdx++)
	{
		// Hide all buttons by default.
		Buttons[ButtonIdx].SetVisibility(false);
		Buttons[ButtonIdx].SetDatastoreBinding("");
		Buttons[ButtonIdx].OnClicked=none;
	}
}

/**
 * Used to toggle a button on/off
 */
function ToggleButton(int ButtonIdx, bool bActive)
{
	Assert(ButtonIdx >= 0 && ButtonIdx<UTUIBUTTONBAR_MAX_BUTTONS);

	Buttons[ButtonIdx].SetVisibility(bActive);
}

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
   Begin Object Class=UTUIButtonBarButton Name=ButtonTemplate0 ObjName=ButtonTemplate0 Archetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
      Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'UTGame.Default__UTUIButtonBarButton:ButtonBarStringRenderer'
         ObjectArchetype=UIComp_DrawString'ButtonBarStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'UTGame.Default__UTUIButtonBarButton:ButtonBarBackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'ButtonBarBackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIButtonBarButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      CaptionDataSource=(MarkupString="Button 0")
      WidgetTag="butButtonBarButton0"
      TabIndex=0
      Position=(Value[0]=0.900000,Value[2]=0.100000,Value[3]=0.700000)
      Name="ButtonTemplate0"
      ObjectArchetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
   End Object
   Buttons(0)=UTUIButtonBarButton'UTGame.Default__UTUIButtonBar:ButtonTemplate0'
   Begin Object Class=UTUIButtonBarButton Name=ButtonTemplate1 ObjName=ButtonTemplate1 Archetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
      Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'UTGame.Default__UTUIButtonBarButton:ButtonBarStringRenderer'
         ObjectArchetype=UIComp_DrawString'ButtonBarStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'UTGame.Default__UTUIButtonBarButton:ButtonBarBackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'ButtonBarBackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIButtonBarButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      CaptionDataSource=(MarkupString="Button 1")
      WidgetTag="butButtonBarButton1"
      TabIndex=1
      Position=(Value[0]=0.900000,Value[2]=0.100000,Value[3]=0.700000)
      Name="ButtonTemplate1"
      ObjectArchetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
   End Object
   Buttons(1)=UTUIButtonBarButton'UTGame.Default__UTUIButtonBar:ButtonTemplate1'
   Begin Object Class=UTUIButtonBarButton Name=ButtonTemplate2 ObjName=ButtonTemplate2 Archetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
      Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'UTGame.Default__UTUIButtonBarButton:ButtonBarStringRenderer'
         ObjectArchetype=UIComp_DrawString'ButtonBarStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'UTGame.Default__UTUIButtonBarButton:ButtonBarBackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'ButtonBarBackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIButtonBarButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      CaptionDataSource=(MarkupString="Button 2")
      WidgetTag="butButtonBarButton2"
      TabIndex=2
      Position=(Value[0]=0.900000,Value[2]=0.100000,Value[3]=0.700000)
      Name="ButtonTemplate2"
      ObjectArchetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
   End Object
   Buttons(2)=UTUIButtonBarButton'UTGame.Default__UTUIButtonBar:ButtonTemplate2'
   Begin Object Class=UTUIButtonBarButton Name=ButtonTemplate3 ObjName=ButtonTemplate3 Archetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
      Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'UTGame.Default__UTUIButtonBarButton:ButtonBarStringRenderer'
         ObjectArchetype=UIComp_DrawString'ButtonBarStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'UTGame.Default__UTUIButtonBarButton:ButtonBarBackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'ButtonBarBackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIButtonBarButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      CaptionDataSource=(MarkupString="Button 3")
      WidgetTag="butButtonBarButton3"
      TabIndex=3
      Position=(Value[0]=0.900000,Value[2]=0.100000,Value[3]=0.700000)
      Name="ButtonTemplate3"
      ObjectArchetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
   End Object
   Buttons(3)=UTUIButtonBarButton'UTGame.Default__UTUIButtonBar:ButtonTemplate3'
   Begin Object Class=UTUIButtonBarButton Name=ButtonTemplate4 ObjName=ButtonTemplate4 Archetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
      Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'UTGame.Default__UTUIButtonBarButton:ButtonBarStringRenderer'
         ObjectArchetype=UIComp_DrawString'ButtonBarStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'UTGame.Default__UTUIButtonBarButton:ButtonBarBackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'ButtonBarBackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIButtonBarButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      CaptionDataSource=(MarkupString="Button 4")
      WidgetTag="butButtonBarButton4"
      TabIndex=4
      Position=(Value[0]=0.900000,Value[2]=0.100000,Value[3]=0.700000)
      Name="ButtonTemplate4"
      ObjectArchetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
   End Object
   Buttons(4)=UTUIButtonBarButton'UTGame.Default__UTUIButtonBar:ButtonTemplate4'
   Begin Object Class=UTUIButtonBarButton Name=ButtonTemplate5 ObjName=ButtonTemplate5 Archetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
      Begin Object Class=UIComp_DrawString Name=ButtonBarStringRenderer ObjName=ButtonBarStringRenderer Archetype=UIComp_DrawString'UTGame.Default__UTUIButtonBarButton:ButtonBarStringRenderer'
         ObjectArchetype=UIComp_DrawString'ButtonBarStringRenderer'
      End Object
      Begin Object Class=UIComp_DrawImage Name=ButtonBarBackgroundImageTemplate ObjName=ButtonBarBackgroundImageTemplate Archetype=UIComp_DrawImage'UTGame.Default__UTUIButtonBarButton:ButtonBarBackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'ButtonBarBackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUIButtonBarButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'WidgetEventComponent'
      End Object
      CaptionDataSource=(MarkupString="Button 5")
      WidgetTag="butButtonBarButton5"
      TabIndex=5
      Position=(Value[0]=0.900000,Value[2]=0.100000,Value[3]=0.700000)
      Name="ButtonTemplate5"
      ObjectArchetype=UTUIButtonBarButton'UTGame.Default__UTUIButtonBarButton'
   End Object
   Buttons(5)=UTUIButtonBarButton'UTGame.Default__UTUIButtonBar:ButtonTemplate5'
   ButtonStringScale=(X=1.000000,Y=1.000000)
   bRequiresTick=True
   Position=(Value[1]=0.950000,Value[3]=0.050000)
   DefaultStates(2)=Class'Engine.UIState_Focused'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUI_Widget:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUI_Widget:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIButtonBar"
   ObjectArchetype=UTUI_Widget'UTGame.Default__UTUI_Widget'
}
