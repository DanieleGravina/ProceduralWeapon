/**
 * This  widget allows the user to type numeric text into an input field.
 * The value of the text in the input field can be incremented and decremented through the buttons associated with this widget.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * @todo - selection highlight support
 */
class UINumericEditBox extends UIEditBox
	native(inherit);

/** the style to use for the editbox's increment button */
var(Style)									UIStyleReference		IncrementStyle;

/** the style to use for the editbox's decrement button */
var(Style)									UIStyleReference		DecrementStyle;

/** Buttons that can be used to increment and decrement the value stored in the input field. */
var		private								UINumericEditBoxButton	IncrementButton;
var		private								UINumericEditBoxButton	DecrementButton;

/**
 * The value and range parameters for this numeric editbox.
 */
var(Text)									UIRangeData				NumericValue;

/** The number of digits after the decimal point. */
var(Text)									int						DecimalPlaces;

/** The position of the faces of the increment button. */
var(Buttons)								UIScreenValue_Bounds	IncButton_Position;

/** The position of the faces of the Decrement button. */
var(Buttons)								UIScreenValue_Bounds	DecButton_Position;


// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/**
 * Increments the numeric editbox's value.
 *
 * @param	EventObject	Object that issued the event.
 * @param	PlayerIndex	Player that performed the action that issued the event.
 */
native final function IncrementValue( UIScreenObject Sender, int PlayerIndex );

/**
 * Decrements the numeric editbox's value.
 *
 * @param	EventObject	Object that issued the event.
 * @param	PlayerIndex	Player that performed the action that issued the event.
 */
native final function DecrementValue( UIScreenObject Sender, int PlayerIndex );

/**
 * Initializes the clicked delegates in the increment and decrement buttons to use the editbox's increment and decrement functions.
 * @todo - this is a fix for the issue where delegates don't seem to be getting set properly in defaultproperties blocks.
 */
event Initialized()
{
	local int ModifierFlags;

	Super.Initialized();

	IncrementButton.OnPressed = IncrementValue;
	IncrementButton.OnPressRepeat = IncrementValue;

	DecrementButton.OnPressed = DecrementValue;
	DecrementButton.OnPressRepeat = DecrementValue;

	ModifierFlags = PRIVATE_NotFocusable|PRIVATE_NotDockable|PRIVATE_TreeHidden|PRIVATE_NotEditorSelectable|PRIVATE_ManagedStyle;

	if ( !IncrementButton.IsPrivateBehaviorSet(ModifierFlags) )
	{
		IncrementButton.SetPrivateBehavior(ModifierFlags, true);
	}
	if ( !DecrementButton.IsPrivateBehaviorSet(ModifierFlags) )
	{
		DecrementButton.SetPrivateBehavior(ModifierFlags, true);
	}
}

/**
 * Propagate the enabled state of this widget.
 */
event PostInitialize()
{
	Super.PostInitialize();

	// when this widget is enabled/disabled, its children should be as well.
	ConditionalPropagateEnabledState(GetBestPlayerIndex());
}

/**
 * Change the value of this numeric editbox at runtime. Takes care of conversion from float to internal value string.
 *
 * @param	NewValue				the new value for the editbox.
 * @param	bForceRefreshString		Forces a refresh of the string component, normally the string is only refreshed when the value is different from the current value.
 *
 * @return	TRUE if the editbox's value was changed
 */
native final function bool SetNumericValue( float NewValue, optional bool bForceRefreshString=false );

/**
 * Gets the current value of this numeric editbox.
 */
native final function float GetNumericValue( ) const;

defaultproperties
{
   IncrementStyle=(DefaultStyleTag="ButtonBackground",RequiredStyleClass=Class'Engine.UIStyle_Image')
   DecrementStyle=(DefaultStyleTag="ButtonBackground",RequiredStyleClass=Class'Engine.UIStyle_Image')
   NumericValue=(MaxValue=100.000000,NudgeValue=1.000000)
   DecimalPlaces=4
   IncButton_Position=(Value[2]=1.000000,Value[3]=1.000000,ScaleType[0]=EVALPOS_PercentageOwner,ScaleType[1]=EVALPOS_PercentageOwner,ScaleType[2]=EVALPOS_PercentageOwner,ScaleType[3]=EVALPOS_PercentageOwner)
   DecButton_Position=(Value[2]=1.000000,Value[3]=1.000000,ScaleType[0]=EVALPOS_PercentageOwner,ScaleType[1]=EVALPOS_PercentageOwner,ScaleType[2]=EVALPOS_PercentageOwner,ScaleType[3]=EVALPOS_PercentageOwner)
   DataSource=(RequiredFieldType=DATATYPE_RangeProperty,MarkupString="Numeric Editbox Text")
   Begin Object Class=UIComp_DrawStringEditbox Name=EditboxStringRenderer ObjName=EditboxStringRenderer Archetype=UIComp_DrawStringEditbox'Engine.Default__UIEditBox:EditboxStringRenderer'
      ObjectArchetype=UIComp_DrawStringEditbox'Engine.Default__UIEditBox:EditboxStringRenderer'
   End Object
   StringRenderComponent=EditboxStringRenderer
   Begin Object Class=UIComp_DrawImage Name=EditboxBackgroundTemplate ObjName=EditboxBackgroundTemplate Archetype=UIComp_DrawImage'Engine.Default__UIEditBox:EditboxBackgroundTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIEditBox:EditboxBackgroundTemplate'
   End Object
   BackgroundImageComponent=EditboxBackgroundTemplate
   CharacterSet=CHARSET_NumericOnly
   PrivateFlags=1024
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIEditBox:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIEditBox:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UINumericEditBox"
   ObjectArchetype=UIEditBox'Engine.Default__UIEditBox'
}
