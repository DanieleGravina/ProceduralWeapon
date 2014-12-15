/**
 *
 * Copyright 1998-2008 Epic Games, Inc. All Rights Reserved.
 */


/**
 * This action gets the widget that was last focused for a specified parent.
 */
class UIAction_GetLastFocused extends UIAction
	native(inherit);

/** Parent that we are searching in for the last focused item.  If NULL the scene is used. */
var() UIScreenObject		Parent;

/** The item that was last focused, this var is used for the writeable variable link. */
var() UIScreenObject		LastFocused;

// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)
// (cpptext)

defaultproperties
{
   OutputLinks(0)=(LinkDesc="Success")
   OutputLinks(1)=(LinkDesc="Failed")
   VariableLinks(0)=(LinkDesc="Parent",PropertyName="Parent",MaxVars=1)
   VariableLinks(1)=(ExpectedType=Class'Engine.SeqVar_Object',LinkDesc="Last Focused",PropertyName="LastFocused",bHidden=False)
   ObjName="Get Last Focused"
   Name="Default__UIAction_GetLastFocused"
   ObjectArchetype=UIAction'Engine.Default__UIAction'
}
