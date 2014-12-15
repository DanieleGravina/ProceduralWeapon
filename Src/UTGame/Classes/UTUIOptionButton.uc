/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Option widget that works similar to a read only combobox.
 */
class UTUIOptionButton extends UTUI_Widget
	native(UI)
	placeable
	implements(UIDataStorePublisher);

/** UI Key Action Events */
const UIKEY_MoveCursorLeft = 'UIKEY_MoveCursorLeft';
const UIKEY_MoveCursorRight = 'UIKEY_MoveCursorRight';

/** Arrow enums. */
enum EOptionButtonArrow
{
	OPTBUT_ArrowLeft,
	OPTBUT_ArrowRight
};

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)


/** Left and right arrow buttons for this widget. */
var instanced UIButton	ArrowLeftButton;
var instanced UIButton	ArrowRightButton;

/**
 * The styles used for the increment, decrement and marker buttons
 */
var		private								UIStyleReference		IncrementStyle;
var		private								UIStyleReference		DecrementStyle;

/** Spacing between buttons and text. */
var(Presentation) UIScreenValue									ButtonSpacing;

/** Component for rendering the button background image */
var(Image)	editinline	const	noclear	UIComp_DrawImage		BackgroundImageComponent;

/** Renders the text displayed by this label */
var(Data)	editinline	const noclear	UIComp_DrawString		StringRenderComponent;

/** Profile settings current index. */
var			transient			int									CurrentIndex;

/** this sound is played when the index is incremented */
var(Sound)				name						IncrementCue;

/** this sound is played when the index is decremented */
var(Sound)				name						DecrementCue;


/** Whether we should wrap the options or not, meaning if the user hits the beginning or the end of the list, they will wrap to the other end of the list. */
var()					bool						bWrapOptions;

/** The data store that this list is bound to */
var(Data)						UIDataStoreBinding		DataSource;

/** the list element provider referenced by DataSource */
var	const	transient			UIListElementProvider	DataProvider;

/** If true, this widget won't attempt to align it's children */
var() bool bCustomPlacement;

/**
 * @return TRUE if the CurrentIndex is at the start of the ValueMappings array, FALSE otherwise.
 */
native function bool HasPrevValue();

/**
 * @return TRUE if the CurrentIndex is at the start of the ValueMappings array, FALSE otherwise.
 */
native function bool HasNextValue();

/**
 * Moves the current index back by 1 in the valuemappings array if it isn't already at the front of the array.
 */
native function SetPrevValue();

/**
 * Moves the current index forward by 1 in the valuemappings array if it isn't already at the end of the array.
 */
native function SetNextValue();

event Initialized()
{
	Super.Initialized();

	VerifyArrowButtons();

}

// since we now manage the styles for our internal buttons, make sure we're actually the owner of the button. (no flags were set on the buttons so you could reparent them in the editor)
function VerifyArrowButtons()
{
	if ( ArrowLeftButton != None && ArrowLeftButton.Outer != Self )
	{
		WarnInternal(Name $  ".ArrowLeftButton (" $ ArrowLeftButton.Name $ ") has been reparented to " $ ArrowLeftButton.Outer $ "!  This will trigger an assertion in the style system because UTUIOptionButton is responsible for resolving its style.  This must be fixed by a programmer - set the PrivateFlags for UTUIOptionButton.LeftArrowButtonTemplate object to 0, then reparent the button to this widget.");
	}
	if ( ArrowRightButton != None && ArrowRightButton.Outer != Self )
	{
		WarnInternal(Name $  ".ArrowRightButton (" $ ArrowRightButton.Name $ ") has been reparented to " $ ArrowRightButton.Outer $ "!  This will trigger an assertion in the style system because UTUIOptionButton is responsible for resolving its style.  This must be fixed by a programmer - set the PrivateFlags for UTUIOptionButton.ArrowRightButtonTempate object to 0, then reparent the button to this widget.");
	}
}

/** Called after the widget is done initializing. */
event PostInitialize()
{
	Super.PostInitialize();

	ArrowLeftButton.OnClicked = OnArrowLeft_Clicked;
	ArrowRightButton.OnClicked = OnArrowRight_Clicked;
}

/** Moves the current selection to the left. */
event OnMoveSelectionLeft(int PlayerIndex)
{
	if(HasPrevValue())
	{
		// Move to the prev value
		SetPrevValue();

		// Play the decrement sound
		PlayUISound(DecrementCue,PlayerIndex);
	}
}

/** Moves the current selection to the right. */
event OnMoveSelectionRight(int PlayerIndex)
{
	if(HasNextValue())
	{
		// Move to the next value
		SetNextValue();

		// Play the increment sound
		PlayUISound(IncrementCue,PlayerIndex);
	}
}

/** Arrow left clicked callback. */
function bool OnArrowLeft_Clicked(UIScreenObject InButton, int PlayerIndex)
{
	if(IsFocused()==false)
	{
		SetFocus(none);
	}

	OnMoveSelectionLeft(PlayerIndex);
	return true;
}

/** Arrow right clicked callback. */
function bool OnArrowRight_Clicked(UIScreenObject InButton, int PlayerIndex)
{
	if(IsFocused()==false)
	{
		SetFocus(none);
	}

	OnMoveSelectionRight(PlayerIndex);
	return true;
}

/** @return Returns the current index of the optionbutton. */
native function int GetCurrentIndex();

/**
 * Sets a new index for the option button.
 *
 * @param NewIndex		New index for the option button.
 */
native function SetCurrentIndex(INT NewIndex);



/** UIDataSourceSubscriber interface */
/**
 * Sets the data store binding for this object to the text specified.
 *
 * @param	MarkupText			a markup string which resolves to data exposed by a data store.  The expected format is:
 *								<DataStoreTag:DataFieldTag>
 * @param	BindingIndex		optional parameter for indicating which data store binding is being requested for those
 *								objects which have multiple data store bindings.  How this parameter is used is up to the
 *								class which implements this interface, but typically the "primary" data store will be index 0.
 */
native final virtual function SetDataStoreBinding( string MarkupText, optional int BindingIndex=INDEX_NONE );

/**
 * Retrieves the markup string corresponding to the data store that this object is bound to.
 *
 * @param	BindingIndex		optional parameter for indicating which data store binding is being requested for those
 *								objects which have multiple data store bindings.  How this parameter is used is up to the
 *								class which implements this interface, but typically the "primary" data store will be index 0.
 *
 * @return	a datastore markup string which resolves to the datastore field that this object is bound to, in the format:
 *			<DataStoreTag:DataFieldTag>
 */
native final virtual function string GetDataStoreBinding( optional int BindingIndex=INDEX_NONE ) const;

/**
 * Resolves this subscriber's data store binding and updates the subscriber with the current value from the data store.
 *
 * @return	TRUE if this subscriber successfully resolved and applied the updated value.
 */
native final virtual function bool RefreshSubscriberValue( optional int BindingIndex=INDEX_NONE );

/**
 * Handler for the UIDataStore.OnDataStoreValueUpdated delegate.  Used by data stores to indicate that some data provided by the data
 * has changed.  Subscribers should use this function to refresh any data store values being displayed with the updated value.
 * notify subscribers when they should refresh their values from this data store.
 *
 * @param	SourceDataStore		the data store that generated the refresh notification; useful for subscribers with multiple data store
 *								bindings, to tell which data store sent the notification.
 * @param	PropertyTag			the tag associated with the data field that was updated; Subscribers can use this tag to determine whether
 *								there is any need to refresh their data values.
 * @param	SourceProvider		for data stores which contain nested providers, the provider that contains the data which changed.
 * @param	ArrayIndex			for collection fields, indicates which element was changed.  value of INDEX_NONE indicates not an array
 *								or that the entire array was updated.
 */
native function NotifyDataStoreValueUpdated( UIDataStore SourceDataStore, bool bValuesInvalidated, name PropertyTag, UIDataProvider SourceProvider, int ArrayIndex );

/**
 * Retrieves the list of data stores bound by this subscriber.
 *
 * @param	out_BoundDataStores		receives the array of data stores that subscriber is bound to.
 */
native final virtual function GetBoundDataStores( out array<UIDataStore> out_BoundDataStores );

/**
 * Notifies this subscriber to unbind itself from all bound data stores
 */
native final virtual function ClearBoundDataStores();

/** UIDataSourcePublisher interface */

/**
 * Resolves this subscriber's data store binding and publishes this subscriber's value to the appropriate data store.
 *
 * @param	out_BoundDataStores	contains the array of data stores that widgets have saved values to.  Each widget that
 *								implements this method should add its resolved data store to this array after data values have been
 *								published.  Once SaveSubscriberValue has been called on all widgets in a scene, OnCommit will be called
 *								on all data stores in this array.
 * @param	BindingIndex		optional parameter for indicating which data store binding is being requested for those
 *								objects which have multiple data store bindings.  How this parameter is used is up to the
 *								class which implements this interface, but typically the "primary" data store will be index 0.
 *
 * @return	TRUE if the value was successfully published to the data store.
 */
native virtual function bool SaveSubscriberValue( out array<UIDataStore> out_BoundDataStores, optional int BindingIndex=INDEX_NONE );

defaultproperties
{
   Begin Object Class=UIButton Name=LeftArrowButtonTemplate ObjName=LeftArrowButtonTemplate Archetype=UIButton'Engine.Default__UIButton'
      Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
      End Object
      WidgetTag="butArrowLeft"
      TabIndex=0
      PrivateFlags=2087
      Position=(Value[0]=0.603122,Value[1]=0.125000,Value[2]=0.209372,Value[3]=0.750006)
      Name="LeftArrowButtonTemplate"
      ObjectArchetype=UIButton'Engine.Default__UIButton'
   End Object
   ArrowLeftButton=UIButton'UTGame.Default__UTUIOptionButton:LeftArrowButtonTemplate'
   Begin Object Class=UIButton Name=RightArrowButtonTemplate ObjName=RightArrowButtonTemplate Archetype=UIButton'Engine.Default__UIButton'
      Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
         ObjectArchetype=UIComp_DrawImage'Engine.Default__UIButton:BackgroundImageTemplate'
      End Object
      Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
         ObjectArchetype=UIComp_Event'Engine.Default__UIButton:WidgetEventComponent'
      End Object
      WidgetTag="butArrowRight"
      TabIndex=1
      PrivateFlags=2087
      Position=(Value[0]=0.790628,Value[1]=0.125000,Value[2]=0.209372,Value[3]=0.750000)
      Name="RightArrowButtonTemplate"
      ObjectArchetype=UIButton'Engine.Default__UIButton'
   End Object
   ArrowRightButton=UIButton'UTGame.Default__UTUIOptionButton:RightArrowButtonTemplate'
   IncrementStyle=(DefaultStyleTag="DefaultOptionButtonRightArrowStyle",RequiredStyleClass=Class'Engine.UIStyle_Image')
   DecrementStyle=(DefaultStyleTag="DefaultOptionButtonLeftArrowStyle",RequiredStyleClass=Class'Engine.UIStyle_Image')
   ButtonSpacing=(ScaleType=EVALPOS_PixelOwner)
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Background Image Style"
      ImageStyle=(DefaultStyleTag="OptionButtonBackground")
      Name="BackgroundImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   Begin Object Class=UIComp_DrawString Name=LabelStringRenderer ObjName=LabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
      StyleResolverTag="Caption Style"
      StringStyle=(DefaultStyleTag="DefaultOptionButtonStyle")
      Name="LabelStringRenderer"
      ObjectArchetype=UIComp_DrawString'Engine.Default__UIComp_DrawString'
   End Object
   StringRenderComponent=LabelStringRenderer
   IncrementCue="SliderIncrement"
   DecrementCue="SliderDecrement"
   bWrapOptions=True
   DataSource=(RequiredFieldType=DATATYPE_Collection)
   Position=(Value[2]=256.000000,Value[3]=32.000000,ScaleType[2]=EVALPOS_PixelOwner,ScaleType[3]=EVALPOS_PixelOwner)
   DefaultStates(2)=Class'Engine.UIState_Focused'
   DefaultStates(3)=Class'Engine.UIState_Active'
   DefaultStates(4)=Class'Engine.UIState_Pressed'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'UTGame.Default__UTUI_Widget:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'UTGame.Default__UTUI_Widget:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIOptionButton"
   ObjectArchetype=UTUI_Widget'UTGame.Default__UTUI_Widget'
}
