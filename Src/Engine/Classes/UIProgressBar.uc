/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */



class UIProgressBar extends UIObject
	native(UIPrivate)
	implements(UIDataStorePublisher);

/** Component for rendering the background image */
var(Image)	editinline	const	noclear	UIComp_DrawImage		BackgroundImageComponent;

/** Component for rendering the fill image */
var(Image)	editinline	const	noclear	UIComp_DrawImage		FillImageComponent;

/** Component for rendering the overlay image */
var(Image)	editinline	const	noclear	UIComp_DrawImage		OverlayImageComponent;

/**
 * specifies whether to draw the overlay texture or not
 */
var(Image)									bool					bDrawOverlay;

/**
 * The data source that this progressbar's value will be linked to.
 */
var(Data)	editconst private				UIDataStoreBinding		DataSource;

/**
 * The value and range parameters for this progressbar.
 */
var(ProgressBar)							UIRangeData				ProgressBarValue;

/**
 * Controls whether this progressbar is vertical or horizontal
 */
var(ProgressBar)							EUIOrientation			ProgressBarOrientation;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
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


/* == Kismet action handlers == */
protected final function OnSetProgressBarValue( UIAction_SetProgressBarValue Action )
{
	if ( Action != None )
	{
		SetValue(Action.NewValue, Action.bPercentageValue);
	}
}

protected final function OnGetProgressBarValue( UIAction_GetProgressBarValue Action )
{
	if ( Action != None )
	{
		Action.Value = GetValue(Action.bPercentageValue);
	}
}

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
native final virtual function NotifyDataStoreValueUpdated( UIDataStore SourceDataStore, bool bValuesInvalidated, name PropertyTag, UIDataProvider SourceProvider, int ArrayIndex );

/**
 * Retrieves the list of data stores bound by this subscriber.
 *
 * @param	out_BoundDataStores		receives the array of data stores that subscriber is bound to.
 */
native final virtual function GetBoundDataStores( out array<UIDataStore> out_BoundDataStores );

/**
 * Notifies this subscriber to unbind itself from all bound data stores
 */
native final function ClearBoundDataStores();

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
native final virtual function bool SaveSubscriberValue( out array<UIDataStore> out_BoundDataStores, optional int BindingIndex=INDEX_NONE );

/**
 * Change the value of this progressbar at runtime.
 *
 * @param	NewValue			the new value for the progressbar.
 * @param	bPercentageValue	TRUE indicates that the new value is formatted as a percentage of the total range of this progressbar.
 *
 * @return	TRUE if the progressbar's value was changed
 */
native final function bool SetValue( coerce float NewValue, optional bool bPercentageValue );

/**
 * Gets the current value of this progressbar
 *
 * @param	bPercentageValue	TRUE to format the result as a percentage of the total range of this progressbar.
 */
native final function float GetValue( optional bool bPercentageValue ) const;

/* === Unrealscript === */
/**
 * Changes the background image for this progressbar, creating the wrapper UITexture if necessary.
 *
 * @param	NewBarImage		the new surface to use for the progressbar's background image
 */
final function SetBackgroundImage( Surface NewImage )
{
	if ( BackgroundImageComponent != None )
	{
		BackgroundImageComponent.SetImage(NewImage);
	}
}

/**
 * Changes the fill image for this progressbar, creating the wrapper UITexture if necessary.
 *
 * @param	NewImage		the new surface to use for progressbar's marker
 */
final function SetFillImage( Surface NewImage )
{
	if ( FillImageComponent != None )
	{
		FillImageComponent.SetImage(NewImage);
	}
}

/**
 * Changes the overlay image for this progressbar, creating the wrapper UITexture if necessary.
 *
 * @param	NewOverlayImage		the new surface to use for the progressbar's overlay image
 */
final function SetOverlayImage( Surface NewImage )
{
	if ( OverlayImageComponent != None )
	{
		OverlayImageComponent.SetImage(NewImage);
	}
}

defaultproperties
{
   Begin Object Class=UIComp_DrawImage Name=ProgressBarBackgroundImageTemplate ObjName=ProgressBarBackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Background Image Style"
      ImageStyle=(DefaultStyleTag="DefaultSliderStyle")
      Name="ProgressBarBackgroundImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   BackgroundImageComponent=ProgressBarBackgroundImageTemplate
   Begin Object Class=UIComp_DrawImage Name=ProgressBarFillImageTemplate ObjName=ProgressBarFillImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Fill Image Style"
      ImageStyle=(DefaultStyleTag="DefaultSliderBarStyle")
      Name="ProgressBarFillImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   FillImageComponent=ProgressBarFillImageTemplate
   Begin Object Class=UIComp_DrawImage Name=ProgressBarOverlayImageTemplate ObjName=ProgressBarOverlayImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
      StyleResolverTag="Overlay Image Style"
      Name="ProgressBarOverlayImageTemplate"
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIComp_DrawImage'
   End Object
   OverlayImageComponent=ProgressBarOverlayImageTemplate
   DataSource=(RequiredFieldType=DATATYPE_RangeProperty)
   ProgressBarValue=(CurrentValue=33.000000,MaxValue=100.000000,NudgeValue=1.000000)
   PrimaryStyle=(DefaultStyleTag="DefaultSliderStyle",RequiredStyleClass=Class'Engine.UIStyle_Image')
   bSupportsPrimaryStyle=False
   Position=(Value[3]=32.000000,ScaleType[3]=EVALPOS_PixelOwner)
   DefaultStates(2)=Class'Engine.UIState_Focused'
   DefaultStates(3)=Class'Engine.UIState_Active'
   DefaultStates(4)=Class'Engine.UIState_Pressed'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIProgressBar"
   ObjectArchetype=UIObject'Engine.Default__UIObject'
}
