/**
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 *
 * Option widget that works similar to a read only combobox.
 */
class UIOptionList extends UIOptionListBase
	native(UIPrivate)
	placeable;

/** Current index in the datastore */
var	transient 			int						CurrentIndex;

/** the list element provider referenced by DataSource */
var	transient	const	UIListElementProvider	DataProvider;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
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
/**
* @param ListIndex		List index to get the value of.
* @param OutValue		Storage string for the list value
*
* @return Returns TRUE if we were able to get a value, FALSE otherwise
*/
native final function bool GetListValue( int ListIndex, out string OutValue );

/**
 * Decrements the widget to the previous value
 */
native function SetPrevValue();

/**
 * Increments the widget to the next value
 */
native function SetNextValue();

/** @return Returns the current index of the optionbutton. */
native function int GetCurrentIndex() const;

/**
 * Sets a new index for the option button.
 *
 * @param NewIndex		New index for the option button.
 */
native function SetCurrentIndex( int NewIndex );


/* == Kismet action handlers == */
protected final function OnSetListIndex( UIAction_SetListIndex Action )
{
	local int OutputLinkIndex;

	// For now always active the success link
	OutputLinkIndex = 0;

	if ( Action != None )
	{
		LogInternal("SADSADSA: "$Action.NewIndex);
		SetCurrentIndex(Action.NewIndex);

		// activate the appropriate output link on the action
		if ( !Action.OutputLinks[OutputLinkIndex].bDisabled )
		{
			Action.OutputLinks[OutputLinkIndex].bHasImpulse = true;
		}
	}
}

defaultproperties
{
   DecrementButton=UIOptionListButton'Engine.Default__UIOptionList:DecrementButtonTemplate'
   IncrementButton=UIOptionListButton'Engine.Default__UIOptionList:IncrementButtonTemplate'
   Begin Object Class=UIComp_DrawImage Name=BackgroundImageTemplate ObjName=BackgroundImageTemplate Archetype=UIComp_DrawImage'Engine.Default__UIOptionListBase:BackgroundImageTemplate'
      ObjectArchetype=UIComp_DrawImage'Engine.Default__UIOptionListBase:BackgroundImageTemplate'
   End Object
   BackgroundImageComponent=BackgroundImageTemplate
   Begin Object Class=UIComp_DrawString Name=LabelStringRenderer ObjName=LabelStringRenderer Archetype=UIComp_DrawString'Engine.Default__UIOptionListBase:LabelStringRenderer'
      ObjectArchetype=UIComp_DrawString'Engine.Default__UIOptionListBase:LabelStringRenderer'
   End Object
   StringRenderComponent=LabelStringRenderer
   Children(0)=UIOptionListButton'Engine.Default__UIOptionList:DecrementButtonTemplate'
   Children(1)=UIOptionListButton'Engine.Default__UIOptionList:IncrementButtonTemplate'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIOptionListBase:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIOptionListBase:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIOptionList"
   ObjectArchetype=UIOptionListBase'Engine.Default__UIOptionListBase'
}
