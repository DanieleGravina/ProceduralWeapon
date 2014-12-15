/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Checkbox widget that works with collection datasources.
 */
class UTUICollectionCheckBox extends UICheckbox
	native(UI)
	placeable;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** the list element provider referenced by DataSource */
var	const	transient			UIListElementProvider	DataProvider;

/**
 * Changed the checked state of this checkbox and activates a checked event.
 *
 * @param	bShouldBeChecked	TRUE to turn the checkbox on, FALSE to turn it off
 * @param	PlayerIndex			the index of the player that generated the call to SetValue; used as the PlayerIndex when activating
 *								UIEvents; if not specified, the value of GetBestPlayerIndex() is used instead.
 */
native function SetValue( bool bShouldBeChecked, optional int PlayerIndex=INDEX_NONE );

defaultproperties
{
   ValueDataSource=(RequiredFieldType=DATATYPE_Collection)
   Begin Object Class=UIComp_DrawImage Name=CheckedImageTemplate ObjName=CheckedImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UICheckbox:CheckedImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UICheckbox:CheckedImageTemplate'
   End Object
   CheckedImageComponent=CheckedImageTemplate
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UICheckbox:BackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UICheckbox:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UICheckbox:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UICheckbox:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UTUICollectionCheckBox"
   ObjectArchetype=UICheckbox'Engine.Default__UICheckbox'
}
