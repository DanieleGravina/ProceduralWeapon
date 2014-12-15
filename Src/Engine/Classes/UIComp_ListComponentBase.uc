/**
 * Base class for all UIList-related component classes.
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */
class UIComp_ListComponentBase extends UIComponent
	within UIList
	native(UIPrivate)
	HideCategories(Object)
	abstract;

defaultproperties
{
   Name="Default__UIComp_ListComponentBase"
   ObjectArchetype=UIComponent'Engine.Default__UIComponent'
}
