/**
 * Base class for all widgets which act as containers or grouping boxes for other widgets.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIContainer extends UIObject
	notplaceable
	HideDropDown
	native(UIPrivate);

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

/** optional component for auto-aligning children of this panel */
var(Presentation)							UIComp_AutoAlignment	AutoAlignment;

/* === Unrealscript === */

defaultproperties
{
   DefaultStates(2)=Class'Engine.UIState_Focused'
   Begin Object Class=UIComp_Event Name=WidgetEventComponent ObjName=WidgetEventComponent Archetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
      ObjectArchetype=UIComp_Event'Engine.Default__UIObject:WidgetEventComponent'
   End Object
   EventProvider=WidgetEventComponent
   Name="Default__UIContainer"
   ObjectArchetype=UIObject'Engine.Default__UIObject'
}
