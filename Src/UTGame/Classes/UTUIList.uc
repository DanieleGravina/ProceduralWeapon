/**
* Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
*
* Extended version of UIList for UT3.
*/
class UTUIList extends UIList
	native(UI);

/**
 * Optional component for rendering a background image for this list.  No value given by default.
 */
var(Presentation)	editinline	const	UIComp_DrawImage		BackgroundImageComponent;

/** Whether or not this list should be able to save out to its dataprovider. */
var transient bool bAllowSaving;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
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
   Begin Object Class=UIComp_ListPresenter Name=ListPresentationComponent ObjName=ListPresentationComponent Archetype=UIComp_ListPresenter'Engine.Default__UIList:ListPresentationComponent'
      Begin Object Class=UITexture Name=NormalOverlayTemplate ObjName=NormalOverlayTemplate Archetype=UITexture'Engine.Default__UIList:ListPresentationComponent.NormalOverlayTemplate'
         ObjectArchetype=UITexture'Engine.Default__UIList:ListPresentationComponent.NormalOverlayTemplate'
      End Object
      Begin Object Class=UITexture Name=ActiveOverlayTemplate ObjName=ActiveOverlayTemplate Archetype=UITexture'Engine.Default__UIList:ListPresentationComponent.ActiveOverlayTemplate'
         ObjectArchetype=UITexture'Engine.Default__UIList:ListPresentationComponent.ActiveOverlayTemplate'
      End Object
      Begin Object Class=UITexture Name=SelectionOverlayTemplate ObjName=SelectionOverlayTemplate Archetype=UITexture'Engine.Default__UIList:ListPresentationComponent.SelectionOverlayTemplate'
         ObjectArchetype=UITexture'Engine.Default__UIList:ListPresentationComponent.SelectionOverlayTemplate'
      End Object
      Begin Object Class=UITexture Name=HoverOverlayTemplate ObjName=HoverOverlayTemplate Archetype=UITexture'Engine.Default__UIList:ListPresentationComponent.HoverOverlayTemplate'
         ObjectArchetype=UITexture'Engine.Default__UIList:ListPresentationComponent.HoverOverlayTemplate'
      End Object
      ListItemOverlay(0)=UITexture'UTGame.Default__UTUIList:ListPresentationComponent.NormalOverlayTemplate'
      ListItemOverlay(1)=UITexture'UTGame.Default__UTUIList:ListPresentationComponent.ActiveOverlayTemplate'
      ListItemOverlay(2)=UITexture'UTGame.Default__UTUIList:ListPresentationComponent.SelectionOverlayTemplate'
      ListItemOverlay(3)=UITexture'UTGame.Default__UTUIList:ListPresentationComponent.HoverOverlayTemplate'
      ObjectArchetype=UIComp_ListPresenter'Engine.Default__UIList:ListPresentationComponent'
   End Object
   CellDataComponent=ListPresentationComponent
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIList:WidgetEventComponent'
      DisabledEventAliases(0)="NavFocusUp"
      DisabledEventAliases(1)="NavFocusDown"
      ObjectArchetype=UIComp_Event'Engine.Default__UIList:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUIList"
   ObjectArchetype=UIList'Engine.Default__UIList'
}
